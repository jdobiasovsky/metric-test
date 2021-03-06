# Convenience script that loads dataset and performs record linkage for all 5 metrics one after another
source("src/preparation/load_dataset.R")
source("src/preparation/split_df.R")
source("src/processing/crunch_data.R")
prep_env() # clear unnecessary variables

# Raw processing, calculate string simmilarities
for (mtrc in c("lv", "jaro", "jw", "jaccard3","jaccard4" "cosine3", "cosine4")){
  for (year in 1950:2019){
    crunch(year = year, metric = mtrc, stringLength = TRUE)
  }
}
