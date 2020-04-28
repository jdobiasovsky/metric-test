ggplot() + 
  geom_line(aes(x=open_results_column("lv",2016:2018,"Recall"), y=open_results_column("lv",2016:2018,"Precision"), color="2016-2018")) +
  geom_line(aes(x=open_results_column("lv",2009:2018,"Recall"), y=open_results_column("lv",2009:2018,"Precision"), color="2009-2018")) +
  geom_line(aes(x=open_results_column("lv",1950:2018,"Recall"), y=open_results_column("lv",1950:2018,"Precision"), color="1950-2018")) +
  labs(title="Precision vs. recall for metric [lv]", x="Recall", y="Precision")

ggsave(filename = "PrecisionRecall_lv.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "PrecisionRecall_lv_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("jaro",2016:2018,"Recall"), y=open_results_column("jaro",2016:2018,"Precision"), color="2016-2018")) +
  geom_line(aes(x=open_results_column("jaro",2009:2018,"Recall"), y=open_results_column("jaro",2009:2018,"Precision"), color="2009-2018")) +
  geom_line(aes(x=open_results_column("jaro",1950:2018,"Recall"), y=open_results_column("jaro",1950:2018,"Precision"), color="1950-2018")) +
  labs(title="Precision vs. recall for metric [jaro]", x="Recall", y="Precision")

ggsave(filename = "PrecisionRecall_jaro.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "PrecisionRecall_jaro_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("jw",2016:2018,"Recall"), y=open_results_column("jw",2016:2018,"Precision"), color="2016-2018")) +
  geom_line(aes(x=open_results_column("jw",2009:2018,"Recall"), y=open_results_column("jw",2009:2018,"Precision"), color="2009-2018")) +
  geom_line(aes(x=open_results_column("jw",1950:2018,"Recall"), y=open_results_column("jw",1950:2018,"Precision"), color="1950-2018")) +
  labs(title="Precision vs. recall for metric [jw]", x="Recall", y="Precision")

ggsave(filename = "PrecisionRecall_jw.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "PrecisionRecall_jw_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("cosine3",2016:2018,"Recall"), y=open_results_column("cosine3",2016:2018,"Precision"), color="2016-2018")) +
  geom_line(aes(x=open_results_column("cosine3",2009:2018,"Recall"), y=open_results_column("cosine3",2009:2018,"Precision"), color="2009-2018")) +
  geom_line(aes(x=open_results_column("cosine3",1950:2018,"Recall"), y=open_results_column("cosine3",1950:2018,"Precision"), color="1950-2018")) +
  labs(title="Precision vs. recall for metric [cosine3]", x="Recall", y="Precision")

ggsave(filename = "PrecisionRecall_cosine3.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "PrecisionRecall_cosine3_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("cosine4",2016:2018,"Recall"), y=open_results_column("cosine4",2016:2018,"Precision"), color="2016-2018")) +
  geom_line(aes(x=open_results_column("cosine4",2009:2018,"Recall"), y=open_results_column("cosine4",2009:2018,"Precision"), color="2009-2018")) +
  geom_line(aes(x=open_results_column("cosine4",1950:2018,"Recall"), y=open_results_column("cosine4",1950:2018,"Precision"), color="1950-2018")) +
  labs(title="Precision vs. recall for metric [cosine4]", x="Recall", y="Precision")

ggsave(filename = "PrecisionRecall_cosine4.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "PrecisionRecall_lv_cosine4.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("jaccard3",2016:2018,"Recall"), y=open_results_column("jaccard3",2016:2018,"Precision"), color="2016-2018")) +
  geom_line(aes(x=open_results_column("jaccard3",2009:2018,"Recall"), y=open_results_column("jaccard3",2009:2018,"Precision"), color="2009-2018")) +
  geom_line(aes(x=open_results_column("jaccard3",1950:2018,"Recall"), y=open_results_column("jaccard3",1950:2018,"Precision"), color="1950-2018")) +
  labs(title="Precision vs. recall for metric [jaccard3]", x="Recall", y="Precision")

ggsave(filename = "PrecisionRecall_jaccard3.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "PrecisionRecall_jaccard3_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("jaccard4",2016:2018,"Recall"), y=open_results_column("jaccard4",2016:2018,"Precision"), color="2016-2018")) +
  geom_line(aes(x=open_results_column("jaccard4",2009:2018,"Recall"), y=open_results_column("jaccard4",2009:2018,"Precision"), color="2009-2018")) +
  geom_line(aes(x=open_results_column("jaccard4",1950:2018,"Recall"), y=open_results_column("jaccard4",1950:2018,"Precision"), color="1950-2018")) +
  labs(title="Precision vs. recall for metric [jaccard4]", x="Recall", y="Precision")

ggsave(filename = "PrecisionRecall_jaccard4.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "PrecisionRecall_jaccard4_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("lv_fbeta",1950:2018,"Treshold"), y=open_results_column("lv_fbeta",1950:2018,"Fmeasure"), color="F-measure")) +
  geom_line(aes(x=open_results_column("lv_fbeta",1950:2018,"Treshold"), y=open_results_column("lv_fbeta",1950:2018,"F2measure"), color="F_2-measure")) +
  geom_line(aes(x=open_results_column("lv_fbeta",1950:2018,"Treshold"), y=open_results_column("lv_fbeta",1950:2018,"F3measure"), color="F_3-measure")) +
  labs(title="F_beta-measure comparison for metric [lv]", x="Treshold", y="F_beta-measure value")

ggsave(filename = "fbeta_lv.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "fbeta_lv_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("jw_fbeta",1950:2018,"Treshold"), y=open_results_column("jw_fbeta",1950:2018,"Fmeasure"), color="F-measure")) +
  geom_line(aes(x=open_results_column("jw_fbeta",1950:2018,"Treshold"), y=open_results_column("jw_fbeta",1950:2018,"F2measure"), color="F_2-measure")) +
  geom_line(aes(x=open_results_column("jw_fbeta",1950:2018,"Treshold"), y=open_results_column("jw_fbeta",1950:2018,"F3measure"), color="F_3-measure")) +
  labs(title="F_beta-measure comparison for metric [jw]", x="Treshold", y="F_beta-measure value")

ggsave(filename = "fbeta_jw.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "fbeta_jw_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("jaro_fbeta",1950:2018,"Treshold"), y=open_results_column("jaro_fbeta",1950:2018,"Fmeasure"), color="F-measure")) +
  geom_line(aes(x=open_results_column("jaro_fbeta",1950:2018,"Treshold"), y=open_results_column("jaro_fbeta",1950:2018,"F2measure"), color="F_2-measure")) +
  geom_line(aes(x=open_results_column("jaro_fbeta",1950:2018,"Treshold"), y=open_results_column("jaro_fbeta",1950:2018,"F3measure"), color="F_3-measure")) +
  labs(title="F_beta-measure comparison for metric [jaro]", x="Treshold", y="F_beta-measure value")

ggsave(filename = "fbeta_jaro.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "fbeta_jaro_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("cosine3_fbeta",1950:2018,"Treshold"), y=open_results_column("cosine3_fbeta",1950:2018,"Fmeasure"), color="F-measure")) +
  geom_line(aes(x=open_results_column("cosine3_fbeta",1950:2018,"Treshold"), y=open_results_column("cosine3_fbeta",1950:2018,"F2measure"), color="F_2-measure")) +
  geom_line(aes(x=open_results_column("cosine3_fbeta",1950:2018,"Treshold"), y=open_results_column("cosine3_fbeta",1950:2018,"F3measure"), color="F_3-measure")) +
  labs(title="F_beta-measure comparison for metric [cosine3]", x="Treshold", y="F_beta-measure value")

ggsave(filename = "fbeta_cosine3.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "fbeta_cosine3_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("cosine4_fbeta",1950:2018,"Treshold"), y=open_results_column("cosine4_fbeta",1950:2018,"Fmeasure"), color="F-measure")) +
  geom_line(aes(x=open_results_column("cosine4_fbeta",1950:2018,"Treshold"), y=open_results_column("cosine4_fbeta",1950:2018,"F2measure"), color="F_2-measure")) +
  geom_line(aes(x=open_results_column("cosine4_fbeta",1950:2018,"Treshold"), y=open_results_column("cosine4_fbeta",1950:2018,"F3measure"), color="F_3-measure")) +
  labs(title="F_beta-measure comparison for metric [cosine4]", x="Treshold", y="F_beta-measure value")

ggsave(filename = "fbeta_cosine4.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "fbeta_cosine4_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("jaccard3_fbeta",1950:2018,"Treshold"), y=open_results_column("jaccard3_fbeta",1950:2018,"Fmeasure"), color="F-measure")) +
  geom_line(aes(x=open_results_column("jaccard3_fbeta",1950:2018,"Treshold"), y=open_results_column("jaccard3_fbeta",1950:2018,"F2measure"), color="F_2-measure")) +
  geom_line(aes(x=open_results_column("jaccard3_fbeta",1950:2018,"Treshold"), y=open_results_column("jaccard3_fbeta",1950:2018,"F3measure"), color="F_3-measure")) +
  labs(title="F_beta-measure comparison for metric [jaccard3]", x="Treshold", y="F_beta-measure value")

ggsave(filename = "fbeta_jaccard3.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "fbeta_jaccard3_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")

ggplot() + 
  geom_line(aes(x=open_results_column("jaccard4_fbeta",1950:2018,"Treshold"), y=open_results_column("jaccard4_fbeta",1950:2018,"Fmeasure"), color="F-measure")) +
  geom_line(aes(x=open_results_column("jaccard4_fbeta",1950:2018,"Treshold"), y=open_results_column("jaccard4_fbeta",1950:2018,"F2measure"), color="F_2-measure")) +
  geom_line(aes(x=open_results_column("jaccard4_fbeta",1950:2018,"Treshold"), y=open_results_column("jaccard4_fbeta",1950:2018,"F3measure"), color="F_3-measure")) +
  labs(title="F_beta-measure comparison for metric [jaccard4]", x="Treshold", y="F_beta-measure value")

ggsave(filename = "fbeta_jaccard4.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "fbeta_jaccard4_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")