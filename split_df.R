library(dplyr)
#load dataset if not present env
if (exists("dataset_clean") != TRUE) {
  dataset_clean <- readRDS(file = "dataset_clean.rds")
}

db_WOS <- dataset_clean %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "WOS_WS")

db_SCOPUS <- dataset_clean %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "SCOPUS_WS")

db_CROSSREF <- dataset_clean %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "CROSSREF_WS")

saveRDS(dataset_clean, "wos.rds")
saveRDS(dataset_clean, "scopus.rds")
saveRDS(dataset_clean, "crossref.rds")
