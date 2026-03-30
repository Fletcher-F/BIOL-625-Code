#!/bin/bash
#ANGSD script for running FST analysis

#SBATCH --job-name=fst
#SBATCH --output=/home/ffalk/links/scratch/fst.out
#SBATCH --error=/home/ffalk/links/scratch/fst.err
#SBATCH --nodes=1
#SBATCH --cpus-per-task=128
#SBATCH --time=12:00:00
#SBATCH --account=(fill)

module load angsd

#Running default
#Example of output saf for all files. Need to split into populations (species).
#angsd -bam ./bam.filelist -doSaf 1 -out ./ANGSD-final-results/siteafreq -anc ./reference/Egrandis_297_v2.0.fa -GL 2 -P 128 -minMapQ 1 -minQ 20

#modified version for 3 pops from wiki
#first calculate per pop saf for each population
angsd -b pop1.filelist -anc /home/ffalk/BIOL-625-Data/reference/Egrandis_297_v2.0.fa -out /home/ffalk/links/scratch/pop1 -doSaf 1 -gl 2 -P 128 -minMapQ 1 -minQ 20
angsd -b pop2.filelist -anc /home/ffalk/BIOL-625-Data/reference/Egrandis_297_v2.0.fa -out /home/ffalk/links/scratch/pop2 -doSaf 1 -gl 2 -P 128 -minMapQ 1 -minQ 20
angsd -b pop3.filelist -anc /home/ffalk/BIOL-625-Data/reference/Egrandis_297_v2.0.fa -out /home/ffalk/links/scratch/pop3 -doSaf 1 -gl 2 -P 128 -minMapQ 1 -minQ 20

#calculate all pairwise 2dsfs's
realSFS /home/ffalk/links/scratch/pop1.saf.idx /home/ffalk/links/scratch/pop2.saf.idx -P 128 > /home/ffalk/links/scratch/pop1.pop2.ml
realSFS /home/ffalk/links/scratch/pop1.saf.idx /home/ffalk/links/scratch/pop3.saf.idx -P 128 > /home/ffalk/links/scratch/pop1.pop3.ml
realSFS /home/ffalk/links/scratch/pop2.saf.idx /home/ffalk/links/scratch/pop3.saf.idx -P 128 > /home/ffalk/links/scratch/pop2.pop3.ml

#prepare the fst for easy analysis etc
#Use this output to generate weighted and unweighted fst in next script sfs.sh
realSFS fst index /home/ffalk/links/scratch/pop1.saf.idx /home/ffalk/links/scratch/pop2.saf.idx /home/ffalk/links/scratch/pop3.saf.idx -sfs /home/ffalk/links/scratch/pop1.pop2.ml -sfs /home/ffalk/links/scratch/pop1.pop3.ml -sfs /home/ffalk/links/scratch/pop2.pop3.ml -fstout /home/ffalk/links/scratch/here
