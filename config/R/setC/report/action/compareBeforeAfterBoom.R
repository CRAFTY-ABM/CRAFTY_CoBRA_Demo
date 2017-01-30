source(simp$simpDefinition)
simp$sim$folder 	<- "setC"
setwd(paste(simp$dirs$simp, simp$sim$folder, sep="/"))
source(paste(simp$dirs$simp, simp$sim$folder, "simp.R", sep="/"))

simp$sim$id <- "5-0"
input_tools_load(simp, "dataActions")

# plot distribution of score
d <- dataActions[grepl("AdoptOF",as.character(dataActions$Action)),]


# Compare Score
## Before (2003)
posd <- d[d$Score > 0 & d$Tick == 2003,]
craftyr::output_visualise_initFigure(simp, filename="ScoreDistribution2003")
ggplot2::ggplot(posd, ggplot2::aes(x=Score)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")
dev.off()

## After (2004)
posd <- d[d$Score > 0 & d$Tick == 2004,]
craftyr::output_visualise_initFigure(simp, filename="ScoreDistribution2004")
ggplot2::ggplot(posd, ggplot2::aes(x=Score)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")
dev.off()

# Compare PBC
## Before (2003)
posd <- d[d$Score > 0 & d$Tick == 2003,]
craftyr::output_visualise_initFigure(simp, filename="PBCDistribution2003")
ggplot2::ggplot(posd, ggplot2::aes(x=WPBC)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")
dev.off()

## After (2004)
posd <- d[d$Score > 0 & d$Tick == 2004,]
craftyr::output_visualise_initFigure(simp, filename="WSubjectiveNormDistribution2004")
ggplot2::ggplot(posd, ggplot2::aes(x=WSubjectiveNorm)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")
dev.off()

# Compare SubjectiveNorm
## Before (2003)
posd <- d[d$Score > 0 & d$Tick == 2003,]
craftyr::output_visualise_initFigure(simp, filename="WSubjectiveNormDistribution2003")
ggplot2::ggplot(posd, ggplot2::aes(x=WSubjectiveNorm)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")
dev.off()

## After (2004)
posd <- d[d$Score > 0 & d$Tick == 2004,]
craftyr::output_visualise_initFigure(simp, filename="WSubjectiveNormDistribution2004")
ggplot2::ggplot(posd, ggplot2::aes(x=WSubjectiveNorm)) + 
		ggplot2::geom_histogram(ggplot2::aes(y=..density..),      # Histogram with density instead of count on y-axis
				binwidth=.01,
				colour="black", fill="white") +
		ggplot2::geom_density(alpha=.2, fill="#FF6666") +
		ggplot2::facet_wrap(facets = "Action", scales = "free")
dev.off()