#Important information for running these programs:
You may have to adjust the time, cpus, and memory in the scheduler.sh script.
Scheduler takes in any arguments including the python script and will run it subsequently.

Basic command line to run: sbatch scheduler.sh [scriptname.py] -t [threads] -i [./trimmed-reads-folder] -r [./reference-genome.fa]

Output should be captured in scheduler.out and scheduler.err if any errors occur.

Trim.py: takes an input folder including only files with the extension *.fastq.gz
Will output folders: initial-fastqc, trimmed-paired, trimmed-unpaired, and final-fastqc
