"""Alignment Script
Developed by: Fletcher Falk
Jan 13, 2026
Script takes input path to folder and runs three different alignment software
(BWA and NextGenMap) onto a passed reference genome."""

"""Importing libraries"""
import os, subprocess, argparse, sys
from pathlib import Path
from collections import defaultdict

"""Function to execute bash commands"""
def execute(command):
    result = subprocess.run(command, shell=True, check=True, text=True, capture_output=True)
    print(result.stdout, "\n", result.stderr)

"""Arguments for running the program"""
def argument_parser():
    """Arguments"""
    parser = argparse.ArgumentParser(description="Alignment Argument List")
    parser.add_argument("--input", "-i", 
                        help="Path to folder", required=True)
    parser.add_argument("--reference", "-r",
                        help="Specify reference genome", required=True)
    parser.add_argument("--threads", "-t",
                        help="Specify total number of threads to use. Default is 1.", default=1)
    """Return arguments"""
    return parser.parse_args()

"""Main"""
def alignment(args):
    """Assign arguments"""
    path = args.input
    reference = args.reference
    threads = args.threads

    """Start"""
    print("--- Running Alignment --- \n", 
    "Using ", threads, " threads... \n", "File(s) path = ", path, "\n",
    "Reference genome: ", reference, "\n")

    """Running both BWA and NextGenMap"""
    filepairs = defaultdict(dict)
    print("Pairs of sequences found: \n")
    for file in os.listdir(path):
        if file.endswith("_forward_paired_R1_001.fastq.gz"):
            key = file.replace("_forward_paired_R1_001.fastq.gz", "") 
            filepairs[key]["R1"] = file
        elif file.endswith("_reverse_paired_R2_001.fastq.gz"):
            key = file.replace("_reverse_paired_R2_001.fastq.gz", "") 
            filepairs[key]["R2"] = file

    print("Indexing reference genome for BWA")
    """Using original bwa due to memory issues
    and indexing issues"""
    bwaindex = "bwa index " + reference
    execute(bwaindex)
    print("Indexing reference genome for NGM")
    ngmindex = "ngm -r " + reference
    execute(ngmindex)

    """Making directories for output bam"""
    os.mkdir("bwa-align")
    os.mkdir("ngm-align")

    """Run each program on the given sample"""
    for sample, reads in filepairs.items():
        forward = reads["R1"]
        reverse = reads["R2"]
        bwa = "bwa mem -t " + threads + " " + reference + " " + path + "/" + forward + " " + path + "/" + reverse + " | samtools sort --write-index -@ " + threads + " -o ./bwa-align/" + sample + "_bwaalign.bam -"
        nextgen = "ngm -r " + reference + " -1 " + path + "/" + forward + " -2 " + path + "/" + reverse + " -t " + threads + " -b | samtools sort --write-index -@ " + threads + " -o ./ngm-align/" + sample + "_ngmalign.bam -"
        print("Running NextGenMap on: " + sample)
        execute(nextgen)
        print("Running BWA on: " + sample)
        execute(bwa)

    """SAMtools after to review"""
    os.mkdir("bwa-samtools-results")
    os.mkdir("ngm-samtools-results")
    for sample, reads in filepairs.items():
        bwasamtools = "samtools stats -@ " + threads + " ./bwa-align/" + sample + "_bwaalign.bam > ./bwa-samtools-results/" + sample + "_stats.txt"
        ngmsamtools = "samtools stats -@ " + threads + " ./ngm-align/" + sample + "_ngmalign.bam > ./ngm-samtools-results/" + sample + "_stats.txt"
        execute(bwasamtools)
        execute(ngmsamtools)

"""Main: sets up arguments and runs program"""
def main():
    args = argument_parser()
    alignment(args)

"""Start Program"""
if __name__ == "__main__":
    main()
