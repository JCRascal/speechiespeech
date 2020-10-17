test_that("feelings outputs two columns named word and sentiment", {
  feels <- sample_speech_data[9,] %>%
    speech_tokens_dfr() %>%
    feelings()

  expect_equal(ncol(feels) > 2, TRUE)
  expect_equal(is.null(feels$word), FALSE)
  expect_equal(is.null(feels$sentiment), FALSE)
})
