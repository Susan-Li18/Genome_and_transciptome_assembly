#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_nucmer_sample
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/comparing/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/comparing/error_%j.e


# set directory and variable

INPUTDIR="/data/users/jli/assembly_annotation_course/assembly/"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/comparing"

# create the output directory
mkdir -p "$OUTPUTDIR/flye_vs_hifiasm" "$OUTPUTDIR/hifiasm_vs_LJA" "$OUTPUTDIR/flye_vs_LJA"
# run nucmer for flye_vs_hifiasm
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/mummer4_gnuplot.sif \
nucmer -p $OUTPUTDIR/flye_vs_hifiasm/flye_vs_hifiasm $INPUTDIR/flye/assembly.fasta $INPUTDIR/hifiasm/assembly.fasta

# run nucmer for hifiasm_vs_LJA
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/mummer4_gnuplot.sif \
nucmer -p $OUTPUTDIR/hifiasm_vs_LJA/hifiasm_vs_LJA $INPUTDIR/hifiasm/assembly.fasta $INPUTDIR/LJA/assembly.fasta

# run nucmer for flye_vs_LJA
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/mummer4_gnuplot.sif \
nucmer -p $OUTPUTDIR/flye_vs_LJA/flye_vs_LJA $INPUTDIR/flye/assembly.fasta $INPUTDIR/LJA/assembly.fasta
