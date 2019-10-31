library(dplyr)
library(readr)

lv_stand <- function(lv, lv_max){
  return(1-((lv_max - lv)/lv_max))
}


split_training <- function(input, type="default"){
  if (type == 'lv'){
    
    data <- read_csv(input, 
                     col_types = cols(.default = col_double(),
                                      DOI1 = col_character(),
                                      DOI2 = col_character()),
                     na = "NA")
    # get only useful information
    column_filter <- c("TITLE","ABSTRACT","SOURCE","PUBLISHER","PUBLISHER_LOCATION", "CONFERENCE_NAME", "AUTHORS", "AUTHORS_CTU")
    
    # levenshtein distance has to be converted since the original result represents number of operation and not actual <0,1> distance
    for (colname in column_filter){
      data[[colname]] <- mapply(lv_stand, data[[colname]], data[[paste(colname, "_LEN", sep = "")]])
    }
    
    data <- data %>% select(X1,ID1,YEAR1,DOI1,ID2,YEAR2,DOI2,column_filter)
    # if either DOI is missing, save into validation dataset
    write.csv(data %>% filter(is.na(DOI1) |  is.na(DOI2)),
              file = paste("./data/processed_standardised_validation/", basename(input), sep = ""), 
              row.names = FALSE)
    
    # if both compared publications contain DOI save into training dataset
    write.csv(data %>% filter(!is.na(DOI1) & !is.na(DOI2)),
              file = paste("./data/processed_standardised_training/", basename(input), sep = ""), 
              row.names = FALSE)
    
    
  } else {
    # same split method, except without the standardisation step necessary for levenshtein distance
    data <- read_csv(input, 
                     col_types = cols(.default = col_double(),
                                      DOI1 = col_character(),
                                      DOI2 = col_character()),
                     na = "NA")
    
    column_filter <- c("TITLE","ABSTRACT","SOURCE","PUBLISHER","PUBLISHER_LOCATION", "CONFERENCE_NAME", "AUTHORS", "AUTHORS_CTU")
    data <- data %>% select(X1,ID1,YEAR1,DOI1,ID2,YEAR2,DOI2, column_filter)
    # if either DOI is missing, save into validation dataset (to be processed by hand)
    write.csv(data %>% filter(is.na(DOI1) |  is.na(DOI2)),
              file = paste("./data/processed_standardised_validation/", basename(input), sep = ""), 
              row.names = FALSE)
    
    # if both compared publications contain DOI save into training dataset
    write.csv(data %>% filter(!is.na(DOI1) & !is.na(DOI2)),
              file = paste("./data/processed_standardised_training/", basename(input), sep = ""), 
              row.names = FALSE)
  }
  
}