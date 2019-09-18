# Record linkage functions demonstration for one-file serverside script refer to rlink.R
library(stringdist)
library(dplyr)
library(tibble)

data_block <- function(year, type){
  year_start <- year-1
  year_end <- year+1
  group_filter <- c("PUBLICATION", "YEAR","TITLE","ABSTRACT","SOURCE","PUBLISHER","PUBLISHER_LOCATION", "CONFERENCE_NAME", "AUTHORS", "AUTHORS_CTU", "DOI_CODE")
  
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

generate_pairs <- function(targets, candidates, index){
  # Generate table of record comparison candidates
  # For example 10 targets with 20 possible candidates will generate a table of 200 records where each target is compared against all 20 records from candidates
  return(
    tibble(ID1 = rep(targets$PUBLICATION[index], each=nrow(candidates)),    # target ID repeated with total number of comparison operations 
           YEAR1 = rep(targets$YEAR[index], each=nrow(candidates)),         # target YEAR repeated with total number of comparison operations
           ID2 = rep(candidates$PUBLICATION, times=nrow(targets)),   # repeat sequence of candidate publication ID's times nubmer of targets  
           YEAR2 = rep(candidates$YEAR, times=nrow(targets))         # repeat sequence of candidate publication YEAR's times number of target
          )
  )
}

crunch_lev <- function(year) {
  print(paste("Processing candidates for group //", year, "//"))
  grp1 = data_block(year, type = 'targets')
  grp2 = data_block(year, type = 'candidates')
  pairs = generate_pairs(targets = grp1, candidates = grp2, index = 1:nrow(grp1))
  pairs
}

