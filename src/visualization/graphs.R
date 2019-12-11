# USE THESE FOR PRECISE RESULTS
show_perfomance_metrics_line <- function(year, graph_title="Precision-Recall curve plot"){
  # Show exact precision-recall graph comparing metrics within years specified in year parameter (Line connectting each observation)
  print("Begin results generation.")
  data_lv <- generate_results_merge("lv", year, "TITLE")
  print("Finished generating results for LV [1/7]")
  data_jw <- generate_results_merge("jw", year, "TITLE")
  print("Finished generating results for JW [2/7]")
  data_jaro <- generate_results_merge("jaro", year, "TITLE")
  print("Finished generating results for JARO [3/7]")
  data_cosine3 <- generate_results_merge("cosine3", year, "TITLE")
  print("Finished generating results for COSINE3 [4/7]")
  data_cosine4 <- generate_results_merge("cosine4", year, "TITLE")
  print("Finished generating results for COSINE4 [5/7]")
  data_jaccard3 <- generate_results_merge("jaccard3", year, "TITLE")
  print("Finished generating results for JACCARD3 [6/7]")
  data_jaccard4 <- generate_results_merge("jaccard4", year, "TITLE")
  print("Finished generating results for JACCARD4 [7/7]")
  
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


show_fmeasure_treshold <- function(year, graph_title="F-Measure plot"){
  # Show exact precision-recall graph comparing metrics within years specified in year parameter (Line connectting each observation)
  print("Begin results generation.")
  data_lv <- generate_results_merge("lv", year, "TITLE")
  print("Finished generating results for LV [1/7]")
  data_jw <- generate_results_merge("jw", year, "TITLE")
  print("Finished generating results for JW [2/7]")
  data_jaro <- generate_results_merge("jaro", year, "TITLE")
  print("Finished generating results for JARO [3/7]")
  data_cosine3 <- generate_results_merge("cosine3", year, "TITLE")
  print("Finished generating results for COSINE3 [4/7]")
  data_cosine4 <- generate_results_merge("cosine4", year, "TITLE")
  print("Finished generating results for COSINE4 [5/7]")
  data_jaccard3 <- generate_results_merge("jaccard3", year, "TITLE")
  print("Finished generating results for JACCARD3 [6/7]")
  data_jaccard4 <- generate_results_merge("jaccard4", year, "TITLE")
  print("Finished generating results for JACCARD4 [7/7]")
  
  print("Results generation done, plotting graph")
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