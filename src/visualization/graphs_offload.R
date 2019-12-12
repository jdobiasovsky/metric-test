# Graph plotting from previously generated results
prep_plot_data <- function(year){
  # helper function to generate all data required for plot in one command
  print("Begin data generation")
  generate_results_merge("lv", year, "TITLE")
  print("Finished generating results for LV [1/7]")
  generate_results_merge("jw", year, "TITLE")
  print("Finished generating results for JW [2/7]")
  generate_results_merge("jaro", year, "TITLE")
  print("Finished generating results for JARO [3/7]")
  generate_results_merge("cosine3", year, "TITLE")
  print("Finished generating results for COSINE3 [4/7]")
  generate_results_merge("cosine4", year, "TITLE")
  print("Finished generating results for COSINE4 [5/7]")
  generate_results_merge("jaccard3", year, "TITLE")
  print("Finished generating results for JACCARD3 [6/7]")
  generate_results_merge("jaccard4", year, "TITLE")
  print("Finished generating results for JACCARD4 [7/7]")
}



show_perfomance_metrics_line <- function(year, graph_title="Precision-Recall curve plot"){
  # Show exact precision-recall graph comparing metrics within years specified in year parameter (Line connectting each observation)
  ggplot() + 
    geom_line(aes(x=open_results_column("lv",year,"Recall"), y=open_results_column("lv",year,"Precision"), color="lv")) +
    geom_line(aes(x=open_results_column("jaro",year,"Recall"), y=open_results_column("jaro",year,"Precision"), color="jaro")) +
    geom_line(aes(x=open_results_column("jw",year,"Recall"), y=open_results_column("jw",year,"Precision"), color="jw")) +
    geom_line(aes(x=open_results_column("cosine3",year,"Recall"), y=open_results_column("cosine3",year,"Precision"), color="cosine3")) +
    geom_line(aes(x=open_results_column("cosine4",year,"Recall"), y=open_results_column("cosine4",year,"Precision"), color="cosine4")) +
    geom_line(aes(x=open_results_column("jaccard3",year,"Recall"), y=open_results_column("jaccard3",year,"Precision"), color="jaccard3")) +
    geom_line(aes(x=open_results_column("jaccard4",year,"Recall"), y=open_results_column("jaccard4",year,"Precision"), color="jaccard4")) +
    labs(title=graph_title, x="Recall", y="Precision")
}


show_fmeasure_treshold <- function(year, graph_title="F-Measure plot"){
  # Show exact precision-recall graph comparing metrics within years specified in year parameter (Line connectting each observation)
  ggplot() + 
    geom_line(aes(x=open_results_column("lv",year,"Treshold"), y=open_results_column("lv",year,"Fmeasure"), color="lv")) +
    geom_line(aes(x=open_results_column("jaro",year,"Treshold"), y=open_results_column("jaro",year,"Fmeasure"), color="jaro")) +
    geom_line(aes(x=open_results_column("jw",year,"Treshold"), y=open_results_column("jw",year,"Fmeasure"), color="jw")) +
    geom_line(aes(x=open_results_column("cosine3",year,"Treshold"), y=open_results_column("cosine3",year,"Fmeasure"), color="cosine3")) +
    geom_line(aes(x=open_results_column("cosine4",year,"Treshold"), y=open_results_column("cosine4",year,"Fmeasure"), color="cosine4")) +
    geom_line(aes(x=open_results_column("jaccard3",year,"Treshold"), y=open_results_column("jaccard3",year,"Fmeasure"), color="jaccard3")) +
    geom_line(aes(x=open_results_column("jaccard4",year,"Treshold"), y=open_results_column("jaccard4",year,"Fmeasure"), color="jaccard4"))+
    labs(title=graph_title, x="Treshold", y="F-measure")
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