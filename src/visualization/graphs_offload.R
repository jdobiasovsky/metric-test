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


show_fmeasure_threshold <- function(year, graph_title="F-Measure plot"){
  # Show exact precision-recall graph comparing metrics within years specified in year parameter (Line connectting each observation)
  ggplot() + 
    geom_line(aes(x=open_results_column("lv",year,"Threshold"), y=open_results_column("lv",year,"Fmeasure"), color="lv")) +
    geom_line(aes(x=open_results_column("jaro",year,"Threshold"), y=open_results_column("jaro",year,"Fmeasure"), color="jaro")) +
    geom_line(aes(x=open_results_column("jw",year,"Threshold"), y=open_results_column("jw",year,"Fmeasure"), color="jw")) +
    geom_line(aes(x=open_results_column("cosine3",year,"Threshold"), y=open_results_column("cosine3",year,"Fmeasure"), color="cosine3")) +
    geom_line(aes(x=open_results_column("cosine4",year,"Threshold"), y=open_results_column("cosine4",year,"Fmeasure"), color="cosine4")) +
    geom_line(aes(x=open_results_column("jaccard3",year,"Threshold"), y=open_results_column("jaccard3",year,"Fmeasure"), color="jaccard3")) +
    geom_line(aes(x=open_results_column("jaccard4",year,"Threshold"), y=open_results_column("jaccard4",year,"Fmeasure"), color="jaccard4"))+
    labs(title=graph_title, x="Threshold", y="F-measure")
}



draw_results_graph <- function(metric, year, graph_title="Precision-Recall curve plot"){
  # Precision recall graph of single metric with shown threshold points
  data <- generate_results_merge(metric, year, "TITLE")   
  
  ggplot(data) + 
    geom_line(aes(x=open_results_column(metric,year,"Precision"), y=open_results_column(metric,year,"Recall"))) +
    geom_label_repel(aes(x=Recall, y=Precision,label=Threshold), data=data[seq(1, nrow(data), 100), ],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            box.padding   = 0.35, 
                     point.padding = 0.5,
                     segment.color = 'grey50')+
    labs(title=graph_title,
         x="Recall", y="Precision")
}

draw_optimal_treshold_comparison <- function(year, graph_title="Threshold comparison")
ggplot() +
  ## lines
  geom_line(aes(x=open_results_column("lv",year,"Recall"), y=open_results_column("lv",year,"Precision"), color="lv"), alpha=0.2) +
  geom_line(aes(x=open_results_column("jaro",year,"Recall"), y=open_results_column("jaro",year,"Precision"), color="jaro"), alpha=0.2) +
  geom_line(aes(x=open_results_column("jw",year,"Recall"), y=open_results_column("jw",year,"Precision"), color="jw"), alpha=0.2) +
  geom_line(aes(x=open_results_column("cosine3",year,"Recall"), y=open_results_column("cosine3",year,"Precision"), color="cosine3"), alpha=0.2) +
  geom_line(aes(x=open_results_column("cosine4",year,"Recall"), y=open_results_column("cosine4",year,"Precision"), color="cosine4"), alpha=0.2) +
  geom_line(aes(x=open_results_column("jaccard3",year,"Recall"), y=open_results_column("jaccard3",year,"Precision"), color="jaccard3"), alpha=0.2) +
  geom_line(aes(x=open_results_column("jaccard4",year,"Recall"), y=open_results_column("jaccard4",year,"Precision"), color="jaccard4"), alpha=0.2) +
  # Optimal thresholds
  #lv
  geom_point(data=open_results("./data/results_storage/lv_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, color="lv"),size=3) + 
  geom_label(data=open_results("./data/results_storage/lv_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, label=paste("lv |",Threshold), color="lv"), nudge_y = 0.0004) +
  #jw
  geom_point(data=open_results("./data/results_storage/jw_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, color="jw"),size=3) + 
  geom_label(data=open_results("./data/results_storage/jw_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, label=paste("jw |",Threshold), color="jw"),nudge_y = 0.0004) +
  #jaro
  geom_point(data=open_results("./data/results_storage/jaro_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, color="jaro"),size=3) + 
  geom_label(data=open_results("./data/results_storage/jaro_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, label=paste("jaro |",Threshold), color="jaro"),nudge_y = 0.0004) +
  #jaccard3
  geom_point(data=open_results("./data/results_storage/jaccard3_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, color="jaccard3"),size=3) + 
  geom_label(data=open_results("./data/results_storage/jaccard3_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, label=paste("jaccard |",Threshold), color="jaccard3"),nudge_y = 0.0004) +
  #jaccard4
  geom_point(data=open_results("./data/results_storage/jaccard4_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, color="jaccard4"),size=3) + 
  geom_label(data=open_results("./data/results_storage/jaccard4_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, label=paste("jaccard4 |",Threshold), color="jaccard4"),nudge_y = 0.0004) +
  #cosine3
  geom_point(data=open_results("./data/results_storage/cosine3_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, color="cosine3"),size=3) + 
  geom_label(data=open_results("./data/results_storage/cosine3_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, label=paste("cosine3 |",Threshold), color="cosine3"),nudge_y = 0.0004) +
  #cosine4
  geom_point(data=open_results("./data/results_storage/cosine4_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, color="cosine4"),size=3) + 
  geom_label(data=open_results("./data/results_storage/cosine4_fbeta_1950-2018.csv") %>% arrange(desc(Fmeasure)) %>% slice(1) %>% select(Precision, Recall, Threshold),
             aes(x=Recall,y=Precision, label=paste("cosine4 |",Threshold), color="cosine4"),nudge_y = 0.0004) +
  
  ## Settings
  scale_x_continuous(breaks=seq(from = 0,to = 1, by = 0.001)) +
  scale_y_continuous(breaks=seq(from = 0,to = 1, by = 0.001)) +
  coord_cartesian(xlim=c(0.977,0.99),ylim=c(0.9,0.97)) +
  labs(title="Comparison of optimal thresholds for F-measure", x="Recall", y="Precision")
