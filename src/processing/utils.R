open_data <- function(input){
  # quick processed files loading from csv
  data <- read_csv(input, 
                   col_types = cols(.default = col_double(),
                                    DOI1 = col_character(),
                                    DOI2 = col_character()),
                   na = "NA")
  return(data)
}

open_results <- function(input){
  return(read_csv("data/results_storage/lv_2000-2000.csv", 
           col_types = cols(FN = col_double(), FP = col_double(), 
                            Fmeasure = col_double(), Precision = col_double(), 
                            Recall = col_double(), TP = col_double(), 
                            Treshold = col_double()), trim_ws = FALSE))
}

open_results_column <- function(metric,year,colname){
  if (colname == "Treshold"){
    return(unlist(
      read_csv(
        file = build_path(base = "./data/results_storage/", 
                          metric=metric, 
                          year = paste(head(year, n=1),tail(year,n=1), sep = "-"),
                          extension = ".csv"),
        col_types = cols_only(Treshold = col_double())
        )
    ), use.names=FALSE)
  } else if (colname == "Precision"){
      return(
        unlist(
          read_csv(file = build_path(base = "./data/results_storage/", 
                                     metric=metric, 
                                     year = paste(head(year, n=1),tail(year,n=1), sep = "-"),
                                     extension = ".csv"),
          col_types = cols_only(Precision = col_double())
          )
      ), use.names=FALSE)
  } else if (colname == "Recall"){
    return(
      unlist(
        read_csv(file = build_path(base = "./data/results_storage/", 
                                   metric=metric, 
                                   year = paste(head(year, n=1),tail(year,n=1), sep = "-"),
                                   extension = ".csv"),
                 col_types = cols_only(Recall = col_double())
                 )
        ), use.names=FALSE)
  } else if (colname == "Fmeasure"){
    return(
      unlist(
        read_csv(file = build_path(base = "./data/results_storage/", 
                                   metric=metric, 
                                   year = paste(head(year, n=1),tail(year,n=1), sep = "-"),
                                   extension = ".csv"),
                 col_types = cols_only(Fmeasure = col_double())
                 )
        ), use.names=FALSE)
  } else {
    return(NA)
  }
}

open_multiple <- function(list){
  return(do.call(rbind,lapply(list,open_data)))
}

build_path <- function(base, metric, year, extension){
  return(paste(base, metric, "_", year, extension, sep = ""))
}
