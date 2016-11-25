source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440p2LURG.R")

simp$sim$folder 	<- ""
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")


data <- hl_getAllocationRestrictionMatrix()

# define conversion prohibitions:
data[, grep("OF", colnames(data))] <- 1

filename <- paste(input_tools_getModelInputDir(simp, datatype = NULL), "csv", "AllocationTypeRestrictions.csv", sep="/")

futile.logger::flog.info("Write ALlocation Type Restrictions to %s",
			filename,
			name = "CRAFTY_CoBRA_Demo.createAllocationTypeRestrictions.R")
	
write.csv(file=filename, data)