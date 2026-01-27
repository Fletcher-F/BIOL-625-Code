#!/bin/bash
#Python script scheduler

#SBATCH --job-name=py
#SBATCH --output=scheduler.out
#SBATCH --error=scheduler.err
#SBATCH --cpus-per-task=4
#SBATCH --time=48:00:00
#SBATCH --mem=14G

module load python/3.10
module load trimmomatic
module load fastqc/0.12.1
module load bwa-mem2
module load bwa
module load StdEnv/2020
module load nextgenmap/0.5.5
module load samtools

python3 "$@"