#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem-per-cpu=1000M
#SBATCH --cpus-per-task=2
#SBATCH --job-name=fastqc_clean
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/read_QC/fastqc_clean/output_fastqc_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/read_QC/fastqc_clean/error_fastqc_%j.e

INPUTDIR="/data/users/jli/assembly_annotation_course/read_QC/fastp"
OUTDIR="/data/users/jli/assembly_annotation_course/read_QC/fastqc_clean"
mkdir -p $OUTDIR
apptainer exec --bind $INPUTDIR --bind $OUTDIR /containers/apptainer/fastqc-0.12.1.sif \
fastqc -t 2 -o $OUTDIR $INPUTDIR/ERR754081*_clean.fastq.gz
