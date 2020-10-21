test_that("scrape_pdf returns a tibble of opinion, case name, opinion type, and author", {
  scrapings <- scrape_pdf(mainurl, page)

  expect_identical(names(scrapings[1]), "opinion")
  expect_identical(names(scrapings[2]), "case_name")
  expect_identical(names(scrapings[3]), "opinion_type")
  expect_identical(names(scrapings[4]), "author")
  expect_equal(length(scrapings), 4)
})

test_that("scrape_2 assigns an opinion type and author for each page in a source pdf", {

})

# test_that("scrape_cleaner ")
#
# test_that("organizer correctly splits text by opinion and author", {
#
# })
