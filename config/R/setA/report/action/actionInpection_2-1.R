source(simp$simpDefinition)
simp$sim$folder 	<- "setA"
setwd(paste(simp$dirs$simp, simp$sim$folder, sep="/"))
source(paste(simp$dirs$simp, simp$sim$folder, "simp.R", sep="/"))

simp$sim$id <- "2-1"
input_tools_load(simp, "dataActions")

# plot distribution of score
d <- dataActions[grepl("AdoptOF",as.character(dataActions$Action)),]

ggplot2::ggplot(d, ggplot2::aes(x=Score)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")

table(d[d$Action == "Conv_AdoptOF_A_Cluster1_EE", "Score"])
table(d[, "Score"])

## W_SubjectiveNorm:
ggplot2::ggplot(d, ggplot2::aes(x=WSubjectiveNorm)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")

table(d[d$Action == "Conv_AdoptOF_A_Cluster1_EE", "WSubjectiveNorm"])
table(d[, "WSubjectiveNorm"])

colnames(d)

# plot distribution of PBC:
table(d[d$Action == "Conv_AdoptOF_A_Cluster1_EE", "WPBC"])
table(d[, "WPBC"])
