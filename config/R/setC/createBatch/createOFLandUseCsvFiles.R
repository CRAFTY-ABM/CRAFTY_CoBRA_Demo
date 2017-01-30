##########################################################################################
# Create Organic Farming land use CSV files for regions
#
# Project:		CoBRA_Demo
# Last update: 	11/11/2016
# Author: 		Sascha Holzhauer
# Instructions:	Just run entire script
# Consider R package eurostat next time.. (https://cran.r-project.org/web/packages/eurostat/)
##########################################################################################

## import configuration
source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440p2LURG.R")

simp$sim$folder 	<- "setC"
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")

## define params
filenamenewdemands <- "C:/Data/LURG/Projects/IMPRESSIONS/Modelling/CRAFTY-CoBRA_Illustration/data/CoBRAillu_OrganicCropArea.ods"
landuses	<- c("Organic crop area (cereals for the production of grain: C0000/TOTAL)" = "OF_Cereal", "Permanent grassland (TOTAL/J0000)" = "OF_Livestock")
#landuses	<- c("Arable land (TOTAL/ARA)" = "OF_Cereal", "Permanent grassland (TOTAL/J0000)" = "OF_Livestock")

## read observed land uses from ODS
require(readODS)
landusesobs <- read.ods(filenamenewdemands, sheet = 1)

colnames(landusesobs) <- landusesobs[1,]
landusesobs <- landusesobs[c(8,9,12,13),]
landusesobs[,4:ncol(landusesobs)] = apply(landusesobs[,4:ncol(landusesobs)], 2, function(x) as.numeric(x));
landusesobs$Description <- landuses[landusesobs$Description]

landusesobs <- plyr::ddply(landusesobs, Description~Country, function(df) {
			#df <- landusesobs[1,]
			
			#df[1, 4:ncol(df)] = imputeTS::na.interpolation(as.numeric(df[1, 4:ncol(df)]), option="spline") / 100
			
			our_data <- data.frame(y = as.numeric(df[1, 4:ncol(df)]), x = as.numeric(colnames(df)[4:ncol(df)]))
			our_model <- lm(log(y) ~ x, data = our_data)
			df[1, 4:ncol(df)] <- exp(predict(our_model, newdata = data.frame(x=as.numeric(colnames(df)[4:ncol(df)]))))
			
			df
		}
)

## store CSV file
simp$sim$filepartorder 		<- c("scenario", "U", "datatype")
outfiledata <- input_tools_getModelInputFilenames(simp, extension="csv", 
		datatype="demands")[[1]]
outfiledata$Filename <- gsub("demands", "landuses", outfiledata$Filename)

write.csv(landusesobs[, -3], file=outfiledata[1, "Filename"], row.names = FALSE)	
