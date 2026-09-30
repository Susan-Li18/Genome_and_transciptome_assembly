#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_nucmer
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/comparing/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/comparing/error_%j.e


# set directory and variable

INPUTDIR="/data/users/jli/assembly_annotation_course/assembly/"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/comparing"
REFERDIR="/data/users/jli/assembly_annotation_course/raw_data/references"
# create the output directory
mkdir -p $OUTPUTDIR
mkdir -p "$OUTPUTDIR/flye" "$OUTPUTDIR/hifiasm" "$OUTPUTDIR/LJA"
# run nucmer for flye
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $REFERDIR /containers/apptainer/mummer4_gnuplot.sif \
nucmer -p $OUTPUTDIR/flye/ref_vs_flye $REFERDIR/*.fa $INPUTDIR/flye/assembly.fasta

# run nucmer for hifiasm
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $REFERDIR /containers/apptainer/mummer4_gnuplot.sif \
nucmer -p $OUTPUTDIR/hifiasm/ref_vs_hifiasm $REFERDIR/*.fa $INPUTDIR/hifiasm/assembly.fasta

# run nucmer for LJA
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $REFERDIR /containers/apptainer/mummer4_gnuplot.sif \
nucmer -p $OUTPUTDIR/LJA/ref_vs_LJA $REFERDIR/*.fa $INPUTDIR/LJA/assembly.fasta
