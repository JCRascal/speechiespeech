# check number of rows for I've Been to the Mountaintop
test_that("speech_tokens returns the correct number of rows", {
  text <- sample_speech_data$text[[4]]
  title <- sample_speech_data$title[[4]]
  author <- sample_speech_data$author[[4]]

  test <- speech_tokens(text, title, author)


  expect_equal(nrow(test), 2094)
})
