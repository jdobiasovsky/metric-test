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
  # return harmonic mean of precision and recall
  return(
    2*((precision*recall)/(precision+recall))
      )
}

get_f_beta_measure <- function(precision, recall, beta){
  # return harmonic mean of precision and recall where beta is weight of recall
  return(
    (1+beta^2)*((precision*recall)/(((beta^2)*precision) + recall))
  )
}



generate_results <- function(data, colname, exploratory=FALSE){
  # Generates table of with values of precision and recall for given match treshold. Set exploratory=TRUE to generate shortened version straight into memory
  gc(full=TRUE)
  results <- data.frame(
    "Treshold" = double(),
    "Precision" = double(),
    "Recall" = double()
  )
  if (exploratory == TRUE) {
    pb <- txtProgressBar(min = 0, max=100, initial = 0, style = 3)
    for (x in seq(from = 0.1, to = 0, by=-0.01)){
      gc()
      TP <- data %>% filter(DOI1==DOI2) %>% filter(UQ(as.symbol(colname)) <= x) %>% nrow()
      FP <- data %>% filter(DOI1!=DOI2) %>% filter(UQ(as.symbol(colname)) <= x) %>% nrow()
      FN <- data %>% filter(DOI1==DOI2) %>% filter(UQ(as.symbol(colname)) > x) %>% nrow()
      
      
      results <- rbind(results, data.frame(
        "Treshold" = x,
        "Precision" = TP/(TP+FP),
        "Recall" = TP/(TP+FN),
        "Fmeasure" = get_fmeasure(TP/(TP+FP), TP/(TP+FN)),
        "TP" = TP,
        "FP" = FP,
        "FN" = FN
      ))
      setTxtProgressBar(pb,value=round((1-x)*100))
      getTxtProgressBar(pb)
    }
    
    return(results)
  } else {
  print(paste("Starting results generation, current time:", Sys.time()))
  pb <- txtProgressBar(min = 0, max=100, initial = 0, style = 3)
  for (x in seq(from = 0.6, to = 0, by=-0.0001)){
    gc()
    TP <- data %>% filter(DOI1==DOI2) %>% filter(UQ(as.symbol(colname)) <= x) %>% nrow()
    FP <- data %>% filter(DOI1!=DOI2) %>% filter(UQ(as.symbol(colname)) <= x) %>% nrow()
    FN <- data %>% filter(DOI1==DOI2) %>% filter(UQ(as.symbol(colname)) > x) %>% nrow()
    
    results <- rbind(results, data.frame(
      "Treshold" = x,
      "Precision" = TP/(TP+FP),
      "Recall" = TP/(TP+FN),
      "Fmeasure" = get_fmeasure(TP/(TP+FP), TP/(TP+FN)),
      "TP" = TP,
      "FP" = FP,
      "FN" = FN
    ))
  setTxtProgressBar(pb,value=round((1-x)*100))
  getTxtProgressBar(pb)
  }
  print(paste("Processing done, current time:", Sys.time()))
  return(results)
  }
}


generate_results_merge <- function(metric, group, colname, exploratory=FALSE){
  # Use generate_results for specific range and metric
  paths <- sapply(X = group, FUN = build_path, base="./data/precision_recall_filtered_06/",metric=metric, extension=".csv")
  print(paste("Loop start for:", metric, head(group, n=1),"-",tail(group,n=1)))
  results <- generate_results(data = open_multiple(paths), colname, exploratory)
  if (exploratory == TRUE){
    return(results)
  } else {
    write_csv(results,
              path = build_path(base = "./data/results_storage/", 
                                metric=metric, 
                                year = paste(head(group, n=1),tail(group,n=1), sep = "-"),
                                extension = ".csv"),
              col_names = TRUE)
  }
}