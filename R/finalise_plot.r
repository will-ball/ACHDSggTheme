# Save
save_plot <- function (plot_grid, width, height, save_filepath) {

  grid::grid.draw(plot_grid)

  ggplot2::ggsave(filename = save_filepath,
                  plot=plot_grid, width=(width/72), height=(height/72),  bg="#faf9f9")
}

#Left align text
left_align <- function(plot_name, pieces){

  grob <- ggplot2::ggplotGrob(plot_name)
  n <- length(pieces)

  grob$layout$l[grob$layout$name %in% pieces] <- 2

  return(grob)
}

# Add Footer (Source +/- Logo Image)
create_footer <- function (source_name, logo_image_path) {

  footer <- grid::grobTree(grid::linesGrob(x = grid::unit(c(0, 1), "npc"), y = grid::unit(1.1, "npc")),
                           grid::textGrob(source_name,
                                          x = 0.004, hjust = 0, gp = grid::gpar(fontsize=12)),
                           grid::rasterGrob(png::readPNG(logo_image_path), x = 0.944))
  return(footer)
}

#' Arrange alignment and save ACHDS themed ggplot
#'
#' Running this function will save your plot.
#' It will left align your title, subtitle and source, add a logo image if specified at the bottom right and save it to your specified location.
#' @param plot_name The variable name of the plot you have created that you want to format and save
#' @param source_name The text you want to come after the text 'Source:' in the bottom left hand side of your side
#' @param save_filepath Exact filepath that you want the plot to be saved to
#' @param width_pixels Width in pixels that you want to save your chart to - defaults to 640
#' @param height_pixels Height in pixels that you want to save your chart to - defaults to 450
#' @param logo_image_path File path for the logo image you want to use in the right hand side of your chart,
#'  which needs to be a PNG file
#' @return (Invisibly) an updated ggplot object.

#' @keywords finalise_plot
#' @examples
#' finalise_plot(plot_name = myplot,
#' source = "The source for my data",
#' save_filepath = "filename_that_my_plot_should_be_saved_to-nc.png",
#' width_pixels = 640,
#' height_pixels = 450,
#' logo_image_path = "logo_image_filepath.png"
#' )
#'
#' @export

finalise_plot <- function(plot_name,
                          source_name,
                          save_filepath=file.path(Sys.getenv("TMPDIR"), "tmp-nc.png"),
                          width_pixels=800,
                          height_pixels=540,
                          logo_image_path = file.path(system.file("data", package = 'ACHDSggTheme'),"placeholder.png")) {

  footer <- create_footer(source_name, logo_image_path)

  #Draw your left-aligned grid
  plot_left_aligned <- left_align(plot_name, c("subtitle", "title", "caption"))
  plot_grid <- ggpubr::ggarrange(plot_left_aligned, footer,
                                 ncol = 1, nrow = 2,
                                 heights = c(1, 0.054/(height_pixels/540)))
  ## print(paste("Saving to", save_filepath))
  save_plot(plot_grid, width_pixels, height_pixels, save_filepath)
  ## Return (invisibly) a copy of the graph. Can be assigned to a
  ## variable or silently ignored.
  invisible(plot_grid)
}
