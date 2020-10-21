test_that("feelings output includes two columns named word and sentiment", {
  feels <- sample_speech_data %>%
    speech_tokens_dfr() %>%
    feelings()

<<<<<<< HEAD
  expect_equal(ncol(feels), 2)
  expect_equal(names(feels[1]), "word")
  expect_equal(names(feels[2]), "sentiment")

||||||| 90f6d5a
  expect_equal(ncol(feels) > 2, TRUE)
  expect_equal(is.null(feels$word), FALSE)
  expect_equal(is.null(feels$sentiment), FALSE)
=======
  expect_equal(ncol(feels), 2)
  expect_equal(names(feels[1]), "word")
  expect_equal(names(feels[2]), "sentiment")

})

test_that("", {

>>>>>>> 8da48062ff092584b8ffc797205ec33f81bc8c3b
})


