library(dplyr)
library(stringdist)

generate_pairs <- function(pbl_id){
  reclink_groups %>% 
    filter(GROUP_ID==reclink_groups[which(reclink_groups$PUBLICATION == pbl_id), ]$GROUP_ID) %>%
    filter(PUBLICATION_SOURCE_CODE!=reclink_groups[which(reclink_groups$PUBLICATION == pbl_id), ]$PUBLICATION_SOURCE_CODE) %>%
    select(PUBLICATION) %>% unlist(use.names = FALSE) %>%
    return()
}

b# each observation is assigned a group based on three year periods of year of publication
# TODO only publications with different PUBLICATION_SOURCE_CODE in same group?
reclink_groups <- reclink_data %>% 
  mutate(GROUP_ID = group_indices(reclink_data, cut(reclink_data$YEAR, breaks = seq(1945,2020,3), labels = seq(1,25))))

# convert DOI to numeric id
reclink_groups <- reclink_groups %>% 
  mutate(DOI_ID = group_indices(reclink_groups, DOI_CODE))

# count number of observations with same group ID (this number of records will be compared with filter to eliminate comparing 2 records from same source)
grouped_obs_count <- reclink_groups %>% group_by(GROUP_ID, PUBLICATION_SOURCE_CODE) %>% filter(PUBLICATION_SOURCE_CODE!="WOS_WS") %>% tally()

# generate comparison pairs (each record from group against all other that belong in same group, but do not have same PUBLICATION_SOURCE_CODE)
reclink_groups <- reclink_groups %>% 
  mutate(COMPARISON_PAIRS = for (id in reclink_groups$PUBLICATION){
    generate_pairs(id)
    }) %>%
# 