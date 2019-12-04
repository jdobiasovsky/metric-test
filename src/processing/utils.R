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

build_path <- function(base, metric, year, extension){
  return(paste(base, metric, "_", year, extension, sep = ""))
}

