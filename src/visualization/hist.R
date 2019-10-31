library(dplyr)
library(readr)
library(ggplot2)

#Draw histogram for estimation of positive and negative matches within given file
view_spread_hist <- function(input){
  data <- read_csv(input, 
                   col_types = cols(.default = col_double(),
                                    DOI1 = col_character(),
                                    DOI2 = col_character()),
                   na = "NA")
  
  true_negative <- data %>% filter(DOI1!=DOI2)
  true_positive <- data %>% filter(DOI1==DOI2)
  
  
  return(
    ggplot() + geom_histogram(aes(x=true_negative$TITLE, y = ), bins = 100, na.rm = TRUE, fill = "red", alpha = 0.5) +
      geom_histogram(aes(x=true_positive$TITLE), bins = 100, na.rm = TRUE, fill = "green", alpha = 0.5) + 
      scale_y_log10() +
      ggtitle("Standardised metric values spread") +
      xlab("Simmilarity")
    
  )
}

view_spread_density <- function(input){
  data <- read_csv(input, 
                   col_types = cols(.default = col_double(),
                                    DOI1 = col_character(),
                                    DOI2 = col_character()),
                   na = "NA")
  
  true_negative <- data %>% filter(DOI1!=DOI2)
  true_positive <- data %>% filter(DOI1==DOI2)
  
  return(
    ggplot() + geom_density(aes(x=true_negative$TITLE, y = ), na.rm = TRUE, fill = "red", alpha = 0.5) +
      geom_density(aes(x=true_positive$TITLE), na.rm = TRUE, fill = "green", alpha = 0.5) + 
      ggtitle("Standardised metric values spread") +
      xlab("Simmilarity")  +
      scale_y_sqrt()
    )
}