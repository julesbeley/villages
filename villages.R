rm(list = ls())
all <- jsonlite::fromJSON(txt = "./Data/all.json")
geometries <- list()
j <- 1
for (i in 1:length(all)) {
    if ("geometry" %in% colnames(all[[i]])) {
        geometries[[j]] <- all[[i]]$geometry
        j <- j + 1
    }
}
# standardise all coordinates taking projection into account
# maybe set the furthest SW coordinate at (0,0) or set the average to (0.0)

graphall <- function(index) {
    bounds <- do.call(rbind, geometries[[index]])
    plot(geometries[[index]][[1]], type="l",
         xlim = c(min(bounds$lat), max(bounds$lat)),
         ylim = c(min(bounds$lon), max(bounds$lon)))
    for (i in 1:length(geometries[[index]])) {
        lines(geometries[[index]][[i]], type = "l")
    }
}
graphall(578)