source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440p2LURG.R")

simp$sim$folder 	<- "setB"
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")

adaptCereal = 155 * 1.2
adaptLivestock = 24.5 * 1.2

for (aft in simp$mdata$aftNames[-1]) {
	
	# aft = simp$mdata$aftNames[3]
	# get productivity table 
	data <- input_csv_param_productivities(simp, aft, filenameprefix = "../../production/", filenamepostfix = "_org", 
			aftwisefolder = FALSE)
	
	aftParamIds <- hl_getAgentParamId(simp)
	aftparamdata <- input_csv_param_agents(simp, aft)
	filename <- aftparamdata[match(aftParamIds,aftparamdata$aftParamId), "productionCsvFile"]
	filename <- paste(simp$dirs$param$getparamdir(simp), hl_getBaseDirAdaptation(simp), 
			as.character(filename), sep="/")
	newfilename <- gsub(".csv", "_org.csv", filename)
	#file.rename(filename, newfilename)

	if (grepl("OF", aft)) {
		data[data$Service == "Cereal", "Production"] <- 
				paste("(CTICK-START_TICK<=1)",  as.numeric(data[data$Service == "OF_Cereal", "Production"]) * adaptCereal, sep="")
		data[data$Service == "OF_Cereal", "Production"] <-
				paste("(CTICK-START_TICK>1)", as.numeric(data[data$Service == "OF_Cereal", "Production"]) * adaptCereal, sep="")
		
		data[data$Service == "Meat", "Production"] <- 
				paste("(CTICK-START_TICK<=1)", as.numeric(data[data$Service == "OF_Meat", "Production"]) * adaptLivestock, sep="")
		data[data$Service == "OF_Meat", "Production"] <- 
				paste("(CTICK-START_TICK>1)", as.numeric(data[data$Service == "OF_Meat", "Production"]) * adaptLivestock, sep="")
	} else {
		data[data$Service == "Cereal", "Production"] <- as.numeric(data[data$Service == "Cereal", "Production"]) * adaptCereal
		data[data$Service == "OF_Cereal", "Production"] <- as.numeric(data[data$Service == "OF_Cereal", "Production"]) * adaptCereal
	
		data[data$Service == "Meat", "Production"] <- as.numeric(data[data$Service == "Meat", "Production"]) * adaptLivestock
		data[data$Service == "OF_Meat", "Production"] <- as.numeric(data[data$Service == "OF_Meat", "Production"]) * adaptLivestock
	}
	
	#filename <- gsub(".csv", "_test.csv", filename)
	shbasic::sh.ensurePath(filename, stripFilename = TRUE)
	write.csv(data, file = filename, row.names = FALSE)
}