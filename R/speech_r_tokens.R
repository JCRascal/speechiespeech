speech_r_tokens <- function(row1){
  url <- row1[[1]]
  title <- row1[[2]]
  author <- row1[[3]]

  speech_tokens(url, title, author)
}
