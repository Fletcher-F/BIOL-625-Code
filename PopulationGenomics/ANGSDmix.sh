#!/bin/bash
#ANGSD script for preparing downstream analysis files

#SBATCH --job-name=ANGSDadmixture
#SBATCH --output=angsdmix.out
#SBATCH --error=angsdmix.err
#SBATCH --cpus-per-task=2
#SBATCH --time=48:00:00
#SBATCH --mem=128G

module load angsd

for K in 1 2 3 4 5 6; do
	NGSadmix -likes genolike.beagle.gz -K $K -o k${K}-admix -P 2
done