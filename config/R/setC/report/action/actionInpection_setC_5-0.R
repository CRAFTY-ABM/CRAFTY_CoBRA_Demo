source(simp$simpDefinition)
simp$sim$folder 	<- "setC"
setwd(paste(simp$dirs$simp, simp$sim$folder, sep="/"))
source(paste(simp$dirs$simp, simp$sim$folder, "simp.R", sep="/"))

simp$sim$id <- "5-0"
input_tools_load(simp, "dataActions")

# plot distribution of score
d <- dataActions[grepl("AdoptOF",as.character(dataActions$Action)),]

pd <- d[d$Action == "Conv_AdoptOF_NA_Cluster2_EE" & d$Score > 0,]
ggplot2::ggplot(pd, ggplot2::aes(x=Score)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")

# plot distribution of positive score for 2004:
posd <- d[d$Score > 0 & d$Tick == 2004,]
ggplot2::ggplot(posd, ggplot2::aes(x=Score)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")

# plot all FRs in a single plot:
ggplot2::ggplot(posd, ggplot2::aes(x=Score)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666")

# check num of affected agents per threshold:
freqdata <- cut(posd$Score, seq(0,1,0.01))
table(freqdata)
plot(cumsum(rev(table(freqdata)))[1:45])
plot(cumsum(rev(table(freqdata))))

maxy = 0
for (tick in simp$sim$starttick:simp$sim$endtick) {
	posd <- d[d$Score > 0 & d$Tick == tick,]
	freqdata <- cut(posd$Score, seq(0,1,0.01))
	maxy = max(maxy, cumsum(rev(table(freqdata))))
}

for (tick in simp$sim$starttick:simp$sim$endtick) {
	craftyr::output_visualise_initFigure(simp,filename=paste("ScoreDistribution", tick, sep="_"))
	posd <- d[d$Score > 0 & d$Tick == tick,]
	freqdata <- cut(posd$Score, seq(0,1,0.01))
	plot(cumsum(rev(table(freqdata))), ylim = c(0,maxy))
	dev.off()
}

## table for DoNothing scores:
table(dataActions[grepl("DoNothing", as.character(dataActions$Action)), "Score"])


## plot selected:
d <- dataActions[grepl("AdoptOF", as.character(dataActions$Action)) & dataActions$Tick == 2003 & dataActions$Selected == 1, ]
ggplot2::ggplot(d, ggplot2::aes(x=Score)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")
#########

table(d[d$Action == "Conv_AdoptOF_A_Cluster1_EE", "Score"])
table(d[d$Action == "Conv_AdoptOF_NA_Cluster2_EE", "Score"])


table(d[, "Score"])


# inspect not selected:
d <- dataActions[grepl("AdoptOF", as.character(dataActions$Action)) & dataActions$Tick == 2003 & dataActions$Selected == 0, ]

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

ggplot2::ggplot(d, ggplot2::aes(x=WPBC)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")

