test_that("scrape_pdf returns a tibble of opinion, case name, opinion type, and author", {
  scrapings <- scrape_pdf(mainurl, page)

  expect_identical(names(scrapings[1]), "opinion")
  expect_identical(names(scrapings[2]), "case_name")
  expect_identical(names(scrapings[3]), "opinion_type")
  expect_identical(names(scrapings[4]), "author")
  expect_equal(length(scrapings), 4)
})

test_that("scrape_1 returns a list containing character vectors for each pdf on source webpage", {
  scrapings <- scrape_1(mainurl, page)
  sample_doc <- scrapings[[2]]

  expect_identical(names(sample_doc[1]), "text")
  expect_identical(names(sample_doc[2]), "case_name")
  expect_equal(length(sample_doc), 2)
})

test_that("scrape_cleaner ")

test_that("organizer correctly splits text by opinion and author", {

})
