rm(list = ls())
library(tidyverse)
all <- read.csv("villes.csv",
                encoding = "UTF-8",
                header = TRUE,
                stringsAsFactors = FALSE)
all %>% select(c("Ozan", "X618", "X01190", "X93")) %>% 
    rename("Name" = "Ozan", 
           "Population" = "X618",
           "CP" = "X01190",
           "Density" = "X93") %>% 
    filter(Population < 800 
           & Population > 100
           & Density < 80) -> villages
rm(all)

# create Overpass query

queries <- c()
for (i in villages$Name) {
    queries[i] <- paste('[out:json][timeout:25];{{geocodeArea:',
                        i,
                        '}}->.searchArea;(way["highway"](area.searchArea);-way["highway"~"motorway|motorway_link|trunk|trunk_link"](area.searchArea););out body;>;out skel qt;',
                        sep = "")
    }
