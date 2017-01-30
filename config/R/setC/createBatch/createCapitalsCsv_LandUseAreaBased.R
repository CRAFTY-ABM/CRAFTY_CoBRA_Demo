##########################################################################################
# Create capital CSV files for regions, integrating proportions of Conv/OF farmers FRs and 
# according BTs
#
# Project:		CoBRA-Illustration
# Last update: 	13/09/2016
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
		datatype="capitals")[[1]]
capitalfiledata$Filename <- gsub("_capitals", "_CapitalsOrg", capitalfiledata$Filename)

# switch to setC:
simp$sim$folder 	<- "setC"
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")

capitalfiledataNew <- input_tools_getModelInputFilenames(simp, extension="csv", 
		datatype="capitals")[[1]]

bcClusterNums = list("EE" = data.frame("Conv" = 5, "OF"=6),
		"LV" = data.frame("Conv" = 5, "OF"=6))

regions <- simp$sim$regions
for(region in regions) {
	# region <- simp$sim$regions[1]

	simp$sim$regions <- region
	simp$sim$filepartorder 		<- c("scenario", "U", "datatype")
	outfiledata <- input_tools_getModelInputFilenames(simp, extension="csv", 
			datatype="demands")[[1]]
	outfiledata$Filename <- gsub("demands", "landuses", outfiledata$Filename)
	luarea <- read.csv(file=outfiledata[1, "Filename"], check.names = F)
	
	# get total area (#cells):
	simp$sim$filepartorder 		<- c("regions", "U", "datatype")
	outfiledata <- input_tools_getModelInputFilenames(simp, extension="csv", 
			datatype="capitals")[[1]]
	outfiledata$Filename <- gsub("Capitals", "CapitalsOrg", outfiledata$Filename)
	capitals <- read.csv(file=outfiledata[1, "Filename"], check.names = F)
	num <- list()
	num$Cereal <- nrow(capitals[grepl("Cereal", as.character(capitals$FR)),])
	num$Livestock <- nrow(capitals[grepl("Livestock", as.character(capitals$FR)),])
	
	capdata <- read.csv(capitalfiledata[capitalfiledata$Region == region, "Filename"],stringsAsFactors =FALSE)
	
	# capdata <- capdata[1:1000,]
	capdata[capdata$Agent == "VLI_Livestock","Agent"] <- "NC_Livestock"
	
	options(stringsAsFactors = FALSE)
	
	colnames(capdata)[colnames(capdata)=="Agent"] <- "FR"
	
	for (service in c("Cereal", "Livestock")) {
		# service  = "Cereal"
		of <- prob::probspace(c("Conv", "OF"), c(
						num[[service]]-luarea[grepl(service, luarea$Description) & luarea$Country == region, "2000"],
				luarea[grepl(service, luarea$Description) & luarea$Country == region, "2000"]))
		modes <- prob::sim(of, ntrials=sum(grepl(service, capdata$FR)))
		frorg <- do.call(rbind, strsplit(capdata[grepl(service, capdata$FR), "FR"],"_"))
		
		capdata[grepl(service, capdata$FR), "FR"] <- paste(frorg[,1], modes$x, "_", frorg[,2], sep="")
	}
	
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