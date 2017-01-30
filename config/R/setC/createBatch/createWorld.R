source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440p2LURG.R")

simp$sim$folder 	<- "setC"

setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")
simp$sim$parentf	<- ""

simp$batchcreation$agentparam_tmpldir	<- paste(simp$dirs$project, "data", simp$sim$parentf, "agents/template/", sep="/")
simp$batchcreation$production_tmpldir	<- paste(simp$dirs$project, "data", simp$sim$parentf, "production/defined/", sep="/")


simp$paramcreation$startrun <- 0

## adapt templates
## adapt parameters in scripts


## create basic configuration:
#source("./createAftMultifunctionalProductivityManual.R")
source("./createAftParamCSV.R")

source("./create1by1RunCSV.R")

## generate basic social network configurations using python script

## RUN initial run to generate network 

# for evaluation purposes:
#source("./createAftParamVariationMatrixCSV.R")