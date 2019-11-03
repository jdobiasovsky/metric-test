open_data <- function(input){
  # quick processed files loading from csv
  data <- read_csv(input, 
                   col_types = cols(.default = col_double(),
                                    DOI1 = col_character(),
                                    DOI2 = col_character()),
                   na = "NA")
  return(data)
}

open_multiple <- function(list){
  return(do.call(rbind,lapply(list,open_data)))
}

build_path <- function(base, metric,year, extension){
  return(paste(base, metric, "_", year, extension, sep = ""))
}

filter_tn <- function(path, column){
  # filter out true negatives for given column, keep info
  data <- open_data(path)
  # Filter out true negative matches (DOI's don't match and are below lowest considered treshold)
  data <- as_tibble(cbind(data[1:7],data[column])) %>% filter(!(UQ(as.symbol(column)) >= 0.11 & DOI1!=DOI2))
  write_csv(x = data, path = paste("./data/precision_recall/", basename(path), sep = ""))
}