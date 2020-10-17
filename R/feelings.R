#' Feelings
#'
#' @param .data tibble containing at the minimum a column called "word"
#'
#' @return tidy tibble with a row for each word/sentiment pair from NRC/.data
#' @export
#'
#' @examples
feelings <- function(.data){
  nrc_sent <- tidytext::get_sentiments("nrc")

  .data %>%
    select("word") %>%
    dplyr::inner_join(nrc_sent, by = "word")
}
