#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem=1G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=busco_plot
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/assembly_evaluation/busco/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/assembly_evaluation/busco/error_%j.e


# set directory and variable

INPUTDIR="/data/users/jli/assembly_annotation_course/result/assembly_evaluation/busco"


# run busco

apptainer exec --bind $INPUTDIR /containers/apptainer/busco_5.7.1.sif \
generate_plot.py -wd $INPUTDIR/$1