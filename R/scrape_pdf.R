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

organizer <- function(text){

}
