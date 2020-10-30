# Helpers

# scrape_1 returns a list containing the raw text from all pdfs linked on the
# source page
scrape_1 <- function(main_url, page){
  pages <- xml2::read_html(page)

  pages %>%
    rvest::html_nodes("a") %>%
    rvest::html_attr("href") %>%
    stringr::str_subset("\\.pdf") %>%
    stringr::str_subset("^((?!publicinfo).)*$") %>%
    stringr::str_c(main_url, .) %>%
    purrr::map(pdftools::pdf_text)
}

# scrape_optype receives a character vector representing a single page of a
# Supreme Court slip opinion pdf and returns a one-column tibble which describes
# the type of Supreme Court opinion contained in that page

scrape_optype <- function(.data){
  .data %>%
    tibble::tibble("text" = .) %>%
    purrr::map_dfr(stringr::str_trunc, 115) %>%
    mutate(dissenting = stringr::str_detect(text, "dissenting")) %>%
    mutate(per_curiam = stringr::str_detect(text, "Per Curiam")) %>%
    mutate(opinion_type = if_else(dissenting == TRUE, true = "Dissenting", false = NA_character_)) %>%
    mutate(opinion_type = if_else(per_curiam == TRUE, true = "Per Curiam", false = opinion_type)) %>%
    select(opinion_type)

}

scrape_author <- function(.data){
  .data %>%
    tibble::tibble("text" = .) %>%
    purrr::map_dfr(stringr::str_trunc, 115) %>%
    mutate(author = stringr::str_extract(text, ".+(?=, J., dissenting)")) %>%
    mutate(author = if_else(stringr::str_detect(text, "Per Curiam"), true = "Per Curiam", false = author)) %>%
    select(author) %>%
    purrr::map_dfr(stringr::str_trim) %>%
    purrr::map_dfr(stringr::str_to_title)
}

organizer <- function(text){

}
