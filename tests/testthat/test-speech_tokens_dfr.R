test_that("speech_tokens returns the correct number of rows", {
  first_ten <- sample_speech_data %>%
    slice_head(n = 10) %>%
    speech_tokens_dfr()

  expect_equal(nrow(first_ten), 13269)
  expect_equal(ncol(first_ten), 3)
  expect_identical(first_ten$word[[9]], "history")
})
