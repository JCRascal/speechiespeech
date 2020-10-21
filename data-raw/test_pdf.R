## code to prepare `test_pdf` dataset goes here
test_pdf <- scrape_1("https://www.supremecourt.gov", "https://www.supremecourt.gov/opinions/slipopinion/19")


usethis::use_data(test_pdf, internal = TRUE, overwrite = TRUE)
