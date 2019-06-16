library(dplyr)
library(forcats)


# each observation is assigned a group based on three year periods of year of publication
reclink_with_groups <- reclink_data %>% 
  mutate(GROUP_ID = group_indices(reclink_data, cut(reclink_data$YEAR, breaks = seq(1945,2020,3), labels = seq(1,25))))
