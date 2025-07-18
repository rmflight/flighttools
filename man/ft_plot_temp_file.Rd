% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graphics_helpers.R
\name{ft_plot_temp_file}
\alias{ft_plot_temp_file}
\title{save plot to temp}
\usage{
ft_plot_temp_file(
  in_plot = ggplot2::last_plot(),
  filename = "_deleteme_plot.png",
  width = 10,
  height = 8,
  units = "in",
  res = 300,
  ...
)
}
\arguments{
\item{in_plot}{the plot to save}

\item{filename}{the file to save it to. Default is underscore to make it easily findable}

\item{width}{width of the saved plot}

\item{height}{height of the saved plot}

\item{units}{units to use}

\item{res}{the resolution}

\item{...}{other parameters to \code{ragg::agg_png()}}
}
\value{
filename
}
\description{
Take a plot object (default is \code{ggplot2::last_plot()}), and write it to a file
that can be easily found and opened in a VSCode editor pane for a zoomed view of the plot.
}
\seealso{
\code{\link[ragg:agg_png]{ragg::agg_png()}}

Other {Graphics}: 
\code{\link{ft_add_figure_numbers}()},
\code{\link{ft_add_padding}()},
\code{\link{ft_discretize_colorscale}()},
\code{\link{ft_ggplot2_add_ellipse}()},
\code{\link{ft_ggplot2_colors}()},
\code{\link{ft_ggplot2_legend_inside}()},
\code{\link{ft_ggplot2_rotate_axis_labels}()},
\code{\link{ft_ggplot2_self_colors}()},
\code{\link{ft_upset_add_counts}()},
\code{\link{ft_upset_comb_matrix}()}
}
\concept{{Graphics}}
