#' Speech Tokenizer
#'
#' speech_tokens function receives a url input and uses CSS selectors
#' to parse and tokenize the portion of the target url believed to contain the
#' txt of a speech; returns a tibble containing each word in that speech
#'
#' @param url string value oftarget url containing speech to be parsed into tibble
#' @param title string value of speech title
#' @param author string value of speech author's full name
#' @return
#' @export
#' @importFrom magrittr %>%
#' @import stopwords
#' @examples
#' url <- "https://kinginstitute.stanford.edu/king-papers/documents/i-have-dream-address-delivered-march-washington-jobs-and-freedom"
#' title <- "I Have a Dream"
#' author <- "Dr. Martin Luther King, Jr."
#' speech_tokens(url, title, author)
#'
#'
#'
speech_tokens <- function(url, title, author){
  stp_wrds <- tidytext::get_stopwords()

  xml2::read_html(url) %>%
    rvest::html_nodes("#block-system-main p+ p") %>%
    rvest::html_text() %>%
    stringr::str_replace_all("\\(([^)]*)\\)", "") %>%
    stringr::str_replace_all("\\[([^]]*)\\]", "") %>%
    tibble::as_tibble() %>%
    tidytext::unnest_tokens(word, value) %>%
    dplyr::anti_join(stp_wrds) %>%
    dplyr::mutate(title = title, author = author)

}
