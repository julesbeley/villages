rm(list = ls())
library(tidyverse)
all <- read.csv("villes.csv",
                encoding = "UTF-8",
                header = TRUE,
                stringsAsFactors = FALSE)
all %>% select(c("X01", "Ozan", "X618", "X01190", "X93")) %>% 
    rename("code" = "X01",
           "town.name" = "Ozan", 
           "population" = "X618",
           "cp" = "X01190",
           "density" = "X93") %>% 
    filter(population < 800 
           & population > 100
           & density < 80) -> villages
rm(all)
read.csv("départements.csv", 
         encoding = "UTF-8",
         header = FALSE,
         stringsAsFactors = FALSE) %>% 
    select(c("V2","V3")) %>% 
    rename("code" = "V2",
           "departement.name" = "V3") -> departements
dplyr::left_join(villages, departements, by = "code") -> villages
rm(departements)

httpqueries <- c()
for (i in (1:nrow(villages))) {
    queries[i] <- paste('http://overpass-api.de/api/interpreter?data=[out:json];area[name="',
                        villages$departement.name[i],
                        '"]->.b;rel(area.b)[name="',
                        villages$town.name[i],
                        '"];map_to_area -> .a;(way(area.a)["highway"];-way(area.a)["highway"~"motorway|motorway_link|trunk|trunk_link"];);out;',
                        sep = "")
}

cat(queries[2])

# create curl queries (by batches?)


#sink
#source
#dump