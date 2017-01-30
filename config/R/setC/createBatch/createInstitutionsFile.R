source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440p2LURG.R")

simp$sim$folder 	<- "setB"
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")

minx <- 2654
maxx <- 3021
		
miny <- 2542
maxy <- 2773

fr <- 9
bt <- 0
numInsts <- 20
classname = "org.volante.abm.comi.institution.ComiOfAdvisingInstitution"
pbcFactor <- 1.3
		
files = paste(simp$dirs$param$getparamdir(simp, datatype="capitals"), "/../institutions/", simp$sim$regions, "_Institutions.csv", sep="")

for (file in files) {
	data <- data.frame(
			x = sample(minx:maxx, size=numInsts),
			y = sample(miny:maxy, size=numInsts),
			FR = fr,
			BT = bt,
			ID = paste("Advisor", sprintf("%02d", 1:numInsts), sep="_"),
			Classname = classname,
			PBC_FACTOR = pbcFactor)
	
	shbasic::sh.ensurePath(file, stripFilename = TRUE)
	write.csv(data, file = file, row.names = F)
}