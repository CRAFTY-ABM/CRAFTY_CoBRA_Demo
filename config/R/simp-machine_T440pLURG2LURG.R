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
project			<- "C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/"

if (!exists("preserve")) {
	preserve <- list()
	preserve$run = 0
}
#### Load default SIMP #########################################################
source(paste(project, "/config/R/simpBasic.R", sep=""))
simp$dirs$project <- project

#### Set path to itself ########################################################
simp$simpDefinition <- paste(simp$dirs$project, "config/R/simp-machine_T440pLURG2LURG.R", sep="")

### Directories ###############################################################
simp$dirs$data 				<- paste(simp$dirs$project, "data/", sep="")
simp$dirs$simp				<- paste(simp$dirs$project, "./config/R/", sep="")

simp$dirs$outputdir			<- "L:/Projects/Impressions/Modelling/CRAFTY_CoBRA_Demo/Output/%VFOLDER%/"
simp$dirs$outputdirWS		<- paste(simp$dirs$project, "/Output/%VFOLDER%/", sep="")

simp$dirs$output$simulation	<- paste(simp$dirs$outputdir, sep="")
simp$dirs$output$data		<- paste(simp$dirs$project, "Data/", sep="")
simp$dirs$output$rdata		<- paste(simp$dirs$outputdir, "RData/", sep="") 
simp$dirs$output$raster		<- paste(simp$dirs$outputdir, "Raster/", sep="") 
simp$dirs$output$figures	<- paste(simp$dirs$outputdir, "Figures/", sep="")
simp$dirs$output$reports	<- paste(simp$dirs$outputdir, "Reports/", sep="")

simp$dirs$output$reports	<- paste(simp$dirs$project, "/Output/", sep="")

simp$dirs$output$tables		<- paste(simp$dirs$outputdir, "/Tables/", sep="")
simp$dirs$output$csv		<- paste(simp$dirs$outputdir, "/CSV/", sep="")
simp$dirs$output$runinfo	<- "C:/Data/LURG/Projects/IMPRESSIONS/Modelling/CRAFTY-CoBRA_Illustration/CRAFTY_CoBRA-Illustration_Runs.ods"

futile.logger::flog.info("Current working directory: %s",
			getwd(),
			name = "netsens.simp")
