#!/bin/bash
#ANGSD script for preparing downstream analysis files

#SBATCH --job-name=PCAngsd
#SBATCH --output=/home/ffalk/links/scratch/pcangsd-maf1.out
#SBATCH --error=/home/ffalk/links/scratch/pcangsd-maf1.err
#SBATCH --nodes=1
#SBATCH --cpus-per-task=64
#SBATCH --time=12:00:00
#SBATCH --account=def-jazjanes-ab

module load angsd

#Default maf is 0.05 trying both.
pcangsd --beagle genolike.beagle.gz --maf 0.05 --eig 4 --threads 64 --out /home/ffalk/links/scratch/pcangsdmaf1
