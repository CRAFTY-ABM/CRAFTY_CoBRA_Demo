source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440p2LURG.R")

simp$sim$folder 	<- "setB"
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")

simp$sim$runids <- "4-0"
addColourAttributeFr(simp, graphfilename = paste(input_tools_getModelOutputDir(simp), "/Social-Network-EE.graphml", sep=""))