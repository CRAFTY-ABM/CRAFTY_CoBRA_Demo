print_calibration <- function(simp, dataname = "dataAggregateAFTComposition", facet_column = NULL) {
	
	# get observed landuse data:
	simp$sim$filepartorder 		<- c("scenario", "U", "datatype")
	outfiledata <- input_tools_getModelInputFilenames(simp, extension="csv", 
			datatype="demands")[[1]]
	outfiledata$Filename <- gsub("demands", "landuses", outfiledata$Filename)
	
	obs <- read.csv(outfiledata$Filename, check.names = FALSE)
	obs <- reshape2::melt(obs, id.vars = c("Description", "Country"), variable.name = "Tick")
	obs <- aggregate(obs$value, by= list(LandUse = obs$Description, Tick = obs$Tick, Region= obs$Country), FUN=sum)
	colnames(obs)[colnames(obs) == "x"] <- "value"
	obs$Type = "Obs"
	obs$Scenario <- simp$sim$scenario
	
	
	# get simulated land use data:
	cats <- c("COF_Cereal" =  "OF_Cereal", "NCOF_Cereal" = "OF_Cereal", "COF_Livestock" = "OF_Livestock", 
			"NCOF_Livestock" = "OF_Livestock")
	sim <- craftyr::input_processAftComposition(simp, dataname = dataname, aggregateRegions=FALSE)
	sim <- sim[sim$AFT %in% names(cats),]
	sim$LandUse <- cats[as.character(sim$AFT)]
	sim <- aggregate(sim$value, by= list(LandUse = sim$LandUse, Tick = sim$Tick, Region = sim$Region, 
					Scenario = sim$Scenario), FUN=sum)
	colnames(sim)[colnames(sim) == "x"] <- "value"
	sim$Type <- "Sim"
	
	data <- rbind(sim,obs)
	data$Tick <- as.numeric(as.character(data$Tick))
	plot <- craftyr::visualise_lines(simp, data = data, x_column = "Tick", y_column = "value", 
			colour_column = "LandUse", colour_legendtitle = "Land use",
			colour_legenditemnames = NULL, linetype_column = "Type",
			filename = "SimObsLandUse",
			facet_column = facet_column, facet_ncol = 1,
			alpha = simp$fig$alpha, showsd = FALSE, ggplotaddons = NULL,
			returnplot = FALSE)
}