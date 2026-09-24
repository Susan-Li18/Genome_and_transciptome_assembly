#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem-per-cpu=1000M
#SBATCH --cpus-per-task=2
#SBATCH --job-name=fastqc
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/read_QC/fastqc/output_fastqc_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/read_QC/fastqc/error_fastqc_%j.e

INPUTDIR="/data/users/jli/assembly_annotation_course/raw_data"
OUTDIR="/data/users/jli/assembly_annotation_course/read_QC/fastqc"
mkdir -p $OUTDIR
apptainer exec --bind $INPUTDIR --bind $OUTDIR /containers/apptainer/fastqc-0.12.1.sif \
fastqc -t 2 -o $OUTDIR $INPUTDIR/Geg-14/*.fastq.gz
apptainer exec --bind $INPUTDIR --bind $OUTDIR /containers/apptainer/fastqc-0.12.1.sif \
fastqc -t 2 -o $OUTDIR $INPUTDIR/RNAseq_Sha/*.fastq.gz