#!/bin/bash
#ANGSD script for running ABBABABA D-Statistic test

#SBATCH --job-name=dstat
#SBATCH --output=/home/ffalk/links/scratch/dstat.out
#SBATCH --error=/home/ffalk/links/scratch/dstat.err
#SBATCH --nodes=1
#SBATCH --cpus-per-task=64
#SBATCH --time=12:00:00
#SBATCH --account=def-jazjanes-ab

module load angsd

#Running default
angsd -doAbbababa2 1 -bam bam.filelist -minQ 30 -minMapQ 30 -sizeFile sizeFile.size -doCounts 1 -anc /home/ffalk/BIOL-625-Data/reference/Egrandis_297_v2.0.fa -out /home/ffalk/links/scratch/dstat.Angsd
