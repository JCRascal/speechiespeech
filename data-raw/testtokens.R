## code to prepare `testtokens` dataset goes here
text <- sample_speech_data$text[[4]]
title <- "I've Been to the Mountaintop"
author <- "Dr. Martin Luther King, Jr"

testtokens <- speech_tokens(text, title, author)

usethis::use_data(testtokens, internal = TRUE, overwrite = TRUE)
