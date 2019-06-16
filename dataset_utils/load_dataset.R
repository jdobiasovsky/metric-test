library(readr)
library(dplyr)

dataset_raw <- read_csv("data/export_updated.csv", col_types = cols(.default = "c")) #load all collumns as characters, will be parsed separately
saveRDS(dataset_raw, "./data/dataset_raw.rds")

#load dataset if not present env
if (exists("dataset_raw") != TRUE) {
  dataset_raw <- readRDS(file = "./data/dataset_raw.rds")
}

# apply parse function with specified data type, store in new data frame: dataset_clean

dataset_clean_human <- dataset_raw %>%
  dplyr::mutate(YEAR=parse_number(dataset_raw$YEAR)) %>%
  dplyr::mutate(PUBLICATION_DUPL=parse_logical(dataset_raw$PUBLICATION_DUPL)) %>%
  dplyr::mutate(VALID=parse_logical(dataset_raw$VALID)) %>%
  dplyr::mutate(ISSUE_DATE=anytime::anydate(ISSUE_DATE)) %>%
  dplyr::mutate(CONFERENCE_START_DATE=anytime::anydate(CONFERENCE_START_DATE)) %>%
  dplyr::mutate(CONFERENCE_END_DATE=anytime::anydate(CONFERENCE_END_DATE)) %>%
  dplyr::mutate(WHEN_CHANGED=anytime::anydate(WHEN_CHANGED)) %>%
  dplyr::mutate(WHEN_ADDED_TO_INDEX=anytime::anydate(WHEN_ADDED_TO_INDEX)) %>%
  dplyr::mutate(WHEN_CREATED=anytime::anydate(WHEN_CREATED)) %>%
  dplyr::mutate(WHEN_FIRST_FAILURE=anytime::anydate(WHEN_CHANGED)) %>%
  dplyr::mutate(WHEN_LAST_FAILURE=anytime::anydate(WHEN_LAST_FAILURE))

# create human readable version before proceeding
saveRDS(dataset_clean_human, "./data/dataset_clean_human.rds")

# strip punctiation
reclink_data <- dataset_clean_human %>%
  dplyr::mutate(TITLE=gsub('[[:punct:]]| ','',dataset_clean_human$TITLE)) %>%
  dplyr::mutate(ABSTRACT=gsub('[[:punct:]]| ','',dataset_clean_human$ABSTRACT)) %>%
  dplyr::mutate(SOURCE=gsub('[[:punct:]]| ','',dataset_clean_human$SOURCE)) %>%
  dplyr::mutate(PUBLISHER=gsub('[[:punct:]]| ','',dataset_clean_human$PUBLISHER)) %>%
  dplyr::mutate(AUTHORS=gsub('[[:punct:]]| ','',dataset_clean_human$AUTHORS)) %>%
  dplyr::mutate(AUTHORS_CTU=gsub('[[:punct:]]| ','',dataset_clean_human$AUTHORS_CTU)) 

# convert all to lowercase
reclink_data <- reclink_data %>%
  dplyr::mutate(TITLE=tolower(TITLE)) %>%
  dplyr::mutate(ABSTRACT=tolower(ABSTRACT)) %>%
  dplyr::mutate(SOURCE=tolower(SOURCE)) %>%
  dplyr::mutate(PUBLISHER=tolower(PUBLISHER)) %>%
  dplyr::mutate(AUTHORS=tolower(AUTHORS)) %>%
  dplyr::mutate(AUTHORS_CTU=tolower(AUTHORS_CTU))
