# Dataset loading and pre-processing
# You might want to overwrite the paths used or create the neccessary directories if they're missing
library(readr)
library(dplyr)
library(anytime)


#All columns loaded as characters, parsing is done separately in dataset_clean_human since there are some modifications needed with dates
dataset_raw <- read_csv("./data/raw_import/export_final.csv", col_types = cols(.default = "c")) 
saveRDS(dataset_raw, "./data/rds_backups/dataset_raw.rds")

#load dataset if not present env
# if (exists("dataset_raw") != TRUE) {
#   dataset_raw <- readRDS(file = "./rds/dataset_raw.rds")
# }

# apply parse function with specified data type, store in new data frame: dataset_clean_human

dataset_clean_human <- dataset_raw %>%
  mutate(YEAR=parse_number(dataset_raw$YEAR)) %>%
  mutate(PUBLICATION_DUPL=parse_logical(dataset_raw$PUBLICATION_DUPL)) %>%
  mutate(VALID=parse_logical(dataset_raw$VALID)) %>%
  mutate(ISSUE_DATE=anytime::anydate(ISSUE_DATE)) %>%
  mutate(CONFERENCE_START_DATE=anytime::anydate(CONFERENCE_START_DATE)) %>%
  mutate(CONFERENCE_END_DATE=anytime::anydate(CONFERENCE_END_DATE)) %>%
  mutate(WHEN_CHANGED=anytime::anydate(WHEN_CHANGED)) %>%
  mutate(WHEN_ADDED_TO_INDEX=anytime::anydate(WHEN_ADDED_TO_INDEX)) %>%
  mutate(WHEN_CREATED=anytime::anydate(WHEN_CREATED)) %>%
  mutate(WHEN_FIRST_FAILURE=anytime::anydate(WHEN_CHANGED)) %>%
  mutate(WHEN_LAST_FAILURE=anytime::anydate(WHEN_LAST_FAILURE))

# backup the human readable version before proceeding
saveRDS(dataset_clean_human, "./data/rds_backups/dataset_clean_human.rds")

# pre-process dataset for record linkage 
# strip punctiation
reclink_data <- dataset_clean_human %>%
  mutate(PUBLICATION=dataset_clean_human$PUBLICATION) %>%
  mutate(YEAR=dataset_clean_human$YEAR) %>%
  mutate(TITLE=gsub('[[:punct:]]| ','',dataset_clean_human$TITLE)) %>%
  mutate(ABSTRACT=gsub('[[:punct:]]| ','',dataset_clean_human$ABSTRACT)) %>%
  mutate(SOURCE=gsub('[[:punct:]]| ','',dataset_clean_human$SOURCE)) %>%
  mutate(PUBLISHER=gsub('[[:punct:]]| ','',dataset_clean_human$PUBLISHER)) %>%
  mutate(AUTHORS=gsub('[[:punct:]]| ','',dataset_clean_human$AUTHORS)) %>%
  mutate(AUTHORS_CTU=gsub('[[:punct:]]| ','',dataset_clean_human$AUTHORS_CTU)) 

# convert all to lowercase
reclink_data <- reclink_data %>%
  mutate(TITLE=tolower(TITLE)) %>%
  mutate(ABSTRACT=tolower(ABSTRACT)) %>%
  mutate(DOI_CODE=tolower(DOI_CODE)) %>%
  mutate(SOURCE=tolower(SOURCE)) %>%
  mutate(PUBLISHER=tolower(PUBLISHER)) %>%
  mutate(AUTHORS=tolower(AUTHORS)) %>%
  mutate(AUTHORS_CTU=tolower(AUTHORS_CTU))

saveRDS(reclink_data, "./data/rds_backups/reclink_data.rds")