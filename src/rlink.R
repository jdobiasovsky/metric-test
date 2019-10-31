# Convenience script that loads dataset and performs record linkage for all 5 metrics one after another
source("src/preparation/load_dataset.R", echo = TRUE)
source("src/preparation/split_df.R", echo = TRUE)
rm(dataset_clean_human, dataset_raw, reclink_data, reclink_CROSSREF, envir = .GlobalEnv)
source("src/processing/crunch_data.R")

# Raw processing, calculate string simmilarities
for (mtrc in c("lv", "jaro", "jw", "jaccard", "qgram")){
  for (year in 1950:2019){
    crunch(year = year, metric = mtrc, stringLength = TRUE)
  }
}


# Standardise and create neat files for visualisation and learning
source("src/processing/analysis.R")
for (file in list.files(path = "./data/processed_raw", full.names = TRUE))   {
     print(paste("Standardising ", file))
     
  }
     