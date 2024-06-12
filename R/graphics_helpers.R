#' use ggplot2 colors
#' 
#' generates the code for getting some ggplot2 colors
#' 
#' @export
#' @return string
my_ggplot2_colors = function()
{
  cat('ggplot2::scale_color_discrete()$palette(n)', sep = "\n")
}

#' rotate axis labels
#' 
#' Gives me the code to rotate axis labels.
#' 
#' @export
#' @return string
my_rotate_axis_labels = function()
{
  cat('scale_x_discrete(guide = guide_axis(angle = 90))',
      'theme(axis.text.x=element_text(angle = 90)',
      'coord_flip()', sep = "\n\n")
}
