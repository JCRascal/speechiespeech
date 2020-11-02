#' Scrape pdf for text
#'
#' Scrape the pages of text from pdfs containing Supreme Court opinions;
#' cleans text and organizes relevant metadata
#'
#' @param .data
#' @importFrom pdftools pdf_text

scrape_pdf <- function(.data){
  text_og <- .data %>%
    tibble::tibble("text" = .data$.)

  text_col <- purrr::map_dfr(text_og, txt_clean)
  op_type_col <- scrape_optype(text_og)
  author_col <- scrape_author(text_og)
  case_title <- text_og$text[[2]] %>%
    stringr::str_extract("(?<=\\s).+(?=\\r\\n)") %>%
    stringr::str_trim()

  tibbleized_pdf <- tibble::tibble("text" = text_col, "case_name" = case_title,
                                   "opinion_type" = op_type_col, "author" = author_col)

}

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
    stringr::str_c(main_url, .data) %>%
    purrr::map(pdftools::pdf_text)
}

# scrape_optype receives a character vector representing a single page of a
# Supreme Court slip opinion pdf and returns a one-column tibble which describes
# the type of Supreme Court opinion contained in that page

scrape_optype <- function(.data){
  .data %>%
    #tibble::tibble("text" = .) %>%
    purrr::map_dfr(stringr::str_trunc, 200) %>%
    mutate(dissenting = stringr::str_detect(.data$text, "dissenting")) %>%
    mutate(per_curiam = stringr::str_detect(.data$text, "Per Curiam")) %>%
    mutate(opinion_type = if_else(.data$dissenting == TRUE, true = "Dissenting", false = NA_character_)) %>%
    mutate(opinion_type = if_else(.data$per_curiam == TRUE, true = "Per Curiam", false = .data$opinion_type)) %>%
    select(.data$opinion_type)

}

scrape_author <- function(.data){
  .data %>%
    #tibble::tibble("text" = .) %>%
    purrr::map_dfr(stringr::str_trunc, 200) %>%
    mutate(author = stringr::str_extract(.data$text, ".+(?=, J., dissenting)")) %>%
    mutate(author = if_else(stringr::str_detect(.data$text, "Per Curiam"), true = "Per Curiam", false = .data$author)) %>%
    select(.data$author) %>%
    purrr::map_dfr(stringr::str_trim) %>%
    purrr::map_dfr(stringr::str_to_title)
}

txt_clean <- function(.data){
  .data %>%
    #tibble::tibble("text" = .) %>%
    stringr::str_replace_all("-\\r\\n", "") %>%
    stringr::str_replace_all("\\r\\n", " ")

}


