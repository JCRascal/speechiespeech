% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wordcount_plot.R
\name{wordcount_plot}
\alias{wordcount_plot}
\title{Plot Word Count}
\usage{
wordcount_plot(speech_tkn)
}
\arguments{
\item{speech_tkn}{tokenized speech object input}
}
\value{
Horizontal bar graph that displays the most frequently occuring
words, by frequency, in a tokenized collection of words
}
\description{
The speech_tkn function receives as input a tidy tokenized tibble of text
from a speech, counts the number of occurences of each word
}
\examples{
url <- "https://er.jsc.nasa.gov/seh/ricetalk.htm"
title <- "Moon Speech"
author <- "John F. Kennedy"
# wordcount_plot(speech_tokens(url, title, author))
}
