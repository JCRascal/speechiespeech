test_that("scrape_pdf returns a tibble of opinion, case name, opinion type, and author", {
  scrapings <- scrape_pdf(mainurl, page)

  expect_identical(names(scrapings[1]), "opinion")
  expect_identical(names(scrapings[2]), "case_name")
  expect_identical(names(scrapings[3]), "opinion_type")
  expect_identical(names(scrapings[4]), "author")
  expect_equal(length(scrapings), 4)
})

test_that("scrape_head assigns correct opinion type and author for each page in a source pdf", {
  tester <- scrape_head(test_pdf[[1]])

  expect_identical(tester$opinion_type[1], "Per Curiam")
  expect_identical(tester$opinion_type[4], "Dissenting")

  expect_identical(tester$author[1], "Per Curiam")
  expect_identical(tester$author[4], "Breyer")
})

test_that("scrape_optype returns a tibble containing accurate opinion_type column", {
  expected <- tibble::tibble(opinion_type = c("Per Curiam", "Per Curiam", "Per Curiam", "Dissenting", "Dissenting",
                "Dissenting", "Dissenting", "Dissenting", "Dissenting", "Dissenting"))

  tester <- scrape_optype(test_pdf[[1]])

  expect_identical(tester, expected)
})

test_that("scrape_author returns a tibble containing accurate author column", {
  expected <- tibble::tibble(author = c("Per Curiam", "Per Curiam",
                                              "Per Curiam", "Breyer", "Breyer",
                                              "Breyer", "Sotomayor", "Sotomayor",
                                              "Sotomayor", "Sotomayor"))
  tester <- scrape_author(test_pdf[[1]])

  expect_identical(tester, expected)
})

test_that("txt_clean removes all escape characters", {
  expect_equal(stringr::str_detect(txt_clean(test_pdf[[1]][[8]]), "\\r\\n"), FALSE)
})
#
# test_that("organizer correctly splits text by opinion and author", {
#
# })
