rm(list = ls())
library(shp2graph)
library(sp)
all <- jsonlite::fromJSON(txt = "./Data/all.json")
geometries <- list()
j <- 1
for (i in 1:length(all)) {
    if ("geometry" %in% colnames(all[[i]])) {
        geometries[[j]] <- all[[i]]$geometry
        j <- j + 1
    }
}

graphall <- function(index) {
    bounds <- do.call(rbind, geometries[[index]])
    plot(geometries[[index]][[1]], type="l",
         xlim = c(min(bounds$lat), max(bounds$lat)),
         ylim = c(min(bounds$lon), max(bounds$lon)))
    colors = heat.colors(length(geometries[[index]]))
    for (i in 1:length(geometries[[index]])) {
        lines(geometries[[index]][[i]], type = "l", col = colors[i], lwd = 2)
    }
}

spatial1 <- list()
for (i in 1:length(geometries[[1]])) {
    spatial1[[i]] <- Lines(list(Line(geometries[[1]][[i]])), ID=as.character(i))
}
test <- SpatialLines(spatial1)
plot(test)
df <- SpatialLinesDataFrame(test, data.frame(ID = c(1:length(test))))
readshpnw(df, longlat = TRUE) -> graph
nel2igraph(graph[[2]], graph[[3]]) -> graph
plot(graph, vertex.label = NA, vertex.size = 1)
