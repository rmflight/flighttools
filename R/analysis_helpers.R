#' create limma code
#'
#' A helper that provides a template for limma code to programmatically
#' set up the differences one wants to extract.
#'
#' @examples
#' ft_limma_code()
#'
#' @export
#' @family 'Analysis'
#' @return NULL, invisibly
ft_limma_code = function() {
  cat(
    '#\' run limma
#\'
#\' Run limma code between two levels or factors.
#\'
#\' @param data_in a matrix of values, columns are samples
#\' @param data_info data.frame of attributes
#\' @param contrast the attribute, and factors
#\'
#\' @examples
#\' data_in = matrix(rnorm(200), nrow = 10, ncol = 20)
#\' rownames(data_in) = paste0("f", seq(1, 10))
#\' colnames(data_in) = paste0("s", seq(1, 20))
#\' data_in[, 1:10] = data_in[, 1:10] + 2
#\'
#\' data_info = data.frame(sample_id = paste0("s", seq(1, 20)), group = rep(c("g1", "g2"), each = 10))
#\' # g2 is the reference
#\' # LFC should all be positive
#\' contrast = c("group", "g2", "g1")
#\'
#\' run_limma(data_in, data_info, contrast)
#\' # g1 is the reference
#\' # LFC should all be negative
#\' contrast = c("group", "g1", "g2")  
#\' run_limma(data_in, data_info, contrast)
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

  # depending on your data type, you may need to add an extractor,
  # log-transformation, imputation, or combinations of them prior
  # to running the actual limma calculations below

  lm_fit = limma::lmFit(data_in, design_matrix)
  e_fit = limma::eBayes(lm_fit)

  results = limma::topTable(
    e_fit,
    coef = contrast[1],
    number = Inf,
    p.value = 1
  )
  results$feature_id = rownames(results)
  results$contrast = out_contrast
  return(results)
}
'
  )
  return(invisible(NULL))
}
