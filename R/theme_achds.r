#' Add ACHDS theme to a ggplot2 chart
#'
#' This function allows you to add the ACHDS theme to your ggplotgraphics.
#' @keywords theme_achds
#' @export
#' @examples
#' line <- ggplot(line_df, aes(x = year, y = lifeExp)) +
#' geom_line(colour = "#007f7f", size = 1) +
#' geom_hline(yintercept = 0, size = 1, colour="#333333") +
#' theme_achds()

theme_achds <- function() {

  # Base is theme_classic
  ggplot2::theme_set(theme_classic())

  # Add additional elements
  ggplot2::theme(

    # Add major y gridline
    panel.grid.major.y = element_line(),

    # Remove boxes for facets
    strip.background = element_blank()
  )

}
