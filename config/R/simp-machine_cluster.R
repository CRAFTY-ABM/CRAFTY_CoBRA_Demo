###############################################################################
# Machine=specific SIMP definition
#
# NOTE: Changes in super-level parameters that are used to derive further
# parameters need to trigger a re-evaluation of the derived parameters!
#
# Project:		NetSens (IMPRESSIONS)
# Last update: 	29/10/2015
# Author: 		Sascha Holzhauer
################################################################################

### Clean/Remove existing definitions ##########################################
rm(list=ls(name=globalenv(), pattern="[^{preserve}]"), envir=globalenv())

### Project Root ###############################################################
project			<- "/home/users/0033/uk052959/LURG/models/CRAFTY_CoBRA_Demo/0.1_2016-10-24_22-18/"

if (!exists("preserve")) {
	preserve <- list()
	preserve$run = 0
}
#### Load default SIMP #########################################################
source(paste(project, "/config/R/simpBasic.R", sep=""))
simp$dirs$project <- project

#### Set path to itself ########################################################
simp$simpDefinition <- paste(simp$dirs$project, "config/R/simp-machine_cluster.R", sep="")

### Directories ###############################################################

simp$dirs$data 				<- paste(simp$dirs$project, "data/", sep="")
simp$dirs$simp				<- paste(simp$dirs$project, "./config/R/", sep="")

simp$dirs$outputdir			<- paste("/home/users/0033/uk052959/LURG/models/CRAFTY_CoBRA_Demo/Output/%VFOLDER%/", sep="/")

simp$dirs$output$simulation	<- paste(simp$dirs$project, "/output/%VFOLDER%/", sep="")
simp$dirs$output$data		<- paste(simp$dirs$project, "data/", sep="")
simp$dirs$output$rdata		<- paste(simp$dirs$outputdir, "RData/", sep="") 
simp$dirs$output$raster		<- paste(simp$dirs$outputdir, "Raster/", sep="") 
simp$dirs$output$figures	<- paste(simp$dirs$outputdir, "Figures/", sep="")
simp$dirs$output$reports	<- paste(simp$dirs$outputdir, "Reports/", sep="")
simp$dirs$output$tables		<- paste(simp$dirs$outputdir, "/Tables/", sep="")
simp$dirs$output$csv		<- paste(simp$dirs$outputdir, "/CSV/", sep="")
simp$dirs$output$runinfo	<- paste(simp$dirs$project, "CRAFTY_CoBRA-Illustration_Runs.ods", sep="/")

futile.logger::flog.info("Current working directory: %s",
			getwd(),
			name = "demo.simp")
