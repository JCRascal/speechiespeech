#' Speech Tokenizer
#'
#' speech_tokens function receives a url input and uses CSS selectors
#' to parse and tokenize the portion of the target url believed to contain the
#' txt of a speech; returns a tibble containing each word in that speech
#'
#' @param url target url containing speech to be parsed into tibble
#'
#' @return
#' @export
#' @importFrom magrittr %>%
#' @import stopwords
#' @examples
#' speech_tokens("https://kinginstitute.stanford.edu/king-papers/documents/i-have-dream-address-delivered-march-washington-jobs-and-freedom")
#'
#'
#'
speech_tokens <- function(url){
  stp_wrds <- tidytext::get_stopwords()

  xml2::read_html(url) %>%
    rvest::html_nodes("#block-system-main p+ p") %>%
    rvest::html_text() %>%
    stringr::str_replace_all("\\(([^)]*)\\)", "") %>%
    stringr::str_replace_all("\\[([^]]*)\\]", "") %>%
    tibble::as_tibble() %>%
    tidytext::unnest_tokens(word, value) %>%
    dplyr::anti_join(stp_wrds)

}
