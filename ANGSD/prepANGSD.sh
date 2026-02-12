#!/bin/bash
#ANGSD script for preparing downstream analysis files

#SBATCH --job-name=ANGSDprep
#SBATCH --output=angsdprep.out
#SBATCH --error=angsdprep.err
#SBATCH --cpus-per-task=4
#SBATCH --time=140:00:00
#SBATCH --mem=14G

module load angsd

#ANDSD results directory
mkdir ANGSD-final-results

#Make initial bam file list for commands
#ls ./bwa-align/*.bam

#Using genotype likelihood model 2 and 
#filtering meaningless mapQ reads and bad qscore bases.
#saf 1 calculates site allele frequency likelihood based on individual genotype likelihoods assuming HWE.
#-P is threads.

angsd -GL 2 -out ./ANGSD-final-results/readablegeno -nThreads 4 -doGeno 4 -doPost 1 -doMaf 3 -doMajorMinor 1 -postCutoff 0.95 -SNP_pval 1e-6 -bam ./bam.filelist
#Output geno in human readable format (called genotype AA, AC, AG)
#needs -doMaf to run so slightly redudant will generate two maf files
#-doPost 1 estimates posterior genotype probability based on allele freuqency as prior

angsd -bam ./bam.filelist -doSaf 1 -out ./ANGSD-final-results/siteafreq -anc ./reference/Egrandis_297_v2.0.fa -GL 2 -P 4 -minMapQ 1 -minQ 20
#Output saf file

angsd -GL 2 -out ./ANGSD-final-results/genolike -anc ./reference/Egrandis_297_v2.0.fa -nThreads 4 -doGeno 32 -doPost 1 -postCutoff 0.95 -doGlf 2 -doMajorMinor 1 -doMaf 3 -SNP_pval 1e-6 -bam ./bam.filelist
#Output Beagle, maf, post, and binary posterior geno
#GL 1 for SAMtools likelihood (filtering required?). Maf 2 does fixed major unknown minor alleles
#Note: Highly recommend users don't perform analysis on called genotypes unless they have high depth, as likely bias downstream analysis
#Maf 3 = estimating the allele frequencies both while assuming known major and minor allele but also while taking the uncertaincy of the minor allele inference



