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
  # helper function for opening and exploring results files (loads as tibble)
  return(read_csv(input, 
           col_types = cols(FN = col_double(), FP = col_double(), 
                            Fmeasure = col_double(), Precision = col_double(), 
                            Recall = col_double(), TP = col_double(), 
                            Treshold = col_double()), trim_ws = FALSE))
}

open_results_column <- function(metric,year,colname){
  # open specific column of results file as vector. Used for plotting graphs
  if (colname == "Treshold"){
    return(
      unlist(
        read_csv(file = build_path(base = "./data/results_storage/", 
                                   metric=metric, 
                                   year = paste(head(year, n=1),tail(year,n=1), sep = "-"),
                                   extension = ".csv"),
                  col_types = cols_only(Treshold = col_double())
                  )
        ,use.names=FALSE)
    )
  } else if (colname == "Precision"){
    return(
      unlist(
        read_csv(file = build_path(base = "./data/results_storage/", 
                                   metric=metric, 
                                   year = paste(head(year, n=1),tail(year,n=1), sep = "-"),
                                   extension = ".csv"),
                 col_types = cols_only(Precision = col_double())
        )
        ,use.names=FALSE)
    )
  } else if (colname == "Recall"){
    return(
      unlist(
        read_csv(file = build_path(base = "./data/results_storage/", 
                                   metric=metric, 
                                   year = paste(head(year, n=1),tail(year,n=1), sep = "-"),
                                   extension = ".csv"),
                 col_types = cols_only(Recall = col_double())
        )
        ,use.names=FALSE)
    )
  } else if (colname == "Fmeasure"){
    return(
      unlist(
        read_csv(file = build_path(base = "./data/results_storage/", 
                                   metric=metric, 
                                   year = paste(head(year, n=1),tail(year,n=1), sep = "-"),
                                   extension = ".csv"),
                 col_types = cols_only(Fmeasure = col_double())
        )
        ,use.names=FALSE)
    )
  } else if (colname == "F2measure"){
    return(
      unlist(
        read_csv(file = build_path(base = "./data/results_storage/", 
                                   metric=metric, 
                                   year = paste(head(year, n=1),tail(year,n=1), sep = "-"),
                                   extension = ".csv"),
                 col_types = cols_only(F2measure = col_double())
        )
        ,use.names=FALSE)
    )
  } else if (colname == "F3measure"){
    return(
      unlist(
        read_csv(file = build_path(base = "./data/results_storage/", 
                                   metric=metric, 
                                   year = paste(head(year, n=1),tail(year,n=1), sep = "-"),
                                   extension = ".csv"),
                 col_types = cols_only(F3measure = col_double())
        )
        ,use.names=FALSE)
    )  
  } else {
    return(NA)
  }
}

open_multiple <- function(list){
  # call open_data on multiple files
  return(do.call(rbind,lapply(list,open_data)))
}

build_path <- function(base, metric, year, extension){
  # utility for generating paths to files
  return(paste(base, metric, "_", year, extension, sep = ""))
}
