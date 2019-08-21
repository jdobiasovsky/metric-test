library(dplyr)
#load dataset if not present env
if (exists("dataset_clean") != TRUE) {
  dataset_clean <- readRDS(file = "./rds/dataset_clean.rds")
}

db_WOS <- dataset_clean_human %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "WOS_WS")

db_SCOPUS <- dataset_clean_human %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "SCOPUS_WS")

db_CROSSREF <- dataset_clean_human %>%
  dplyr::filter(PUBLICATION_SOURCE_CODE == "CROSSREF_WS")

saveRDS(dataset_clean_human, "./rds/wos.rds")
saveRDS(dataset_clean_human, "./rds/scopus.rds")
saveRDS(dataset_clean_human, "./rds/crossref.rds")
