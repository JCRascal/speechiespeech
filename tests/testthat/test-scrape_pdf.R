test_that("scrape_pdf returns a tibble of opinion, case name, opinion type, and author", {
  scrapings <- scrape_pdf(test_pdf[[1]])

  expect_identical(names(scrapings[1]), "text")
  expect_identical(names(scrapings[2]), "case_name")
  expect_identical(names(scrapings[3]), "opinion_type")
  expect_identical(names(scrapings[4]), "author")
  expect_equal(length(scrapings), 4)
})


test_that("scrape_optype returns a tibble containing accurate opinion_type column", {
  expected <- tibble::tibble(opinion_type = c("Majority", "Majority", "Majority", "Dissenting", "Dissenting",
                "Dissenting", "Dissenting", "Dissenting", "Dissenting", "Dissenting"))

  tester <- scrape_optype(tibble::tibble("text" = test_pdf[[1]]))

  expect_identical(tester, expected)
})

test_that("scrape_optype correctly identifies majority opinions", {
  tester <- scrape_optype(tibble::tibble("text" = test_pdf[[9]]))

  expect_identical(tester$opinion_type[[9]], "Majority")

  tester <- scrape_optype(tibble::tibble("text" = test_pdf[[4]]))

  expect_identical(tester$opinion_type[[7]], "Majority")
})

test_that("scrape_author returns a tibble containing accurate author column", {
  expected <- tibble::tibble(author = c("Per Curiam", "Per Curiam",
                                              "Per Curiam", "Breyer", "Breyer",
                                              "Breyer", "Sotomayor", "Sotomayor",
                                              "Sotomayor", "Sotomayor"))
  tester <- scrape_author(tibble::tibble("text" = test_pdf[[1]]))

  expect_identical(tester, expected)
})

test_that("scrape_author correctly identifies author of a majority opinion", {
  tester <- scrape_author(tibble::tibble("text" = test_pdf[[9]]))
  expect_identical(tester$author[[9]], "Kavanaugh")
})


test_that("txt_clean removes all escape characters", {
  expect_equal(stringr::str_detect(txt_clean(test_pdf[[1]][[8]]), "\\r\\n"), FALSE)
})
#
# test_that("organizer correctly splits text by opinion and author", {
#
# })
