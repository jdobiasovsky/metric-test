# Subset data and perform string distance operations
library(stringdist)
library(dplyr)
library(tibble)


prep_env <- function(){
  # Remove variables that are not needed for processsing from memory to free it up a bit
  rm(dataset_clean_human, dataset_raw, reclink_data, reclink_CROSSREF, envir = .GlobalEnv)
}


data_block <- function(year, type){
  # filter data into blocks based on year of publication with 1 exact year for record linkage targets and 3 year span for candidates
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
  # Generate table of record comparison candidates. Each observation in the resulting table represents one comparison operation.
  # For example 10 targets with 20 possible candidates will generate a table of 200 records where each target is compared against all 20 records from candidates.
  return(
    tibble(
      # Create tibble with 6 columns
      # Each target from sequence is repeated by total number of candidates
      ID1 = rep(targets$PUBLICATION, each=nrow(candidates)),
      YEAR1 = rep(targets$YEAR, each=nrow(candidates)),
      DOI1 = rep(targets$DOI_CODE, each=nrow(candidates)),
      # Repeat the sequence of candidates times total number of targets, so now there is every possible pair combination
      ID2 = rep(candidates$PUBLICATION, times=nrow(targets)),
      YEAR2 = rep(candidates$YEAR, times=nrow(targets)),
      DOI2 = rep(candidates$DOI_CODE, times=nrow(targets))
    )
  )
}


generate_sequence <- function(targets, candidates, sequence_of) {
  # generalised function of generate_pairs for use in the actual record comparison and secondary processing
  # generate sequence of all candidates for each target
  if (sequence_of == 'targets'){
    return(rep(targets, each=length(candidates)))
  }
  if (sequence_of == 'candidates'){
    return(rep(candidates, times=length(targets)))
  }
}


crunch <- function(year, metric, stringLength=FALSE, dryRun=FALSE) {
  # Calculate string distances between two data blocks
  if (length(year) > 1){
    stop("Please use only one year per run, if you want to process multiple years use do.call or a loop to save up memory.")
  }
  print(paste("Processing candidates for group //", year, "//"))
  
  # Split SCOPUS data to block with given year
  grp1 <- data_block(year, type = 'targets')
  
  # Second data block contains records in range (year-1:year+1)
  grp2 <- data_block(year, type = 'candidates')
  
  # Generate pair identification and info
  results <- generate_pairs(targets = grp1, candidates = grp2)
  
  if (nrow(results) == 0){
    results_empty <- data.frame(matrix(ncol = 14, nrow = 0))
    colnames(results_empty) <- c(colnames(results), group_filter)
    write.csv(as_tibble(results_empty), file = paste("./data/processed_raw/", metric, year, ".csv", sep = ""))
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
    # calculate maximum string lengths for each column
    for(colname in group_filter) {
      # prepare sequences and calculate string lenghts
      sequence_targets_len <- nchar(generate_sequence(grp1[[colname]], grp2[[colname]], sequence_of = 'targets'))
      sequence_candidates_len <- nchar(generate_sequence(grp1[[colname]], grp2[[colname]], sequence_of = 'candidates'))
      
      # interpret missing values as zero length
      sequence_targets_len[is.na(sequence_targets_len)] <- 0
      sequence_candidates_len[is.na(sequence_candidates_len)] <- 0
      
      # merge into single vector contaning greater length from these two sequences
      sequence_targets_len[sequence_targets_len < sequence_candidates_len] <- sequence_candidates_len[sequence_candidates_len > sequence_targets_len]
      
      # write into resulting table
      results[,paste(colname, "_LEN",sep = "")] <- sequence_targets_len
    }
  }
  
  # Calculate string distances columnwise)
  for (colname in group_filter){
    # extract data needed for comparison of given column and generate sequence
    sequence_targets <- generate_sequence(grp1[[colname]], grp2[[colname]], sequence_of = 'targets')
    sequence_candidates <- generate_sequence(grp1[[colname]], grp2[[colname]], sequence_of = 'candidates' )
    
    # perform string comparison between the two sequences
    if (metric == "jaro"){
      results[,colname] <- stringdist(a = sequence_targets, b = sequence_candidates, method = "jw", p=0)
    } else if (metric == "jw"){
      results[,colname] <- stringdist(a = sequence_targets, b = sequence_candidates, method = "jw", p=0.1)
    } else {
      results[,colname] <- stringdist(a = sequence_targets, b = sequence_candidates, method = metric)
    }
  }
  print("Done... writing results.")
  write.csv(results, file = paste("./data/processed_raw/", metric, year,".csv", sep = ""))
}
