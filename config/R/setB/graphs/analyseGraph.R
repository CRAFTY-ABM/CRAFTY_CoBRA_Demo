source("C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/simp-machine_T440p2LURG.R")

simp$sim$folder 	<- "setB"
setwd(paste(simp$dirs$simp, simp$sim$folder, "createbatch", sep="/"))
source("../simp.R")

simp$sim$runids <- "4-0"
graphfilename = paste(input_tools_getModelOutputDir(simp), "/Social-Network-EE.graphml", sep="")

g <- igraph::read.graph(file = file(description=graphfilename), format = "graphml")
comp <- shsonar::get_nodetype_composition(sip=null, graph = g, attributename = "FR")

comp <- as.data.frame(comp)
colnames(comp) <- simp$mdata$aftNames[-1]
comp$PartnerFR <- simp$mdata$aftNames[-1]
plotData <- reshape2::melt(comp, id.var = c("PartnerFR"),
		variable.name = "FR")

a <- ggplot2::ggplot(plotData, ggplot2::aes(x = FR, y = value,
						fill = PartnerFR)) + 
		ggplot2::scale_fill_manual(values=setNames(simp$colours$AFT[-1], simp$mdata$aftNames[-1]),
				labels = simp$mdata$aftNames[-1])  + 
		ggplot2::geom_bar(stat = "identity", position = "dodge") +
		ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))

simp$fig$init(simp, outdir = paste(simp$dirs$output$figures, "graph", sep="/"), 
		filename = "NFrComposition_3-0_FrWeight0-2_forceMilieu")
plot(a)
dev.off()

## Distance Distribution
sip <- list()
sip$perform$dist$numsplits <- 3

dist <- shsonar::get_igraph_distances(sip=sip, g, xcoordname = "X", ycoordname = "Y", attributename = "FR",
		attribute = "8")
simp$fig$init(simp, outdir = paste(simp$dirs$output$figures, "graph", sep="/"), 
		filename = "DistanceDist_8")
plot(table(cut(dist, seq(0,max(dist), length.out=100))))
dev.off()


dist4 <- shsonar::get_igraph_distances(sip=sip, g, xcoordname = "X", ycoordname = "Y", attributename = "FR",
		attribute = "4")
simp$fig$init(simp, outdir = paste(simp$dirs$output$figures, "graph", sep="/"), 
		filename = "DistanceDist_4")
plot(table(cut(dist4, seq(0,max(dist4), length.out=100))))
dev.off()
