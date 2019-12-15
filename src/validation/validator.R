cat("\014")
for (x in c(1:100)){
  print(paste("Record no. ", x, "/ 100"))
  print(validation[x,])
  dataset %>% select(PUBLICATION,TITLE,SOURCE,EDITION_INFO,PUBLISHER,AUTHORS,CONFERENCE_NAME,DOC_TYPE_CODE) %>% filter(PUBLICATION==validation[[x,"ID1"]]) %>% glimpse()
  dataset %>% select(PUBLICATION,TITLE,SOURCE,EDITION_INFO,PUBLISHER,AUTHORS,CONFERENCE_NAME,DOC_TYPE_CODE) %>% filter(PUBLICATION==validation[[x,"ID2"]]) %>% glimpse()
  validation[x,"CONTROL"] <- readline(prompt="Decision: ")
  cat("\014")
}
write_csv(validation,"./data/cosine4_validation.csv")
