#!/bin/bash
#ANGSD script for preparing downstream analysis files

#SBATCH --job-name=ANGSDadmixture
#SBATCH --output=/home/ffalk/links/scratch/angsdmix.out
#SBATCH --error=/home/ffalk/links/scratch/angsdmix.err
#SBATCH --nodes=1
#SBATCH --cpus-per-task=48
#SBATCH --time=12:00:00
#SBATCH --account=def-jazjanes-ab

module load angsd

for K in 3 4 5 6; do
        NGSadmix -likes genolike.beagle.gz -K $K -o /home/ffalk/links/scratch/k${K}-admix -P 48
done
