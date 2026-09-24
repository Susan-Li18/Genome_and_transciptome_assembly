#!/usr/bin/env bash

#SBATCH --time=03:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_flye
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/assembly/flye/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/assembly/flye/error_%j.e

# set directory and variable
INPUTDIR="/data/users/jli/assembly_annotation_course/raw_data/Geg-14"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/assembly/flye"
# create output directory
mkdir -p $OUTPUTDIR

apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/flye_2.9.5.sif \
flye --pacbio-hifi ${INPUTDIR}/ERR11437349.fastq.gz --out-dir ${OUTPUTDIR} --threads 16