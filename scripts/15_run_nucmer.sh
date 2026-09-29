#!/usr/bin/env bash

#SBATCH --time=06:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_nucmer
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/comparing/nucmer/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/comparing/nucmer/error_%j.e


# set directory and variable

INPUTDIR="/data/users/jli/assembly_annotation_course/assembly/"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/comparing/nucmer"
REFERDIR="/data/users/jli/assembly_annotation_course/raw_data/references"
# create the output directory
mkdir -p $OUTPUTDIR

apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/mummer4_gnuplot.sif \