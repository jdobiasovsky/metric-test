# Open relevant source file
validation <- open_multiple(list = list.files("./data/processed_standardised_validation/", pattern = "cosine4", full.names = TRUE))
# Trim dataset to only contain single treshold and relevant columns
validation <- validation[,(1:8)] %>% filter(TITLE<=0.1754) %>% sample_n(100)
# Add column for control results
validation <- validation %>% mutate(CONTROL=rep(NA,times=100))


# use validation[x,"CONTROL"] <- readline(prompt="Decision: ") to add manually if needed