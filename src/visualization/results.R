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

pr_subset <- function(path, colname){
  data <- open_data(path)
  return(cbind(data[1:7],data[colname]))
}

generate_results <- function(method, group, data, colname){
  results <- data.frame(
    "Method" = character(),
    "Group" = integer(),
    "Treshold" = double(),
    "Precision" = double(),
    "Recall" = double()
  )
  for (x in seq(0.1,0, by=0.01)){
    results <- rbind(results, data.frame(
      "Method" = method,
      "Group" = group,
      "Treshold" = x,
      "Precision" = get_precision(data, x, colname),
      "Recall" = get_recall(data, x, colname)
    ))
  }
  return(results)
}
