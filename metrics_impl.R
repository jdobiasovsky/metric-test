# using stringdist package, calculate string metric and return match percentage
library(stringdist)

levenshtein <- function(string1, string2) {
  # calculate original levenshtein distance, no transposition
  calculated_dist <- stringdist(string1, string2, method = 'lv')
  # maximum possible edit distance
  max_dist <- max(nchar(string1), nchar(string2))
  # based on maximum edit distance and result, return match percentage (1 = 100%)
  result <- (1 - calculated_dist/max_dist)
  return(result)
}


levenshtein_damerau <- function(string1, string2) {
  # restricted levenshtein-damerau, only adjacent characters can be transposed
  calculated_dist <- stringdist(string1, string2, method = 'osa')
  # maximum possible edit distance
  max_dist <- max(nchar(string1), nchar(string2))
  # based on maximum edit distance and result, return match percentage (1 = 100%)
  result <- (1 - calculated_dist/max_dist)
  return(result)
}


jaro <- function (string1, string2) {
  # calculate jaro distance, no penalties
  calculated_dist <- stringdist(string1, string2, method = jw, p=0)
  # return 0 when completely different, 1 when identical. Can be interpreted as percentage.
  return(calculated_dist)
}

jaro_winkler <- function(string1, string2) {
  # calculate jaro-winkler distance, max prefix lenght 4 characters, penalty is set to 0.1{
  calculated_dist <- stringdist(string1, string2, method = jw, 0.1)
  # return 0 when completely different, 1 when identical. Can be interpreted as percentage.
  return(calculated_dist)
}

jaccard <- function(string1, string2) {
  # calculate jaccard coeficient with q-grams of 3 chars. (reffered as n-grams in thesis)
  jacc = stringdist(string1, string2, method = 'jaccard', q = 3)
  # result interpretable in both percentages, and also as proper jaccard index
  return(1-jacc)
  
}