#' Create Tibble from Several Speech Sources
#'
#' spch_tkn_map receives a tibble (source_list) containing character vectors for url,
#' speech title, and speech author for use with the speech_tokens function.
#'
#' purrr::pmap_dfr is called on source_list, mapping each row in source list
#' as the inputs to speech_tokens(url, title, author).
#'
#' spch_tkn_map returns a tokenized tibble of all words in each speech, with
#' columns reflecting title and author
#'
#' @param source_list
#'
#' @return
#' @export
#' @importFrom magrittr "%>%"
#'
#' @examples
spch_tkn_map <- function(source_list){
  source_list %>%
    purrr::pmap_dfr(speech_tokens)
}
