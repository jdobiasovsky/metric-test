# EXPLORATORY ANALYSIS
show_perfomance_years_overview <- function(metric){
  # Smoothed precision-recall graph for exploratory analysis grouped by years
  data2000_2010 <- generate_results_merge(metric, 2000:2010, "TITLE")
  data2010_2015 <- generate_results_merge(metric, 2010:2015, "TITLE")
  data2016 <- generate_results_merge(metric, 2016, "TITLE")
  data2017 <- generate_results_merge(metric, 2017, "TITLE")
  data2018 <- generate_results_merge(metric, 2018, "TITLE")
  
  ggplot() + 
    geom_smooth(aes(x=data2000_2010$Recall, y=data2000_2010$Precision, color="2000-2010"), method="auto") +
    geom_smooth(aes(x=data2010_2015$Recall, y=data2010_2015$Precision, color="2010-2015"), method="auto") +
    geom_smooth(aes(x=data2016$Recall, y=data2016$Precision, color="2016"), method="auto") +
    geom_smooth(aes(x=data2017$Recall, y=data2017$Precision, color="2017"), method="auto") +
    geom_smooth(aes(x=data2018$Recall, y=data2018$Precision, color="2018"), method="auto") +
    labs(title=paste("Precision-Recall curve plot for", metric),
         x="Recall", y="Precision")
}

show_perfomance_metrics_overview <- function(year){
  # Smoothed precision-recall graph for exploratory analysis grouped by metrics
  data_lv <- generate_results_merge("lv", year, "TITLE")
  data_jw <- generate_results_merge("jw", year, "TITLE")
  data_jaro <- generate_results_merge("jaro", year, "TITLE")
  data_cosine3 <- generate_results_merge("cosine3", year, "TITLE")
  data_cosine4 <- generate_results_merge("cosine4", year, "TITLE")
  data_jaccard3 <- generate_results_merge("jaccard3", year, "TITLE")
  data_jaccard4 <- generate_results_merge("jaccard4", year, "TITLE")
  
  ggplot() + 
    geom_smooth(aes(x=data_lv$Recall, y=data_lv$Precision, color="lv"), method="auto") +
    geom_smooth(aes(x=data_jaro$Recall, y=data_jaro$Precision, color="jaro"), method="auto") +
    geom_smooth(aes(x=data_jw$Recall, y=data_jw$Precision, color="jw"), method="auto") +
    geom_smooth(aes(x=data_cosine3$Recall, y=data_cosine3$Precision, color="cosine3"), method="auto") +
    geom_smooth(aes(x=data_cosine4$Recall, y=data_cosine4$Precision, color="cosine4"), method="auto") +
    geom_smooth(aes(x=data_jaccard3$Recall, y=data_jaccard3$Precision, color="jaccard3"), method="auto") +
    geom_smooth(aes(x=data_jaccard4$Recall, y=data_jaccard4$Precision, color="jaccard4"), method="auto") +
    labs(title="Precision-Recall curve plot",
         x="Recall", y="Precision")
}

show_perfomance_metrics_point <- function(year, graph_title="Precision-Recall curve plot"){
  # Show exact precision-recall graph comparing metrics within years specified in year parameter (Draw dots for each observation)
  data_lv <- generate_results_merge("lv", year, "TITLE")
  data_jw <- generate_results_merge("jw", year, "TITLE")
  data_jaro <- generate_results_merge("jaro", year, "TITLE")
  data_cosine3 <- generate_results_merge("cosine3", year, "TITLE")
  data_cosine4 <- generate_results_merge("cosine4", year, "TITLE")
  data_jaccard3 <- generate_results_merge("jaccard3", year, "TITLE")
  data_jaccard4 <- generate_results_merge("jaccard4", year, "TITLE")
  
  ggplot() + 
    geom_point(aes(x=data_lv$Recall, y=data_lv$Precision, color="lv")) +
    geom_point(aes(x=data_jaro$Recall, y=data_jaro$Precision, color="jaro")) +
    geom_point(aes(x=data_jw$Recall, y=data_jw$Precision, color="jw")) +
    geom_point(aes(x=data_cosine3$Recall, y=data_cosine3$Precision, color="cosine3")) +
    geom_point(aes(x=data_cosine4$Recall, y=data_cosine4$Precision, color="cosine4")) +
    geom_point(aes(x=data_jaccard3$Recall, y=data_jaccard3$Precision, color="jaccard3")) +
    geom_point(aes(x=data_jaccard4$Recall, y=data_jaccard4$Precision, color="jaccard4")) +
    labs(title=graph_title,
         x="Recall", y="Precision")
}