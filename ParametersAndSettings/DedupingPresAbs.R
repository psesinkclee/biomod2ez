library(dplyr)
library(tidyr)
library(readr)

dat <- read_csv('XXXXXXXXXXXXXXXXXX.csv')     #INSERT THE FILEPATH TO YOUR PRESENCE/ABSENCE TABLE HERE

myRespName = "XXXXXXXX"                       #NAME OF COLUMN WITH SPECIES DATA

new <- dat %>%
  mutate(X = as.factor(XXXXXXXX),             #NAME OF COLUMN WITH 'X' COORDINATE
         Y = as.factor(XXXXXXXX)) %>%         #NAME OF COLUMN WITH 'Y' COORDINATE
  select(X,Y,XXXXXXXX) %>%                    #NAME OF COLUMN WITH SPECIES DATA
  group_by(X,Y) %>%
  summarise(hits=sum(myRespName),
            N=n(),
            freq=hits/N)

View(new)
write.table(new,file="deduped_presabs")