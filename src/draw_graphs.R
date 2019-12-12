# Generate neccesary data calling prep_plot_data() and draw all required graphs.
time_start <- Sys.time()
source("./src/visualization/setenv.R")

print("Generating data for test group 1...")
prep_plot_data(2008:2018)
show_perfomance_metrics_line(2008:2018, "Metric precision vs. recall [2008-2018]")
ggsave(filename = "PrecisionRecall_2008-2018.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "PrecisionRecall_2008-2018_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")
gc()
print("Graph done [1/6]")


show_fmeasure_treshold(2008:2018, "Metric F-measure vs. treshold [2008-2018]")
ggsave(filename = "Fmeasure_2008-2018.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "Fmeasure_2008-2018_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")
gc()
print("Graph done [2/6]")

print("Generating data for test group 2...")
prep_plot_data(1950:2018)
show_perfomance_metrics_line(1950:2018, "Metric precision vs. recall [1950-2018]")
ggsave(filename = "PrecisionReca1l_1950-2018.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "PrecisionRecall_1950-2018_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")
gc()
print("Graph done [3/6]")


show_fmeasure_treshold(1950:2018, "Metric F-measure vs. treshold [1950-2018]")
ggsave(filename = "Fmeasure1950-2018.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "Fmeasure1950-2018_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")
gc()
print("Graph done [4/6]")

print("Generating data for test group 3...")
prep_plot_data(2016:2018)
show_perfomance_metrics_line(2016:2018, "Metric precision vs. recall [2016-2018]")
ggsave(filename = "PrecisionRecall_2016-2018.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "PrecisionRecall_2016-2018_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")
gc()
print("Graph done [5/6]")


show_fmeasure_treshold(2016:2018, "Metric F-measure vs. treshold [2016-2018]")
ggsave(filename = "Fmeasure_2016-2018.png", path = "./data/graphs_remote/", width = 5, height = 4, dpi = "print" , units = "in")
ggsave(filename = "Fmeasure_2016-2018_hd.png", path = "./data/graphs_remote/", width = 10, height = 8, dpi = "print" , units = "in")
gc()
print("Graph done [6/6]")

time_stop <- Sys.time()
difftime(time_stop, time_start, units = "hours")