open_data <- function(input){
  # quick processed files loading from csv
  data <- read_csv(input, 
                   col_types = cols(.default = col_double(),
                                    DOI1 = col_character(),
                                    DOI2 = col_character()),
                   na = "NA")
  return(data)
}

filter_tn <- function(path, column){
  # filter out true negatives for given column, keep info
  data <- open_data(path)
  # Filter out true negative matches (DOI's don't match and are below lowest considered treshold)
  data <- as.tibble(cbind(data[1:7],data[column])) %>% filter(DOI1!=DOI2 & UQ(as.symbol(column)) <= 0.11)
  write_csv(x = data, path = paste("./data/precision_recall/", basename(path), sep = ""))
}
