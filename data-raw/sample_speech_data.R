library(speechiespeech)

urls <- c("https://kinginstitute.stanford.edu/king-papers/documents/i-have-dream-address-delivered-march-washington-jobs-and-freedom",
          "https://kinginstitute.stanford.edu/king-papers/documents/beyond-vietnam",
          "https://kinginstitute.stanford.edu/our-god-marching",
          "https://kinginstitute.stanford.edu/encyclopedia/ive-been-mountaintop")
titles <- c("I Have a Dream", "Beyond Vietnam", "Our God is Marching On",
            "I've Been to the Mountaintop")
authors <- c("Dr. Martin Luther King, Jr.", "Dr. Martin Luther King, Jr.", "Dr. Martin Luther King, Jr.", "Dr. Martin Luther King, Jr.")

speeches <- tibble("url" = urls, "title" = titles, "author" = authors)

sample_speech_data <- spch_tkn_map(speeches)

usethis::use_data(sample_speech_data, overwrite = TRUE)
