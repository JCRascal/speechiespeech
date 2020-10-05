#' Speech Scrape
#'
#' Here I am describing some things.
#'
#'
#' @param url string containing location of chosen html file
#' @param slctr string specifying css selector for chosen text
#'
#' @return
#' @export
#'
#' @examples

# Create helper functions that perform useful workflow alterations to include:
# 1. regex calls to eliminate pesky lines that can't be easily avoided using
#    html_nodes, with prebuilt cases such as <em> tags, [] and (). Maybe a VERY
#    restrictive regex function?
# 2. Helpers to apply common use cases for parameters
# 3. Custom stopword creation helpers
speechscrape <- function(url, slctr = "p+ p"){?j
  xml2::read_html(url) %>%
    rvest::html_nodes(slctr) %>%
    rvest::html_text() %>%
    #textclean::replace_white() %>%
    stringr::str_replace_all("\\s+", " ") %>%
    stringr::str_c(collapse = "")
}

# strong consideration to just use textclean package for noww

# regex helper. consider giving it simple list of filters such as
# eliminate, contents of em tags, parentheses, brackets, first line, last line
# ask for feedback from Brandon
