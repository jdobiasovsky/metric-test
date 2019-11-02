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


### USE stat_ecdf() for distribution
view_spread_ecdf <- function(input){
  data <- read_csv(input, 
                   col_types = cols(.default = col_double(),
                                    DOI1 = col_character(),
                                    DOI2 = col_character()),
                   na = "NA")
  
  tp <- data %>% filter(DOI1==DOI2)
  tn <- data %>% filter(DOI1!=DOI2)
  
  ggplot() + 
    stat_ecdf(aes(tp$TITLE), color = "green", na.rm = TRUE) + 
    stat_ecdf(aes(tn$TITLE), color= "red", na.rm = TRUE) + 
    labs(title="Empirical Cumulative Density Function",
         y = "F(Distance)", x="Distance")
  
  # alternative with area fill 
  # ggplot() + 
  #   stat_ecdf(aes(tp$TITLE), fill = "green", na.rm = TRUE, geom = "area" ) + 
  #   stat_ecdf(aes(tn$TITLE), fill = "red", na.rm = TRUE, geom = "area") + 
  #   labs(title="Empirical Cumulative Density Function",
  #        y = "F(Distance)", x="Distance")
  # 
}
