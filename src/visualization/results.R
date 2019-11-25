source("./src/processing/utils.R")
library(ggplot2)
library(dplyr)
library(readr)
library(tibble)


get_precision <- function(data, match_treshold, colname){
  # calculate precision based on number of columns which comply with characteristic of true positive, true negative etc.
  # column name in filter() needs to be unquoted using UQ(as.symbol()) due to the dplyr semantics (https://stackoverflow.com/questions/27197617/filter-data-frame-by-character-column-name-in-dplyr)
  # True positive = given comparison is above match treshold and also DOI's match
  TP <- data %>% filter(DOI1==DOI2) %>% filter(UQ(as.symbol(colname)) <= match_treshold) %>% nrow()
  #True negative = given comparison is above match treshold but the DOI's don't match (means it's two different documents)
  FP <- data %>% filter(DOI1!=DOI2) %>% filter(UQ(as.symbol(colname)) <= match_treshold) %>% nrow()
  return(TP/(TP+FP))
}

get_recall <- function(data, match_treshold, colname){
  # calculate precision based on number of columns which comply with characteristic of true positive, true negative etc.
  # column name in filter() needs to be unquoted using UQ(as.symbol()) due to the dplyr semantics (https://stackoverflow.com/questions/27197617/filter-data-frame-by-character-column-name-in-dplyr)
  # True positive = given comparison is above match treshold and also DOI's match
  TP <- data %>% filter(DOI1==DOI2) %>% filter(UQ(as.symbol(colname)) <= match_treshold) %>% nrow()
  # False negative = according to DOI, these are same documents, but value resulting from comparison did NOT reach treshold to classify as TP
  FN <- data %>% filter(DOI1==DOI2) %>% filter(UQ(as.symbol(colname)) > match_treshold) %>% nrow()
  return(TP/(TP+FN))
}

get_fmeasure <- function(precision, recall){
  # return harmonic mean of precision anf recall
  return(
    2*((precision*recall)/(precision+recall))
      )
}

generate_results <- function(data, colname){
  # Generates table of with values of precision and recall for given match treshold
  results <- data.frame(
    "Treshold" = double(),
    "Precision" = double(),
    "Recall" = double()
  )
  # for (x in seq(from = 0.1, to = 0, by=-0.0001)){
  for (x in seq(from = 0.7, to = 0, by=-0.0001)){
    results <- rbind(results, data.frame(
      "Treshold" = x,
      "Precision" = get_precision(data, x, colname),
      "Recall" = get_recall(data, x, colname),
      "Fmeasure" = get_fmeasure(get_precision(data, x, colname), get_recall(data, x, colname))
    ))
  }
  return(results)
}

generate_results_merge <- function(metric, group, colname){
  # Use generate_results for specific range and metric
  paths <- sapply(X = group, FUN = build_path, base="./data/precision_recall/",metric=metric, extension=".csv")
  results <- generate_results(data = open_multiple(paths), colname)
  return(results)
}