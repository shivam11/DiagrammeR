#' Render a graph available in a series
#' @description Using a graph series object of type \code{dgr_graph_1D}, either
#' render graph in the Viewer or output in various formats.
#' @param graph_series a graph series object of type \code{dgr_graph_1D}.
#' @param graph_no the index of the graph in the graph series.
#' @param output a string specifying the output type; \code{graph} (the
#' default) renders the graph using the \code{grViz} function, \code{DOT}
#' outputs DOT code for the graph, and \code{SVG} provides SVG code for the
#' rendered graph.
#' @param width an optional parameter for specifying the width of the resulting
#' graphic in pixels.
#' @param height an optional parameter for specifying the height of the
#' resulting graphic in pixels.
#' @examples
#' \dontrun{
#' # Create three graphs (using \code{magrittr} for piping)
#' # and create a graph series using those graphs
#' library(magrittr)
#'
#' graph_1 <- create_graph() %>%
#'   add_node("a") %>% add_node("b") %>% add_node("c") %>%
#'   add_edge("a", "c") %>% add_edge("a", "b") %>% add_edge("b", "c")
#'
#' graph_2 <- graph_1 %>%
#'   add_node("d") %>% add_edge("d", "c")
#'
#' graph_3 <- graph_2 %>%
#'   add_node("e") %>% add_edge("e", "b")
#'
#' # Create an empty graph series
#' series <- create_series(series_type = "sequential")
#'
#' # Add graphs to the graph series
#' series <- graph_1 %>% add_to_series(series)
#' series <- graph_2 %>% add_to_series(series)
#' series <- graph_3 %>% add_to_series(series)
#'
#' # View the second graph in the series in the Viewer
#' render_graph_from_series(graph_series = series,
#'                          graph_no = 2)
#' }
#' @export render_graph_from_series

render_graph_from_series <- function(graph_series,
                                     graph_no,
                                     output = "graph",
                                     width = NULL,
                                     height = NULL){

  # Stop function if no graphs are available
  if (is.null(graph_series$graphs)){

    stop("There are no graphs in this graph series.")
  }

  # Stop function if 'graph_no' out of range
  if (!(graph_no %in% 1:graph_count(graph_series))){

    stop("The index chosen doesn't correspond to that of a graph in the series.")
  }

  # Extract the specified graph from the series
  graph <- graph_series$graphs[[graph_no]]

  render_graph(graph = graph,
               output = output,
               width = width,
               height = height)
}