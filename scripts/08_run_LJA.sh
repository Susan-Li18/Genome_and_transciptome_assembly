#!/usr/bin/env bash

#SBATCH --time=03:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_LJA
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/assembly/LJA/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/assembly/LJA/error_%j.e

# set directory and variable
INPUTDIR="/data/users/jli/assembly_annotation_course/raw_data/Geg-14"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/assembly/LJA"
# create output directory
mkdir -p $OUTPUTDIR

apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/lja-0.2.sif \
lja -t 16 -o ${OUTPUTDIR} --reads ${INPUTDIR}/ERR11437349.fastq.gz