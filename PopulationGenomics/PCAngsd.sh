#!/bin/bash
#ANGSD script for preparing downstream analysis files

#SBATCH --job-name=ANGSDadmixture
#SBATCH --output=angsdmix.out
#SBATCH --error=angsdmix.err
#SBATCH --cpus-per-task=32
#SBATCH --time=48:00:00
#SBATCH --mem=64G

module load angsd

pcangsd --beagle genolike.beagle.gz --eig 2 --threads 32 --out pcangsd