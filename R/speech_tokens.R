#' Speech Tokenizer
#'
#' speech_tokens function receives a url input and uses CSS selectors
#' to parse and tokenize the portion of the target url believed to contain the
#' txt of a speech; returns a tibble containing each word in that speech
#'
#' @param url
#'
#' @return
#' @export
#' @importFrom magrittr %>%
#'
#' @examples
#' dream <- speech_tokens("https://kinginstitute.stanford.edu/king-papers/documents/i-have-dream-address-delivered-march-washington-jobs-and-freedom")
#'
#' dream
#'
speech_tokens <- function(url){
  xml2::read_html(url) %>%
    rvest::html_nodes("#block-system-main p+ p") %>%
    rvest::html_text() %>%
    stringr::str_replace_all("\\(([^)]*)\\)", "") %>%
    stringr::str_replace_all("\\[([^]]*)\\]", "") %>%
    tibble::as_tibble() %>%
    tidytext::unnest_tokens(word, value)

}
