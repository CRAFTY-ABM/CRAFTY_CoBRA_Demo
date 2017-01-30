##########################################################################################
# Create capital CSV files for regions, integrating OF farmers' FRs and 
# according BTs until the production target for OF services is met.
#
# Project:		CoBRA-Illustration
# Last update: 	29/12/2016
# Author: 		Sascha Holzhauer
# Instructions:	Run machine-specific SIMP file first (see craftyr documentation)
##########################################################################################

source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440p2LURG.R")
afts2ignore = c("Forester", "UNMANAGED")

# get original capitals from main folder:
simp$sim$folder 	<- "setA"
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")

simp$sim$filepartorder 		<- c("regions", "U", "datatype")
capitalfiledata <- input_tools_getModelInputFilenames(simp, extension="csv", 
		datatype="Capitals")[[1]]
capitalfiledata$Filename <- gsub("_Capitals", "_CapitalsOrg", capitalfiledata$Filename)

# switch to setC:
simp$sim$folder 	<- "setC"
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")

capitalfiledataNew <- input_tools_getModelInputFilenames(simp, extension="csv", 
		datatype="capitals")[[1]]

bcClusterNums = list("EE" = data.frame("Conv" = 5, "OF"=6),
		"LV" = data.frame("Conv" = 5, "OF"=6))

services <- c("Livestock" = "Meat", "Cereal" = "Cereal")

regions <- simp$sim$regions
for(region in regions) {
	# region <- simp$sim$regions[1]
	
	# Read service demand:
	demand <- input_csv_param_demand(simp)[[1]]
	
	# Read capital data:
	capdata <- read.csv(capitalfiledata[capitalfiledata$Region == region, "Filename"],stringsAsFactors =FALSE)
	
	# capdata <- capdata[1:1000,]
	capdata[capdata$Agent == "VLI_Livestock","Agent"] <- "NC_Livestock"
	options(stringsAsFactors = FALSE)
	colnames(capdata)[colnames(capdata)=="Agent"] <- "FR"
	
	for (frservice in c("Cereal", "Livestock")) {
		# service  = "Cereal"
		supplySum = 0;
		while (supplySum <= demand[demand$Year == 2000, paste("OF", services[frservice], sep="_")]) {
			# draw according FR and assign new one
			index <- sample(which(grepl(frservice, capdata[,"FR"]) & (!grepl("OF", capdata[,"FR"]))), 1)
			
			frorg <- strsplit(capdata[index, "FR"],"_")[[1]]
			newfr <- paste(frorg[1], "OF", "_", frorg[2], sep="")
			capdata[index, "FR"] <- newfr
			
			# calculate production
			production <- input_csv_param_productivities(simp, aft = newfr)
			production$Production <- strsplit(production$Production, ")")
			production$Production <- as.numeric(sapply(production$Production, 
							function(x) if (length(x) > 1) x[2] else x[1]))
			
			caps <- capdata[index, -c(1,2,3, 10)]
			supplySum <- supplySum + prod(caps^production[production$Service == paste("OF", services[frservice], sep="_"), 
					-c(1, length(production[1,]))]) * production[production$Service == paste("OF", services[frservice], sep="_"), 
			"Production"]
		}
		
		capdata[capdata$FR == paste("NC_", frservice, sep=""), "FR"] <- paste("NCConv_", frservice, sep="")
		capdata[capdata$FR == paste("C_", frservice, sep=""), "FR"] <- paste("CConv_", frservice, sep="")
	}
		
	# Assign BT:
	capdata[,"BT"] <- 0
	capdata[grepl("Conv", capdata$FR),"BT"] <- sample(as.integer(bcClusterNums[[region]]["Conv"]), 
			size = sum(grepl("Conv",capdata$FR)), replace = TRUE)
	
	capdata[grepl("OF",capdata$FR),"BT"] <- sample(as.integer(bcClusterNums[[region]]["OF"]), 
			size = sum(grepl("OF",capdata$FR)), replace = TRUE) + 5
	
	shbasic::sh.ensurePath(capitalfiledataNew[capitalfiledataNew$Region == region, "Filename"], stripFilename = TRUE)
	write.csv(capdata[,-1], file = capitalfiledataNew[capitalfiledataNew$Region == region, "Filename"], row.names = FALSE)
}

# check:
data = read.csv(capitalfiledataNew[capitalfiledataNew$Region == region, "Filename"])