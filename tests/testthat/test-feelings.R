test_that("feelings output includes two columns named word and sentiment", {
  feels <- sample_speech_data %>%
    speech_tokens_dfr() %>%
    feelings()


  expect_equal(ncol(feels), 2)
  expect_equal(names(feels[1]), "word")
  expect_equal(names(feels[2]), "sentiment")


})


