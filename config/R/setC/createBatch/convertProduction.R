##########################################################################################
# Create production CSV files for FRs. 
# OF production has been set to 80% (crops) and 90% (grassland) less than conventional.
#
# In theory, requires several rounds together with createCapitalsCsv_ProductionBased.R to
# converge (production influences number of required OF farmers, which in turn influences
# production to match demand).
#
# Project:		CoBRA-Illustration
# Last update: 	29/12/2016
# Author: 		Sascha Holzhauer
# Instructions:	Run machine-specific SIMP file first (see craftyr documentation)
##########################################################################################

#source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440pLURG2LURG.R")
source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440p2T440p.R")

simp$sim$folder 	<- "setC"
simp$sim$version	<- "setC"

setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")
simp$sim$id 		<- "4-0"
simp$sim$runids 		<- "4-0"

adaptCereal = 155
adaptLivestock = 24.5

# compare demand with supply in 2000 and adjust optimal production values accordingly!
dataAggregateSupplyDemand <- input_csv_data(simp, dataname = NULL, datatype = "AggregateServiceDemand",
		pertick = FALSE, bindrows = TRUE)
input_tools_save(simp, "dataAggregateSupplyDemand")


input_tools_load(simp, objectName = "dataAggregateSupplyDemand")
dataInitial <- convert_aggregate_meltsupplydemand(simp, dataAggregateSupplyDemand)
dataInitial <- dataInitial[dataInitial$Tick == 2000,]
factors <- setNames(dataInitial[dataInitial$Type == "Demand", "Value"] / 
				dataInitial[dataInitial$Type == "ServiceSupply", "Value"],
		dataInitial[dataInitial$Type == "ServiceSupply", "Service"])

#factors[grepl("OF", names(factors))] <- 1
factors["OF_Meat"] <- factors["Meat"]
factors["OF_Cereal"] <- factors["Cereal"]
		
simp$sim$folder 	<- "setC"
simp$sim$version	<- "setC"
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")
simp$sim$id 		<- "5-0"

# assumes original production CSV files to be postfixed '_org':
for (aft in simp$mdata$aftNames[-1]) {
	
	# aft = simp$mdata$aftNames[7]
	# get productivity table 
	data <- input_csv_param_productivities(simp, aft, filenamepostfix = "_org", aftwisefolder = FALSE)
	
	aftParamIds <- hl_getAgentParamId(simp)
	aftparamdata <- input_csv_param_agents(simp, aft)
	filename <- aftparamdata[match(aftParamIds,aftparamdata$aftParamId), "productionCsvFile"]
	filename <- paste(simp$dirs$param$getparamdir(simp), hl_getBaseDirAdaptation(simp), 
			as.character(filename), sep="/")
	
	if (grepl("OF", aft)) {
		data[data$Service == "Cereal", "Production"] <- 
				paste("(CTICK-START_TICK<=1) ",  as.numeric(data[data$Service == "OF_Cereal", "Production"]) * 
								adaptCereal, sep="")
		data[data$Service == "OF_Cereal", "Production"] <-
				paste("(CTICK-START_TICK>1) ", as.numeric(data[data$Service == "OF_Cereal", "Production"]) * 
								adaptCereal, sep="")
		
		data[data$Service == "Cereal", !colnames(data) %in% c("Service", "Production")] <- 
				data[data$Service == "OF_Cereal", !colnames(data) %in% c("Service", "Production")]
				
		data[data$Service == "Meat", "Production"] <- 
				paste("(CTICK-START_TICK<=1) ", as.numeric(data[data$Service == "OF_Meat", "Production"]) * 
								adaptLivestock, sep="")
		data[data$Service == "OF_Meat", "Production"] <- 
				paste("(CTICK-START_TICK>1) ", as.numeric(data[data$Service == "OF_Meat", "Production"]) * 
								adaptLivestock, sep="")
		
		data[data$Service == "Meat", !colnames(data) %in% c("Service", "Production")] <- 
				data[data$Service == "OF_Meat", !colnames(data) %in% c("Service", "Production")]
		
	} else {
		data[data$Service == "Cereal", "Production"] <- as.numeric(data[data$Service == "Cereal", "Production"]) * adaptCereal
		data[data$Service == "OF_Cereal", "Production"] <- as.numeric(data[data$Service == "OF_Cereal", "Production"]) * adaptCereal
		
		data[data$Service == "Meat", "Production"] <- as.numeric(data[data$Service == "Meat", "Production"]) * adaptLivestock
		data[data$Service == "OF_Meat", "Production"] <- as.numeric(data[data$Service == "OF_Meat", "Production"]) * adaptLivestock
	}
	
	splitted <-  strsplit(as.character(data$Production), " ")
	
	prefix <- sapply(splitted, function(l) if(length(l) > 1) l[1] else "")
	data$Production <- as.numeric(sapply(splitted, function(l) l[length(l)]))

	data$Production <- data$Production * factors[match(data$Service, names(factors))]
	data$Production <- paste(prefix, data$Production, sep="")
	
	#filename <- gsub(".csv", "_test.csv", filename)
	shbasic::sh.ensurePath(filename, stripFilename = TRUE)
	
	futile.logger::flog.info("Write file %s", filename,
				name = "CRAFTY_CoBRA_Demo.convertProduction.R")
	write.csv(data, file = filename, row.names = FALSE)
}