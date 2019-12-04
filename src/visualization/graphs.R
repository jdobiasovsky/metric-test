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



# USE THESE FOR PRECISE RESULTS
show_perfomance_metrics_line <- function(year, graph_title="Precision-Recall curve plot"){
  # Show exact precision-recall graph comparing metrics within years specified in year parameter (Line connectting each observation)
  data_lv <- generate_results_merge("lv", year, "TITLE")
  data_jw <- generate_results_merge("jw", year, "TITLE")
  data_jaro <- generate_results_merge("jaro", year, "TITLE")
  data_cosine3 <- generate_results_merge("cosine3", year, "TITLE")
  data_cosine4 <- generate_results_merge("cosine4", year, "TITLE")
  data_jaccard3 <- generate_results_merge("jaccard3", year, "TITLE")
  data_jaccard4 <- generate_results_merge("jaccard4", year, "TITLE")
  
  ggplot() + 
    geom_line(aes(x=data_lv$Recall, y=data_lv$Precision, color="lv")) +
    geom_line(aes(x=data_jaro$Recall, y=data_jaro$Precision, color="jaro")) +
    geom_line(aes(x=data_jw$Recall, y=data_jw$Precision, color="jw")) +
    geom_line(aes(x=data_cosine3$Recall, y=data_cosine3$Precision, color="cosine3")) +
    geom_line(aes(x=data_cosine4$Recall, y=data_cosine4$Precision, color="cosine4")) +
    geom_line(aes(x=data_jaccard3$Recall, y=data_jaccard3$Precision, color="jaccard3")) +
    geom_line(aes(x=data_jaccard4$Recall, y=data_jaccard4$Precision, color="jaccard4")) +
    labs(title=graph_title,
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

show_fmeasure_treshold <- function(year, graph_title="F-Measure plot"){
  # Show exact precision-recall graph comparing metrics within years specified in year parameter (Line connectting each observation)
  data_lv <- generate_results_merge("lv", year, "TITLE")
  data_jw <- generate_results_merge("jw", year, "TITLE")
  data_jaro <- generate_results_merge("jaro", year, "TITLE")
  data_cosine3 <- generate_results_merge("cosine3", year, "TITLE")
  data_cosine4 <- generate_results_merge("cosine4", year, "TITLE")
  data_jaccard3 <- generate_results_merge("jaccard3", year, "TITLE")
  data_jaccard4 <- generate_results_merge("jaccard4", year, "TITLE")
  
  ggplot() + 
    geom_line(aes(x=data_lv$Treshold, y=data_lv$Fmeasure, color="lv")) +
    geom_line(aes(x=data_jaro$Treshold, y=data_jaro$Fmeasure, color="jaro")) +
    geom_line(aes(x=data_jw$Treshold, y=data_jw$Fmeasure, color="jw")) +
    geom_line(aes(x=data_cosine3$Treshold, y=data_cosine3$Fmeasure, color="cosine3")) +
    geom_line(aes(x=data_cosine3$Treshold, y=data_cosine4$Fmeasure, color="cosine4")) +
    geom_line(aes(x=data_jaccard3$Treshold, y=data_jaccard3$Fmeasure, color="jaccard3")) +
    geom_line(aes(x=data_jaccard4$Treshold, y=data_jaccard4$Fmeasure, color="jaccard4")) +
    labs(title=graph_title,
         x="Treshold", y="F-Measure") 
}


draw_results_graph <- function(metric, year, graph_title="Precision-Recall curve plot"){
  # Precision recall graph of single metric with shown threshold points
  data <- generate_results_merge(metric, year, "TITLE")   

  ggplot(data) + 
    geom_line(aes(x=Recall, y=Precision)) +
    geom_label_repel(aes(x=Recall, y=Precision,label=Treshold), data=data[seq(1, nrow(data), 100), ],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            box.padding   = 0.35, 
                     point.padding = 0.5,
                     segment.color = 'grey50')+
    labs(title=graph_title,
         x="Recall", y="Precision")
}