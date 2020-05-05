# metric-test
R script for comparing efficiency of edit distance metrics used in my diploma thesis. 

Thesis citation: 
DOBIÁŠOVSKÝ, Jan. Approximate equality of character strings and its application to record linkage in metadata of scientific publications [online]. Praha, 2020 [cit. 2020-05-04]. Masters thesis. Charles University. Faculty of Arts. Institute of Information Studies and Librarianship.

You can view the thesis here:
#TODO add link to repository once published


The results are available here:
https://doi.org/10.5281/zenodo.3785363


# Script description:

To sum up entire process, the script loads all necessary data and generates pairs for matching. For each such pair a string distance for each paired column is calculated. Pairs that contain DOI identifiers are saved into training data. Based on comparison of DOI identifiers and specific threshold value we can then classify these pairs as true positive, true negative, false positive or false negative matches. With these values it is possible to determine precision, recall and F-measure on each treshold and determine optimal threshold for matching data without the identifiers with minimal unwanted results.

The entire process is divided into 4 main stages:

## Preparation

This section provides a script for loading the original .csv file (not available due to copyright and legal restrictions) and splitting the data into 3 datasets based on publication record origin. 

Both scripts are available for running by using following commands:

```
source("./src/preparation/load_dataset.R")
source("./src/preparation/split_df")
```

During this process all columns required for record matching are stripped of punctuation and converted to lowercase.
After the execution, following variables should appear in your environment.

**dataset_raw** - original unchanged dataset state before any parsing functions and input cleaning are done
**dataset_clean_human** - human readable version of the dataset with parsed columns, used for familiarising with the dataset and some operations during validation
**reclink_WOS,reclink_SCOPUS,reclink_CROSSREF** - subsetted data based on record origin. Crossref data weren't used in the record linkage


*Note: Some of the variables loaded into environment are not used for actual string distance generation and record matching, they are purged from memory automatically at the process start but you can do it manually as well:*
```
rm(dataset_clean_human, dataset_raw, reclink_data, reclink_CROSSREF, envir = .GlobalEnv)
```



## Processing

This is where most of the magic happens. This folder contains main script for generating string distances, standardization and some utilities for general data wrangling. Script at metric-test/src/rlink.R can also be used to get all the raw string distances generated in one go.

Process can also be executed manually by first preparing your environment:
```
source("src/preparation/load_dataset.R", echo = TRUE)
source("src/preparation/split_df.R", echo = TRUE)
rm(dataset_clean_human, dataset_raw, reclink_data, reclink_CROSSREF, envir = .GlobalEnv)
source("src/processing/crunch_data.R")
prep_env()
```
and then calling crunch() function with these parameters specified:

*year* - which year should be processed. Use single year only, ranges or multiple year arguments are not currently available
*metric* - what metric to use for string distance, should be one of following c("lv", "jaro", "jw", "jaccard3","jaccard4" "cosine3", "cosine4"). To further specify stringdist parameters refer to the function itself, to be more specific lines 130-146 of src/processing/crunch_data.R
*stringLenght* = TRUE | FALSE - some string distances are not immediately in <0,1> format and total string lenght has to be used. Use FALSE if you want to do the standardisation on your own without /src/processing/standardization.R . Otherwise use TRUE.
*dryRun = FALSE | TRUE* - if set to true, the script will return the generated pairs and structure without the calculated distances. Use for demonstration of process or testing.

So for example if we want to process all records from year 2015 from the dataset with levenshtein distance we call:
```crunch(2015, "lv", stringLength=TRUE) ```

Entire process can be also automated by using loops or do.call: 
```
for (mtrc in c("lv", "jaro", "jw", "jaccard3","jaccard4" "cosine3", "cosine4")){
  for (year in 1950:2019){
    crunch(year = year, metric = mtrc, stringLength = TRUE)
  }
}
```

**/src/processing/standardization.R**
Provides two main utilities: 
- split_training() which filters out pairs with and without DOI records for given raw processed result
- filter_tn() which helps flatten the dataset a little bit by filtering out true negative matches (DOI's don't match and are below lowest considered treshold - currently 0.6)
- is lv_stand() which converts levenshtein distance to <0,1> range using the distance and maximum string lenght of the character. There are also some functions for filtering invalid DOI's which currently work only with provided list that were filtered out of the original dataset using external process to make the process little bit more precise. 


**/src/processing/results.R**
This script can be used to load the processed and standardised data. 
Each pair generated has the DOI pairs compared. Based on whether DOI's match and given the set threshold, it is decided whether the result would be classified as true positive, false positive or false negative. For example if DOI's match and the string distance is lower than threshold. The pair would be classified as true positive. If the DOI doesn't match, but the string
distance was lower than threshold, the pair does not contain same publications and it is therefore false positive. 
Generated data is saved into .csv data for further processing and visualisation.

## Visualization
This section contains mainly scripts for visualizing data and/or scripts used to create the graphs in the thesis. /src/visualization/prep_env.R can be used to quickly setup work environment and scripts with graph_ prefix to visualise data

## Validation 
Provides convenience scripts for quickly creating test samples for manual validation and script used to help with the evaluation itself
