library(readr)
dataset_raw <- read_csv("data/export_updated.csv", col_types = cols(.default = "c")) #load all collumns as characters, will be parsed separately
View(dataset_raw)
