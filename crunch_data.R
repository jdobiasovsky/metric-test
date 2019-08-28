library(stringdist)
library(dplyr)


crunch <- function(year, metric) {
  # Data processing
  # subset based on years
  
  year_start <- year-1
  year_end <- year+1
  print(paste("Processing years in group //", year_start, "-", year_end, "//"))
  
  grp1 <- reclink_SCOPUS %>%
    filter(YEAR %in% (year_start:year_end)) %>% 
    select(TITLE,ABSTRACT,SOURCE,PUBLISHER,PUBLISHER_LOCATION, CONFERENCE_NAME, AUTHORS, AUTHORS_CTU, DOI_CODE)
  
  grp2 <- reclink_WOS %>% 
    filter(YEAR %in% (year_start:year_end)) %>% 
    select(TITLE,ABSTRACT,SOURCE,PUBLISHER,PUBLISHER_LOCATION, CONFERENCE_NAME, AUTHORS, AUTHORS_CTU, DOI_CODE)
  
  
  grp1 <- as.data.frame(grp1)
  grp2 <- as.data.frame(grp2)
  
  
  # test each row in grp1 against all rows from grp2
  for (row in 1:nrow(grp1)){
    # append to the dataframe with results
    results_lev <- rbind(results_lev, mapply(stringdist, grp1[row,], grp2, metric))
  }
  
  
  write.table(results_lev, file = paste("./data/results_", metric, ".csv", sep = ""), sep = ",", col.names = FALSE, append = TRUE)
}


# prepare results dataframe
results_lev <- data.frame(matrix(ncol = 9, nrow = 0))
colnames(results_lev) <- c("TITLE","ABSTRACT","SOURCE","PUBLISHER","PUBLISHER_LOCATION", "CONFERENCE_NAME", "AUTHORS", "AUTHORS_CTU", "DOI_CODE")

# saving this stuff
x <- data.frame(a = I("a \" quote"), b = pi)
write.table(x, file = "foo.csv", sep = ",", col.names = NA,
            qmethod = "double")
## and to read this file back into R one needs
read.table("foo.csv", header = TRUE, sep = ",", row.names = 1)
## NB: you do need to specify a separator if qmethod = "double".
