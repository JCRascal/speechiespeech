#' Scrape pdf for text
#'
#' Scrape the pages of text from pdfs containing Supreme Court opinions;
#' cleans text and organizes relevant metadata
#'
#' @param .data Text vector where each element represents a page from a pdf
#' @return Tibble containing cleaned text, case name, opinion type, and author
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

  tibbleized_pdf <- tibble::tibble(text_col, "case_name" = case_title,
                                   op_type_col, author_col) %>%
    select(-1)

  tibbleized_pdf$author <- if_else(is.na(tibbleized_pdf$author), true = maj_author(tibbleized_pdf), false = tibbleized_pdf$author) %>%
    stringr::str_trim()
  tibbleized_pdf

}

# Helpers

# scrape_1 returns a list containing the raw text from all pdfs linked on the
# source page

#' @export
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
    mutate(concurring = stringr::str_detect(.data$text, "concurring")) %>%
    mutate(per_curiam = stringr::str_detect(.data$text, "Per Curiam")) %>%
    mutate(majority = stringr::str_detect(.data$text, "Opinion of")) %>%
    mutate(syllabus = stringr::str_detect(.data$text, "Syllabus")) %>%
    mutate(opinion_type = if_else(.data$dissenting == TRUE, true = "Dissenting", false = NA_character_)) %>%
    mutate(opinion_type = if_else(.data$concurring == TRUE, true = "Concurring", false = .data$opinion_type)) %>%
    mutate(opinion_type = if_else(.data$per_curiam == TRUE, true = "Majority", false = .data$opinion_type)) %>%
    mutate(opinion_type = if_else(.data$majority == TRUE, true = "Majority", false = .data$opinion_type)) %>%
    mutate(opinion_type = if_else(.data$syllabus == TRUE, true = "Syllabus", false = .data$opinion_type)) %>%
    select(.data$opinion_type)

}

scrape_author <- function(.data){
  .data %>%
    #tibble::tibble("text" = .) %>%
    purrr::map_dfr(stringr::str_trunc, 200) %>%
    mutate(author = stringr::str_extract(.data$text, ".+(?=, J., dissenting)")) %>%
    mutate(author = if_else(stringr::str_detect(.data$text, ", J., concurring"), true = stringr::str_extract(.data$text, ".+(?=, J., concurring)"),  false = .data$author)) %>%
    mutate(author = if_else(stringr::str_detect(.data$text, "Per Curiam"), true = "Per Curiam", false = .data$author)) %>%
    mutate(author = if_else(stringr::str_detect(.data$text, "Syllabus"), true = "Syllabus", false = .data$author)) %>%
    mutate(author = if_else(stringr::str_detect(.data$text, "(?<=Opinion of ) .+(?=, J.)"), true = stringr::str_extract(.data$text, "(?<=Opinion of ).+(?=, J.)"), false = .data$author)) %>%
    select(.data$author) %>%
    purrr::map_dfr(stringr::str_trim) %>%
    purrr::map_dfr(stringr::str_to_title)
}

maj_author <- function(.data){
  auth_na <- .data %>%
    filter(is.na(author))

  auth_na[[1]][[1]] %>%
    stringr::str_extract("(?<=JUSTICE).+(?= delivered the opinion of the Court)") %>%
    stringr::str_to_title()
}

txt_clean <- function(.data){
  .data %>%
    #tibble::tibble("text" = .) %>%
    stringr::str_replace_all("-\\r\\n", "") %>%
    stringr::str_replace_all("\\r\\n", " ")

}


