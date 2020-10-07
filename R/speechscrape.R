#' Speech Scrape
#'
#' Here I am describing some things.
#'
#'
#' @param url string containing location of chosen html file
#' @param slctr string specifying css selector for chosen text
#'
#' @return
#' speechscrape returns a single character value containing containing the
#' processed text found at the location and css selector specified by input
#'
#' speechscrape2 returns a list object where each element is a list containing
#' a single processed text,
#' @export
#' @importFrom rlang .data
#'
#' @examples

# Create helper functions that perform useful workflow alterations to include:
# 1. regex calls to eliminate pesky lines that can't be easily avoided using
#    html_nodes, with prebuilt cases such as <em> tags, [] and (). Maybe a VERY
#    restrictive regex function?
# 2. Helpers to apply common use cases for parameters
# 3. Custom stopword creation helpers
speechscrape <- function(url, slctr = "p+ p"){
  xml2::read_html(url) %>%
    rvest::html_nodes(slctr) %>%
    rvest::html_text() %>%
    #textclean::replace_white() %>%
    stringr::str_replace_all("\\s+", " ") %>%
    stringr::str_c(collapse = "")
}
#' @rdname speechscrape
#' @param .data A data frame or tibble containing the url and css selector of
#'   the desired documents
#' @export
# Version of speechscrape that receives a dataframe as an argument
speechscrape2 <- function(.data){
  txt_df <- purrr::map(.data$url, xml2::read_html) %>%
    purrr::map2(.data$slctr, rvest::html_nodes) %>%
    purrr::map(rvest::html_text) %>%
    purrr::map(stringr::str_replace_all, "\\s+", " ") %>%
    purrr::map(stringr::str_c, collapse = " ") %>%
    purrr::map_dfr(tibble::as_tibble_col, column_name = "text")

  title <- .data$title
  author <- .data$author

  mutate(txt_df, "title" = title, "author" = author)
}
