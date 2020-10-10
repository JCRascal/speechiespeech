#' Speech Tokenizer
#'
#' speech_tokens function receives a url input and uses CSS selectors to parse
#' and tokenize the portion of the target url believed to contain the txt of a
#' speech; returns a tibble containing each word in that speech
#'
#' @param text string containing full text to be tokenized
#' @param title string value of speech title
#' @param author string value of speech author's full name
#' @return A tibble where the elements represent all words in a given document,
#'   filtered for common stopwords. Contains the documents of a single document
#'   if the call is to speech_tokens, several documents if the call is to
#'   speech_tokens_dfr
#' @export
#' @importFrom magrittr %>%
#' @import stopwords
#' @examples
#' text <- sample_speech_data$text[5]
#' title <- sample_speech_data$title[5]
#' author <- sample_speech_data$author[5]
#'
#' speech_tokens(text, title, author)
#'
#' speech_tokens_dfr(sample_speech_data)

speech_tokens <- function(text, title, author){
  stp_wrds <- tidytext::get_stopwords()

  text %>%
    tibble::as_tibble() %>%
    tidytext::unnest_tokens(.data$word, .data$value) %>%
    dplyr::anti_join(stp_wrds) %>%
    dplyr::mutate(title = title, author = author)
}

#' @rdname speech_tokens
#' @param .data A data frame or tibble containing columns of text, title, and
#'   author of the desired documents
#' @export
speech_tokens_dfr <- function(.data){
  text <- .data$text
  title <- .data$title
  author <- .data$author

  purrr::pmap_dfr(tibble::tibble(text, title, author), speech_tokens)

}
