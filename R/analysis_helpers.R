#' create limma code
#'
#' A helper that provides a template for limma code to programmatically
#' set up the differences one wants to extract.
#'
#' @export
#' @family 'Analysis'
#' @return NULL, invisibly
ft_limma_code = function() {
  cat(
    '
  # Assuming you are doing equivalent to a t-test,
  # with two levels.
  # The "var" here is which piece of the "info_df" contains
  # the factors of interest.
  #
  # The order of the "fct" here will
  # determine which one is used for reference (fct_ref)
  # and which one is considered the experimental (fct_exp).
  # 
  # You can change them by changing their ordering here in the contrast
  # vector.  
  contrast = c("var", "fct_ref", "fct_exp")
  
  info_df[[contrast[1]]] = factor(info_df[[contrast[1]]], levels = contrast[c(2,3)]
  
  design_matrix = model.matrix(
    as.formula(paste("~", contrast[1], sep = " ")),
    data = sample_info
  )
  ncol_design = ncol(design_matrix)
  colnames(design_matrix)[ncol_design] = contrast[1]

  use_data = use_data[, info_df$sample_id]
  lm_fit = limma::lmFit(use_data, design_matrix)
  e_fit = limma::eBayes(lm_fit)

  results = limma::topTable(
    e_fit,
    coef = contrast[1],
    number = Inf,
    p.value = 1
  )
  results$feature_id = rownames(results)
  return(results)
'
  )
  return(invisible(NULL))
}
