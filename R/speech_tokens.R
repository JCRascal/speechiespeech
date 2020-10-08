#' Speech Tokenizer
#'
#' speech_tokens function receives a url input and uses CSS selectors to parse
#' and tokenize the portion of the target url believed to contain the txt of a
#' speech; returns a tibble containing each word in that speech
#'
#' @param text string containing full text to be tokenized
#' @param title string value of speech title
#' @param author string value of speech author's full name
#' @return
#' @export
#' @importFrom magrittr %>%
#' @import stopwords

speech_tokens <- function(text, title, author){
  stp_wrds <- tidytext::get_stopwords()

  text %>%
    tibble::as_tibble() %>%
    tidytext::unnest_tokens(word, value) %>%
    dplyr::anti_join(stp_wrds) %>%
    dplyr::mutate(title = title, author = author)
}

#' @export
speech_tokens_dfr <- function(.data){
  text <- .data$text
  title <- .data$title
  author <- .data$author

  purrr::pmap_dfr(tibble::tibble(text, title, author), speech_tokens)

}
