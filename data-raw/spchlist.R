
url <- c("https://kinginstitute.stanford.edu/king-papers/documents/i-have-dream-address-delivered-march-washington-jobs-and-freedom",
          "https://kinginstitute.stanford.edu/king-papers/documents/beyond-vietnam",
          "https://kinginstitute.stanford.edu/our-god-marching",
         "https://kinginstitute.stanford.edu/king-papers/documents/ive-been-mountaintop-address-delivered-bishop-charles-mason-temple",
         "https://er.jsc.nasa.gov/seh/ricetalk.htm",
         "https://www.ourdocuments.gov/doc.php?flash=false&doc=91&page=transcript",
         "https://www.americanrhetoric.com/speeches/jfkcommonwealthmass.htm",
         "https://www.jfklibrary.org/archives/other-resources/john-f-kennedy-speeches/american-newspaper-publishers-association-19610427",
         "https://teachingamericanhistory.org/library/document/great-society-speech/",
         "https://www.presidency.ucsb.edu/documents/address-before-joint-session-the-congress-0",
         "https://www.presidency.ucsb.edu/documents/radio-and-television-remarks-upon-signing-the-civil-rights-bill")

title <- c("I Have a Dream",
            "Beyond Vietnam",
            "Our God is Marching On",
            "I've Been to the Mountaintop",
           "To the Moon",
           "Inaugural Address 1961",
           "City Upon a Hill",
           "The President and the Press",
           "The Great Society",
           "Congressional Address Following Assasinaton of President Kennedy",
           "1964Civil Rights Bill Signing Statement")

author <- c("Dr. Martin Luther King, Jr.",
             "Dr. Martin Luther King, Jr.",
             "Dr. Martin Luther King, Jr.",
             "Dr. Martin Luther King, Jr.",
            "John F. Kennedy",
            "John F. Kennedy",
            "John F. Kennedy",
            "John F. Kennedy",
            "Lyndon B. Johnson",
            "Lyndon B. Johnson",
            "Lyndon B. Johnson")

slctr <- c("#block-system-main p+ p",
           "#block-system-main p+ p",
           "#block-system-main p+ p",
           "#block-system-main p+ p",
           "p+ p , p:nth-child(13)",
           "p+ p",
           "p:nth-child(35) font , small , p:nth-child(19) font , strong font",
           "p~ p+ p",
           "p~ p+ p",
           ".field-docs-content p",
           "#block-system-main p+ p")

spchlist <- tibble::tibble("url" = url, "title" = title, "author" = author, "slctr" = slctr)

usethis::use_data(spchlist, overwrite = TRUE)
