### BIOL 625 A5 R Code ###
#Genomic Differentiation
#Fletcher Falk (230169031)
#March 27, 2026

#Set working directory
rm(list=ls())
setwd("C:/Users/fletc/Desktop/UNBC-MSc/Courses/BIOL625-Genomics/Differentiation")

#SFS plot
#Script modified from Jasmine Janes
#Read data from each population for 1dsfs
sfs <- scan("pop1.sfs")
sfs2 <- scan("pop2.sfs")
sfs3 <- scan("pop3.sfs")

#Exclude fixed/invariant sites (first and last entries)
#This keeps only the variable sites
sfs_var <- sfs[-c(1, length(sfs))]
sfs_var2 <- sfs2[-c(1, length(sfs2))]
sfs_var3 <- sfs3[-c(1, length(sfs3))]

#Normalize values for proportions
sfs_norm <- sfs_var / sum(sfs_var)
sfs_norm2 <- sfs_var2 / sum(sfs_var2)
sfs_norm3 <- sfs_var3 / sum(sfs_var3)

#Plotting barplot for each population sfs.
#Note some match to more contigs
barplot(sfs_norm,
        xlab="Chromosome",
        names=1:11,
        ylim = c(0, 0.5),
        ylab="Proportions",
        col="blue")

barplot(sfs_norm2,
        xlab="Chromosome",
        names=1:11,
        ylim = c(0, 0.5),
        ylab="Proportions",
        col="blue")

barplot(sfs_norm3,
        xlab="Chromosome",
        names=1:11,
        ylim = c(0, 0.5),
        ylab="Proportions",
        col="blue")
