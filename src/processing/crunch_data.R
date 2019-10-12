# Record linkage functions demonstration for one-file serverside script refer to rlink.R
library(stringdist)
library(dplyr)
library(tibble)
library(readr)

data_block <- function(year, type){
  year_start <- year-1
  year_end <- year+1
  group_filter <- c("PUBLICATION","YEAR", "DOI_CODE", "TITLE","ABSTRACT","SOURCE","PUBLISHER","PUBLISHER_LOCATION", "CONFERENCE_NAME", "AUTHORS", "AUTHORS_CTU")
  
  if (type=='targets'){
  return(
    reclink_SCOPUS %>%
      filter(YEAR == year) %>% 
      select(group_filter)
    )
  }
  
  if (type=='candidates'){
    return(
      grp2 <- reclink_WOS %>% 
        filter(YEAR %in% (year_start:year_end)) %>% 
        select(group_filter)
    )  
  }
  
}

generate_pairs <- function(targets, candidates){
  # Generate table of record comparison candidates. Each observation in the resulting table represents one comparison.
  # For example 10 targets with 20 possible candidates will generate a table of 200 records where each target is compared against all 20 records from candidates.
  return(
    tibble(
      # Each target from sequence is repeated by total number of candidates. 
      ID1 = rep(targets$PUBLICATION, each=nrow(candidates)),
      YEAR1 = rep(targets$YEAR, each=nrow(candidates)),
      DOI1 = rep(targets$DOI_CODE, each=nrow(candidates)),
      # Repeat the sequence of candidates times total number of targets
      ID2 = rep(candidates$PUBLICATION, times=nrow(targets)),
      YEAR2 = rep(candidates$YEAR, times=nrow(targets)),
      DOI2 = rep(candidates$DOI_CODE, times=nrow(targets))
    )
  )
}




crunch <- function(year, metric, stringLength=FALSE, dryRun=FALSE) {
  # Calculate string distances between two data blocks
  if (length(year) > 1){
    stop("Argument 'year' must be a single number")
  }
  print(paste("Processing candidates for group //", year, "//"))
  
  # Split SCOPUS data to block with given year
  grp1 <- data_block(year, type = 'targets')
  
  # Second data block contains records in range (year-1:year+1)
  grp2 <- data_block(year, type = 'candidates')
  
  # Generate pair identification and info
  results <- generate_pairs(targets = grp1, candidates = grp2)
  
  if (nrow(results) == 0){
    
    write.csv(results, file = paste("./results/", metric, year, ".csv", sep = ""))
    return(c("No comparisons found"))
  }
  
  # Set columns for string distance measurement
  group_filter <- c("TITLE","ABSTRACT","SOURCE","PUBLISHER","PUBLISHER_LOCATION", "CONFERENCE_NAME", "AUTHORS", "AUTHORS_CTU")
  
  # Calculate total number of operations
  print(paste("Operations per column: ", nrow(results)))
  print(paste("Total number of operations: ", nrow(results)*length(group_filter)))
  
  # Exit if dry run is toggled on, else continue
  if (dryRun == TRUE) {
    return(results)
  }
  
  if (stringLength == TRUE) {
    for(colname in group_filter) {
      # TODO calculate distances of both grp1 and grp2 via TITLE_LEN1 & TITLE_LEN2
      results[,paste(colname, "_LEN",sep = "")] <- nchar(unlist(grp1[,colname], use.names = FALSE))
    }
  }
  
  # Calculate string distances columnwise
  for (colname in group_filter)
    
    results[,colname] <- stringdist(a = unlist(rep(grp1[,colname], each=nrow(grp2)), use.names = FALSE),
                                    b = unlist(rep(grp2[,colname], times=nrow(grp1)), use.names = FALSE),
                                    method = metric
                                    )
  print("Done... writing results.")
  write.csv(results, file = paste("./data/processed/", metric, year,".csv", sep = ""))
  #return(glimpse(results))
}
