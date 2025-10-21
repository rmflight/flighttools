#' run limma
#'
#' Run limma code between two levels or factors.
#'
#' @param data_in a matrix of values, columns are samples
#' @param data_info data.frame of attributes
#' @param contrast the attribute, and factors
#'
#' @examples
#' data_in = matrix(rnorm(200), nrow = 10, ncol = 20)
#' rownames(data_in) = paste0("f", seq(1, 10))
#' colnames(data_in) = paste0("s", seq(1, 20))
#'
#' data_info = data.frame(sample_id = paste0("s", seq(1, 20)), group = rep(c("g1", "g2"), each = 10))
#' # g2 is the reference
#' contrast = c("group", "g2", "g1")
#'
#' run_limma(data_in, data_info, contrast)
#' # g1 is the reference
#' contrast = c("group", "g1", "g2")
run_limma = function(data_in, data_info, contrast) {
  data_info[[contrast[1]]] = factor(
    data_info[[contrast[1]]],
    levels = contrast[c(2, 3)]
  )

  design_matrix = model.matrix(
    as.formula(paste("~", contrast[1], sep = " ")),
    data = data_info
  )
  ncol_design = ncol(design_matrix)
  colnames(design_matrix)[ncol_design] = contrast[1]

  out_contrast = paste0(contrast[3], " / ", contrast[2])

  data_in = data_in[, data_info$sample_id]
  lm_fit = limma::lmFit(data_in, design_matrix)
  e_fit = limma::eBayes(lm_fit)

  results = limma::topTable(
    e_fit,
    coef = contrast[1],
    number = Inf,
    p.value = 1
  )
  results$feature_id = rownames(results)
  return(results)
}

test_that('limma code does what we say', {
  data_in = matrix(rnorm(200), nrow = 10, ncol = 20)
  # we add 2 to the samples from g1, so for g1 / g2, we expect positive LFC
  # and then for g2 / g1, we expect negative LFC
  data_in[, 1:10] = data_in[, 1:10] + 2

  rownames(data_in) = paste0("f", seq(1, 10))
  colnames(data_in) = paste0("s", seq(1, 20))

  data_info = data.frame(
    sample_id = paste0("s", seq(1, 20)),
    group = rep(c("g1", "g2"), each = 10)
  )
  # g2 is the reference
  contrast1 = c("group", "g2", "g1")
  out_res1 = run_limma(data_in, data_info, contrast1)
  expect_true(all(out_res1$logFC > 0))

  # g1 is the reference
  contrast2 = c("group", "g1", "g2")
  out_res2 = run_limma(data_in, data_info, contrast2)
  expect_true(all(out_res2$logFC < 0))
})
