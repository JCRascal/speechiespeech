test_that("feelings outputs two columns named word and sentiment", {
  feels <- sample_speech_data[9,] %>%
    speech_tokens_dfr() %>%
    feelings()

  expect_equal(ncol(feels), 2)
  expect_identical(names(feels[1]), "word")
  expect_identical(names(feels[2]), "sentiment")
})
