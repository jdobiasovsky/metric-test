library(readr)
library(dplyr)
library(stringdist)


# Create dataset
dataset_raw <- read_csv("data/export_updated.csv", col_types = cols(.default = "c")) #load all collumns as characters, will be parsed separately
saveRDS(dataset_raw, "./rds/dataset_raw.rds")

# load dataset if not present env
if (exists("dataset_raw") != TRUE) {
  dataset_raw <- readRDS(file = "./rds/dataset_raw.rds")
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
saveRDS(dataset_clean_human, "./rds/dataset_clean_human.rds")

# Data pre-processing
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

# load dataset if not present env
if (exists("dataset_clean") != TRUE) {
  dataset_clean <- readRDS(file = "./rds/dataset_clean.rds")
}

# split main dataset based on DB
db_WOS <- dataset_clean_human %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "WOS_WS")

db_SCOPUS <- dataset_clean_human %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "SCOPUS_WS")

db_CROSSREF <- dataset_clean_human %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "CROSSREF_WS")

saveRDS(dataset_clean_human, "./rds/wos.rds")
saveRDS(dataset_clean_human, "./rds/scopus.rds")
saveRDS(dataset_clean_human, "./rds/crossref.rds")

# split main dataset based on DB
reclink_WOS <- reclink_data %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "WOS_WS")

reclink_SCOPUS <- reclink_data %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "SCOPUS_WS")

reclink_CROSSREF <- reclink_data %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "CROSSREF_WS")

reclink_data %>% 
  dplyr::filter(PUBLICATION_SOURCE_CODE == "WOS_WS") %>% 
  filter(YEAR %in% (1990:1992)) %>% 
  select(TITLE,ABSTRACT,SOURCE,PUBLISHER,PUBLISHER_LOCATION, CONFERENCE_NAME, AUTHORS, AUTHORS_CTU, DOI_CODE)

# Data processing
# subset based on years
grp1 <- reclink_SCOPUS %>%
  filter(YEAR %in% (2005:2007)) %>% 
  select(TITLE,ABSTRACT,SOURCE,PUBLISHER,PUBLISHER_LOCATION, CONFERENCE_NAME, AUTHORS, AUTHORS_CTU, DOI_CODE)

grp2 <- reclink_WOS %>% 
  filter(YEAR %in% (2005:2007)) %>% 
  select(TITLE,ABSTRACT,SOURCE,PUBLISHER,PUBLISHER_LOCATION, CONFERENCE_NAME, AUTHORS, AUTHORS_CTU, DOI_CODE)


grp1 <- as.data.frame(grp1)
grp2 <- as.data.frame(grp2)

# prepare results dataframe
results <- data.frame(matrix(ncol = 9, nrow = 0))
colnames(results) <- c("TITLE","ABSTRACT","SOURCE","PUBLISHER","PUBLISHER_LOCATION", "CONFERENCE_NAME", "AUTHORS", "AUTHORS_CTU", "DOI_CODE")

# test each row in grp1 against all rows from grp2
for (row in 1:nrow(grp1)){
  # append to the dataframe with results
  results <- rbind(results, mapply(stringdist, grp1[row,], grp2, "lv"))
}

write.csv(results_lev,"./data/results_lev.csv", row.names = TRUE)
saveRDS(results_lev, "./rds/results_lev.rds")
