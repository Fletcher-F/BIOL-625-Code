### BIOL 625 A3 R Code ###
#Fletcher Falk (230169031)
#March 3rd, 2026

#Set working directory
rm(list=ls())
setwd("C:/Users/fletc/Desktop/BIOL625-Genomics/A3-Data")

#Load required libraries
#none needed

#Read in population info for plots
pop<-read.csv("popinfo.csv")

#Admixture plot
#Adapted from example in NgsAdmixTutorial

#subset id and pop info for each individual
?subset
?setNames
popinfo <- setNames(pop$name, pop$population)

#Read inferred admixture proportions file
q <- read.table("k4-admix.qopt")
ord = order(popinfo)

#plot base R barplot
#following NgsAdmix page
barplot(t(q)[,ord], col = 2:10, space = 0, border = NA, xlab = "Individuals", ylab = "K=4")
text(tapply(1:nrow(pop), pop[ord,1], mean), -0.05, unique(pop[ord,1]), xpd = T)
abline(v = cumsum(sapply(unique(pop[ord,1]), function(x){sum(pop[ord,1]==x)})), col = 1, lwd = 1.2)

#PCA plot adapted from PCAngsd Github
#read in .cov data
C <- as.matrix(read.table("PCangsd.cov"))
e <- eigen(C)

#population colors for legend
pop_colors <- c("Pop1" = "red", "Pop2" = "blue", "Pop3" = "green")

#Final plot with pop data just with base R off PCAngsd page
?plot
?text
plot(e$vectors[,1:2], col = pop$color, pch = 17, xlab = "PC1", ylab = "PC2")
legend("topleft", legend = c("Microcarpa", "Albens", "Moluccana"), col = pop_colors, pch = 17)
text(jitter(e$vectors[,1:2]), labels = pop$name, cex = 0.5, pos = 2)
#hard to see labels with overlap but gives idea of samples for future reference

#edit final plots in inkscape to fix label overlap
