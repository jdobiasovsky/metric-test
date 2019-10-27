open_data <- function(input){
  data <- read_csv(input, 
                   col_types = cols(.default = col_double(),
                                    DOI1 = col_character(),
                                    DOI2 = col_character()),
                   na = "NA")
  return(data)
}
