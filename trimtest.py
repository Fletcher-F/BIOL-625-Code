"""Trim Raw Reads Script Test"""

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
    parser = argparse.ArgumentParser(description="Trim Argument List")
    parser.add_argument("--input", "-i", 
                        help="Path to folder", required=True)
    parser.add_argument("--threads", "-t",
                        help="Specify total number of threads to use. Default is 1.", default=1)
    """Return arguments"""
    return parser.parse_args()

"""Main"""
def trim(args):
    """Assign arguments"""
    path = args.input
    threads = args.threads

    """Running Trimmomatic"""
    #os.mkdir("trimmed-paired")
    #os.mkdir("trimmed-unpaired")

    filepairs = defaultdict(dict)
    print("Pairs of sequences found: \n")
    for file in os.listdir(path):
        if file.endswith("_forward_paired_R1_001.fastq.gz"):
            key = file.replace("_forward_paired_R1_001.fastq.gz", "") 
            filepairs[key]["R1"] = file
        elif file.endswith("_reverse_paired_R2_001.fastq.gz"):
            key = file.replace("_reverse_paired_R2_001.fastq.gz", "") 
            filepairs[key]["R2"] = file
        print(file)

    for sample, reads in filepairs.items():
        print(sample)
        print(reads)
        forward = reads["R1"]
        reverse = reads["R2"]
        print(forward)
        print(reverse)
        print(sample)
        """
        trim = "java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE -threads " + threads + " " + path + "/" + forward + " " + path + "/" + reverse + " " \
            "./trimmed-paired/" + sample + "_output_forward_paired.fq.gz " + "./trimmed-unpaired/" + sample + "_output_forward_unpaired.fq.gz " + \
            "./trimmed-paired/" + sample + "_output_reverse_paired.fq.gz " + "./trimmed-unpaired/" + sample + "_output.reverse_unpaired.fq.gz " + \
            "ILLUMINACLIP:./adapters/Nextera-Ad.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36"
        execute(trim)
        """
        
"""Main: sets up arguments and runs program"""
def main():
    args = argument_parser()
    trim(args)

"""Start Program"""
if __name__ == "__main__":
    main()