library(dplyr)
library(readr)
library(ggplot2)
library(wesanderson)

lv_stand <- function(lv, lv_max){
  return((lv_max - lv)/lv_max)
  }

standardize <- function(input, type){
  if (type == 'lv'){
    data <- read_csv(input, 
                     col_types = cols(.default = col_double(),
                                      DOI1 = col_character(),
                                      DOI2 = col_character()),
                     na = "NA")
    
    column_filter <- c("TITLE","ABSTRACT","SOURCE","PUBLISHER","PUBLISHER_LOCATION", "CONFERENCE_NAME", "AUTHORS", "AUTHORS_CTU")
    
    for (colname in column_filter){
      data[[paste(colname, "_STD", sep = "")]] <- mapply(lv_stand, data[[colname]], data[[paste(colname, "_LEN", sep = "")]])
    }
    
    data <- data %>% select(X1,ID1,YEAR1,DOI1,ID2,YEAR2,DOI2, paste(column_filter,"_STD", sep = ""))
    # if either DOI is missing, save into validation dataset
    write.csv(data %>% filter(is.na(DOI1) |  is.na(DOI2)),
              file = paste("./data/processed_standardised_validation/", basename(input), sep = ""), 
              row.names = FALSE)
    # if both compared publications contain DOI save into training dataset
    write.csv(data %>% filter(!is.na(DOI1) & !is.na(DOI2)),
              file = paste("./data/processed_standardised_training/", basename(input), sep = ""), 
              row.names = FALSE)
  }
}
