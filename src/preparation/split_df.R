# Split dataset observation based on their source code to speed up reading and searching
library(dplyr)

#load dataset if not present env
if (exists("reclink_data") != TRUE) {
  reclink_data <- readRDS(file = "./data/rds_backups/reclink_data.rds")
}

reclink_WOS <- reclink_data %>%
  filter(PUBLICATION_SOURCE_CODE == "WOS_WS")

reclink_SCOPUS <- reclink_data %>%
  filter(PUBLICATION_SOURCE_CODE == "SCOPUS_WS")

reclink_CROSSREF <- reclink_data %>%
  filter(PUBLICATION_SOURCE_CODE == "CROSSREF_WS")

saveRDS(reclink_WOS, "./data/rds_backups/wos.rds")
saveRDS(reclink_SCOPUS, "./data/rds_backups/scopus.rds")
saveRDS(reclink_CROSSREF, "./data/rds_backups/crossref.rds")
