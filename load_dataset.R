library(readr)
dataset_raw <- read_csv("data/export_updated.csv", col_types = cols(.default = "c")) #load all collumns as characters, will be parsed separately
saveRDS(dataset_clean, "dataset_raw.rds")
View(dataset_raw)
