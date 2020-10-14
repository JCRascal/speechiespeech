context("Speech Scrape")

test_that("speechscrape works with a local file", {
  a <- speechscrape(system.file("speeches", "dream.txt", package = "speechiespeech"),
                    slctr = spchlist$slctr[[1]])

  b <- sample_speech_data$text[[1]]

  c <- Reduce(setdiff, strsplit(c(a, b), split = ""))
  expect_identical(c, character(0))
})
