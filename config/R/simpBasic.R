################################################################################
# General SIMulation Properties:
#
# Project:		TEMPLATE
# Last update: 	02/09/2015
# Author: 		Sascha Holzhauer
################################################################################

#### COMMON PACKAGES ###########################################################
library(craftyr)
library(kfigr)
library(shbasic)

#### FUNCTIONS #################################################################
#eg. for simp$dirs$param$getparamdir

### Simulation Data ############################################################
if (!exists("simp")) simp <-  craftyr::param_getDefaultSimp()

simp$sim$worldname 			<- "NEEU"
simp$sim$version			<- NULL
simp$sim$allocversion		<- "NN"
simp$sim$scenario			<- "B1"
simp$sim$regionalisation	<- "2"
simp$sim$regions			<- c("EE", "LV")
simp$sim$runids				<- c("0-0")
simp$sim$filepartorder_demands <- c("scenario", "U", "datatype", "U", "regions")
simp$sim$hasregiondir		<- TRUE
simp$csv$tickinterval_cell	<- 4

### Directories ################################################################
simp$dirs$output$data		<- paste(simp$dirs$outputdir, "Data/", sep="")
simp$dirs$output$rdata		<- paste(simp$dirs$outputdir, "RData/", sep="") 
simp$dirs$output$raster		<- paste(simp$dirs$outputdir, "Raster/", sep="") 
simp$dirs$output$figures	<- paste(simp$dirs$outputdir, "Figures/", sep="")
simp$dirs$output$reports	<- paste(simp$dirs$outputdir, "Reports/", sep="")

### CSV Column Names ###########################################################
simp$csv$cname_region 		<- "Region"
simp$csv$cname_tick 		<- "Tick"
simp$csv$cname_aft 			<- "Agent"
simp$csv$cname_x			<- "X"
simp$csv$cname_y			<- "Y"

### Model Data ################################################################
simp$mdata$capitals 		<- c("Cprod", "Fprod", "Infra", "Grass", "Nat", "Econ")
simp$mdata$services			<- c("Meat", "Cereal" ,"Conservation", "Timber", "OF_Meat", "OF_Cereal")

simp$mdata$aftNames			<- c("-1" = "Unmanaged", "0" = 'CConv_Cereal', "1" = 'NCConv_Cereal', 
								"2" = 'CConv_Livestock', "3" = 'NCConv_Livestock',
								"4" = 'Forester', "5" = 'COF_Cereal', "6" = 'NCOF_Cereal', 
								"7" = 'COF_Livestock', "8" = 'NCOF_Livestock')

#simp$mdata$aftNames			<- c("-1" = "Unmanaged", "0" = 'COF_Cereal', "1" = 'NCOF_Cereal', 
#								  "2" = 'COF_Livestock', "3" = 'NCOF_Livestock',
#								  "4" = 'CConv_Cereal', "5" = 'NCConv_Cereal', "6" = 'CConv_Livestock', 
#								  "7" = 'NCConv_Livestock', "8" = 'Forester')

simp$dirs$param$getparamdir <- function(simp, datatype = NULL) {
	return <- paste(simp$dirs$data,
			if (is.null(datatype)) { 
						simp$sim$folder
					} else if (datatype %in% c("capitaldyns")) {
						paste("worlds", simp$sim$worldname,
								if(!is.null(simp$sim$regionalisation)) paste("regionalisations", 
											simp$sim$regionalisation, sep="/"), simp$sim$scenario, sep="/")
					} else if (datatype %in% c("capitals")) {
						paste("worlds", simp$sim$worldname,
								if(!is.null(simp$sim$regionalisation)) paste("regionalisations", 
											simp$sim$regionalisation, sep="/"), "capitals", sep="/")
					} else if (datatype %in% c("demands")) {
						paste(simp$sim$folder, "worlds", simp$sim$worldname,
								if(!is.null(simp$sim$regionalisation)) paste("regionalisations", 
											simp$sim$regionalisation, simp$sim$scenario, sep="/"), sep="/")
					} else if (datatype %in% c("agentparams")) {
						paste(simp$sim$folder, "agents", sep="/")
					} else if (datatype %in% c("productivities")) {
						paste(simp$sim$folder, "production", sep="/")
					} else if (datatype %in% c("competition")) {
						paste(simp$sim$folder, "competition", sep="/")
					} else if (datatype %in% c("runs")) {
						simp$sim$folder
					},
			sep="/")
}
						  
### Figure Settings ###########################################################
simp$fig$resfactor			<- 2
simp$fig$outputformat 		<- "png" #"jpeg"
simp$fig$init				<- craftyr::output_visualise_initFigure
simp$fig$numfigs			<- 1
simp$fig$numcols			<- 1
simp$fig$height				<- 500
simp$fig$width				<- 500
simp$fig$splitfigs			<- FALSE
simp$fig$facetlabelsize 	<- 14

simp$colours$AFT <- c(
		"-1" = "black", 
		"0" = 'orange1',
		"1" = 'lightgoldenrod',
		"2" = 'indianred4', 
		"3" = 'indianred1',
		"4" = 'green4',
		"5" = 'deepskyblue4',
		"6" = 'deepskyblue', 
		"7" = 'darkorchid4',
		"8" = 'darkorchid1')

#simp$colours$AFT <- c(
#		"-1" = "black", 
#		"0" = 'deepskyblue4',
#		"1" = 'deepskyblue', 
#		"2" = 'darkorchid4',
#		"3" = 'darkorchid1',
#		"4" = 'orange1',
#		"5" = 'lightgoldenrod',
#		"6" = 'indianred4', 
#		"7" = 'indianred1',
#		"8" = 'green4')

simp$colours$Service <- c(	"-1" = "black",
		"Meat" 			= "indianred1",
		"Cereal" 	 	= "orange1",
		"Conservation" 	= "royalblue2",
		"Recreation" 	= "royalblue2",
		"Timber" 		= "green4",
		"OF_Meat" 		= "darkorchid1",
		"OF_Cereal" 	= "deepskyblue")


simp$fills$AFT 	<- simp$colours$AFT
simp$fills$Service <- simp$colours$Service