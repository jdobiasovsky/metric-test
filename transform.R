library(dbplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(purrr)
library(tibble)
library(anytime)

#load dataset if not present env
if (exists("dataset_raw") != TRUE) {
  dataset_raw <- readRDS(file = "dataset_raw.rds")
}

# apply parse function with specified data type, store in new data frame: dataset_clean

dataset_clean <- dataset_raw %>%
  dplyr::mutate(PUBLICATION_DUPL = parse_logical(dataset_raw$PUBLICATION_DUPL)) %>%
  dplyr::mutate(YEAR = parse_date(dataset_raw$YEAR, format = "%Y")) %>%
  dplyr::mutate(VALID = parse_logical(dataset_raw$VALID)) %>%
  dplyr::mutate(ISSUE_DATE=anytime::anydate(ISSUE_DATE)) %>%
  dplyr::mutate(CONFERENCE_START_DATE=anytime::anydate(CONFERENCE_START_DATE)) %>%
  dplyr::mutate(CONFERENCE_END_DATE=anytime::anydate(CONFERENCE_END_DATE)) %>%
  dplyr::mutate(WHEN_CHANGED=anytime::anydate(WHEN_CHANGED)) %>%
  dplyr::mutate(WHEN_ADDED_TO_INDEX=anytime::anydate(WHEN_ADDED_TO_INDEX)) %>%
  dplyr::mutate(WHEN_CREATED=anytime::anydate(WHEN_CREATED)) %>%
  dplyr::mutate(WHEN_FIRST_FAILURE=anytime::anydate(WHEN_CHANGED)) %>%
  dplyr::mutate(WHEN_LAST_FAILURE=anytime::anydate(WHEN_LAST_FAILURE))
  
saveRDS(dataset_clean, "dataset_clean.rds")
