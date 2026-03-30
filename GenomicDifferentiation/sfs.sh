#!/bin/bash
#ANGSD script for running SFS and pairwise FST extraction

#SBATCH --job-name=sfs
#SBATCH --output=/home/ffalk/links/scratch/sfs.out
#SBATCH --error=/home/ffalk/links/scratch/sfs.err
#SBATCH --nodes=1
#SBATCH --cpus-per-task=128
#SBATCH --time=12:00:00
#SBATCH --account=(fill)

module load angsd

#First generate maximum likelihood estimate of SFS for each population
realSFS pop1.saf.idx -maxIter 100 -P 128 > pop1.sfs
realSFS pop2.saf.idx -maxIter 100 -P 128 > pop2.sfs
realSFS pop3.saf.idx -maxIter 100 -P 128 > pop3.sfs
#Resulting data will be visualized in R

#Extract pairwise fst results (consider weighted)
#Based on input will be in order of pop1.pop2, pop1.pop3, and pop2.pop3
realSFS fst stats here.fst.idx > fstoutput
#Testing sliding window option based on wiki
realSFS fst stats2 here.fst.idx -win 50000 -step 10000 > slidingwindowoutput
#Output will be chromosome number then each pairwise unweight and weight then final branch statistics
