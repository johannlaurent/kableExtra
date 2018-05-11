#' Save kable to files
#'
#' @param x A piece of HTML code for tables, usually generated by kable and
#' kableExtra
#' @param file save to files
#' @param bs_theme Which Bootstrap theme to use
#' @param self_contained Will the files be self-contained?
#'
#' @export
save_kable <- function(x, file,
                       bs_theme = "simplex", self_contained = TRUE) {
  html_header <- htmltools::tags$head(
    rmarkdown::html_dependency_jquery(),
    rmarkdown::html_dependency_bootstrap(theme = bs_theme),
    html_dependency_kePrint()
  )
  html_table <- htmltools::HTML(as.character(x))
  html_result <- htmltools::tagList(html_header, html_table)
  htmltools::save_html(html_result, file = file)
  if (self_contained) {
    rmarkdown::pandoc_self_contained_html(file, file)
    unlink("lib", recursive = TRUE)
  }
}