
url <- c("https://kinginstitute.stanford.edu/king-papers/documents/i-have-dream-address-delivered-march-washington-jobs-and-freedom",
          "https://kinginstitute.stanford.edu/king-papers/documents/beyond-vietnam",
          "https://kinginstitute.stanford.edu/our-god-marching",
          "https://kinginstitute.stanford.edu/encyclopedia/ive-been-mountaintop")

title <- c("I Have a Dream",
            "Beyond Vietnam",
            "Our God is Marching On",
            "I've Been to the Mountaintop")
author <- c("Dr. Martin Luther King, Jr.",
             "Dr. Martin Luther King, Jr.",
             "Dr. Martin Luther King, Jr.",
             "Dr. Martin Luther King, Jr.")

slctr <- c("#block-system-main p+ p",
           "#block-system-main p+ p",
           "#block-system-main p+ p",
           "#block-system-main p+ p")

spchlist <- tibble::tibble("url" = url, "title" = title, "author" = author, "slctr" = slctr)

usethis::use_data(spchlist, overwrite = TRUE)
