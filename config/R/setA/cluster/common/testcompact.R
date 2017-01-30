source("/exports/csce/eddie/geos/groups/LURG/models/CRAFTY_CoBRA_Demo/0.1_2016-10-24_22-18/config/R/simp-machine_cluster.R")

simp$sim$folder <- "setA"
setwd(paste(simp$dirs$simp, simp$sim$folder, "cluster/common", sep="/"))


require(methods)
preserve <- list()


run = 3; rseed = 1
preserve$run = run
preserve$seed = rseed
preserve$task = paste(preserve$run, preserve$seed, sep="-") 

simp$sim$folder 	<- "setA"


setwd(paste(simp$dirs$simp, sep="/"))
source(paste(simp$dirs$simp, simp$sim$folder, "simp.R", sep="/"))
source(paste(simp$dirs$simp, simp$sim$folder, "cluster/common/functions.R", sep="/"))

simp$sim$runids <- c(paste(preserve$run, "-", preserve$seed, sep=""))	# run to deal with
simp$sim$id	<- c(paste(preserve$run, "-", preserve$seed, sep=""))	# ID to identify specific data collections (e.g. regions)
simp$sim$task <- c(paste(preserve$run, "-", preserve$seed, sep=""))	# Name of surrounding folder, usually a description of task 

simp$fig$init <- function(simp, outdir, filename) {}
simp$fig$close<- function() {}

futile.logger::flog.threshold(futile.logger::INFO, name='craftyr')

# adjust figure settings:
library(ggplot2)
library(kfigr)
#ggplot2::theme_set(visualisation_raster_legendonlytheme(base_size = 10))
simp$fig$facetlabelsize	<- 11