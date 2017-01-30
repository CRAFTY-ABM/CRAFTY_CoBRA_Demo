################################################################################
# Version specific SIMulation Properties:
#
# Project:		TEMPLATE
# Last update: 	02/09/2015
# Author: 		Sascha Holzhauer
################################################################################

# General SIMulation Properties ################################################

if (!exists("simp")) simp <- craftyr::param_getDefaultSimp()

simp$sim$version				<- "setA"
simp$sim$parentf				<- NULL
simp$sim$folder					<- "setA"
simp$sim$scenario				<- "B1"
simp$sim$regionalisation		<- "2"
simp$sim$regions				<- c("EE")
simp$sim$runids					<- c("0-0")
simp$sim$id 					<- "B1-0"
simp$csv$tickinterval_cell		<- 4

### Directories ################################################################
simp = shbasic::shbasic_adjust_outputfolders(simp, pattern = "%VFOLDER%", value = 
				if (is.null(simp$sim$folder)) "" else (simp$sim$folder))


### Figure Settings ############################################################
simp$fig$resfactor		<- 3
simp$fig$outputformat 	<- "png"
simp$fig$init			<- craftyr::output_visualise_initFigure
simp$fig$numfigs		<- 1
simp$fig$numcols		<- 1
simp$fig$height			<- 1000
simp$fig$width			<- 1500
simp$fig$splitfigs		<- FALSE
simp$fig$facetlabelsize <- 14

### Batch Run Creation Settings #################################################
simp$batchcreation$scenarios				<- c("B1")
simp$batchcreation$startrun 				<- 0
simp$batchcreation$regionalisations			<- c("2")
simp$batchcreation$percentage_takeovers 	<- c(30) 
simp$batchcreation$competition 				<- "Competition_linear.xml"
simp$batchcreation$institutions				<- "institutions/Institutions_CapitalDynamics.xml"
simp$batchcreation$allocation				<- "GiveUpGiveInAllocationModel.xml"
											
simp$batchcreation$socialnetwork 			<- "SocialNetwork_HDFF.xml"
simp$batchcreation$searchabilities			<- c(30)
simp$batchcreation$inputdatadir 			<- sprintf("%s/data", simp$dirs$project)
simp$batchcreation$agentparam_tmpldir		<- paste(simp$batchcreation$inputdatadir, "/agents/templates/", sep="")
simp$batchcreation$gu_stages				<- c("medium")
simp$batchcreation$gi_stages				<- c("medium")
simp$batchcreation$placeholders				<- c(0)
simp$batchcreation$allocationProbabilities	<- c(1.0, 0.3)

simp$batchcreation$inputdatadirs$aftparams	<- paste(simp$batchcreation$inputdatadir, "/agents", sep="")
simp$batchcreation$inputdatadirs$production	<- paste("/production/", sep="")
simp$batchcreation$inputdatadirs$competition	<- paste(simp$batchcreation$inputdatadir, "/competition", sep="")
simp$batchcreation$inputdatadirs$allocation	<- paste(simp$batchcreation$inputdatadir, "/allocation", sep="")
simp$batchcreation$inputdatadirs$worldfile	<- paste(simp$batchcreation$inputdatadir, "/world", sep="")
simp$batchcreation$inputdatadirs$agentdef 	<- paste(simp$batchcreation$inputdatadir, "/agents", sep="")


simp$dirs$param$getparamdir <- function(simp, datatype = NULL) {
	return <- paste(simp$dirs$data,
			if (is.null(datatype)) { 
						""
					} else if (datatype %in% c("Capitals")) {
						paste("worlds", simp$sim$worldname,
								if(!is.null(simp$sim$regionalisation)) paste("regionalisations", 
											simp$sim$regionalisation, sep="/"), "capitals", sep="/")
					} else if (datatype %in% c("capitaldyns")) {
						paste("worlds", simp$sim$worldname,
								if(!is.null(simp$sim$regionalisation)) paste("regionalisations", 
											simp$sim$regionalisation, sep="/"), simp$sim$scenario, sep="/")
					} else if (datatype %in% c("demands")) {
						paste("worlds", simp$sim$worldname,
								if(!is.null(simp$sim$regionalisation)) paste("regionalisations", 
											simp$sim$regionalisation, simp$sim$scenario, sep="/"), sep="/")
					} else if (datatype %in% c("agentparams")) {
						paste("agents", sep="/")
					} else if (datatype %in% c("productivities")) {
						paste("production", sep="/")
					} else if (datatype %in% c("competition")) {
						paste("competition", sep="/")
					} else if (datatype %in% c("runs")) {
						simp$sim$folder
					},
			sep="/")
}