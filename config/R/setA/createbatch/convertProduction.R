source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440p2LURG.R")

simp$sim$folder 	<- "setA"
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")


for (aft in simp$mdata$aftNames[-1]) {
	
	# aft = simp$mdata$aftNames[7]
	# get productivity table 
	data <- input_csv_param_productivities(simp, aft, filenameprefix = "", filenamepostfix = "")
	
	aftParamIds <- hl_getAgentParamId(simp)
	aftparamdata <- input_csv_param_agents(simp, aft)
	filename <- aftparamdata[match(aftParamIds,aftparamdata$aftParamId), "productionCsvFile"]
	filename <- paste(simp$dirs$param$getparamdir(simp), hl_getBaseDirAdaptation(simp), 
			as.character(filename), sep="/")
	newfilename <- gsub(".csv", "_org.csv", filename)
	file.rename(filename, newfilename)
	
	data[data$X == "Cereal", "Production"] <- data[data$X == "Cereal", "Production"] * 155
	data[data$X == "OF_Cereal", "Production"] <- data[data$X == "OF_Cereal", "Production"] * 155

	data[data$X == "Meat", "Production"] <- data[data$X == "Meat", "Production"] * 24.5
	data[data$X == "OF_Meat", "Production"] <- data[data$X == "OF_Meat", "Production"] * 24.5
	
	#filename <- gsub(".csv", "_test.csv", filename)
	colnames(data)[colnames(data) == "X"] <- ""
	write.csv(data, file = filename, row.names = FALSE)
}