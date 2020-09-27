#' Plot Word Count
#'
#' The speech_tkn function receives as input a tidy tokenized tibble of text
#' from a speech, counts the number of occurences of each word
#'
#' @param speech_tkn tokenized speech object input
#'
#' @return
#' @export
#' @importFrom magrittr %>%
#' @import ggplot2
#' @import dplyr
#' @examples
#' url <- "https://kinginstitute.stanford.edu/king-papers/documents/i-have-dream-address-delivered-march-washington-jobs-and-freedom"
#' title <- "I Have a Dream"
#' author <- "Dr. Martin Luther King, Jr."
#' wordcount_plot(speech_tokens(url, title, author))
wordcount_plot <- function(speech_tkn){

  speech_tkn %>%
    count(word, title, author) %>%
    top_n(10) %>%
    arrange(desc(n)) %>%
    mutate(word = factor(word, levels = rev(unique(word)))) %>%
    ggplot(aes(word, n)) +
    geom_col(show.legend = FALSE) +
    coord_flip()
}
