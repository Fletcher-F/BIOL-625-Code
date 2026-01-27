## Important information for running these programs:
### You may have to adjust the time, cpus, and memory in the scheduler.sh script.
### Scheduler takes in any arguments including the python script and will run it subsequently.

Basic command line to run: sbatch scheduler.sh [scriptname.py] -t [threads] -i [./trimmed-reads-folder] -r [./reference-genome.fa]

Output should be captured in scheduler.out and scheduler.err if any errors occur.

### Trim.py
Takes an input folder including only files with the extension *.fastq.gz

IMPORTANT: files must be organized as _R1_001.fastq.gz for the forward read and _R2_001.fastq.gz for the reverse read.

IMPORTANT: the code is currently optimized for Nextera adapters based on prior FastQC results. Specified by ./adapters/Nextera-Ad.fa on **line 86 of trim.py**. This needs to be changed to your given adapter.

Will output folders: initial-fastqc, trimmed-paired, trimmed-unpaired, and final-fastqc.

### Alignment.py
Takes an input folder (trimmed-paired) and a path to a reference genome for alignment.

Will output folders: bwa-align, ngm-align, bwa-samtools-results, and ngm-samtools-results.
