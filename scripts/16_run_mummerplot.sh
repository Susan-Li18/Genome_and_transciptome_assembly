#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_mummerplot
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/comparing/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/comparing/error_%j.e


# set directory and variable

INPUTDIR="/data/users/jli/assembly_annotation_course/assembly/"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/comparing"
REFERDIR="/data/users/jli/assembly_annotation_course/raw_data/references"

# run mummerplot for flye
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $REFERDIR /containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REFERDIR/*.fa \
           -Q $INPUTDIR/flye/assembly.fasta \
           -t png \
           --filter \
           --large \
           --layout \
           --fat  \
           -p $OUTPUTDIR/flye/ref_vs_flye_plot \
           $OUTPUTDIR/flye/ref_vs_flye.delta

# run mummerplot for hifiasm
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $REFERDIR /containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REFERDIR/*.fa \
           -Q $INPUTDIR/hifiasm/assembly.fasta \
           -t png \
           --filter \
           --large \
           --layout \
           --fat \
           -p $OUTPUTDIR/hifiasm/ref_vs_hifiasm_plot \
           $OUTPUTDIR/hifiasm/ref_vs_hifiasm.delta 

# run mummerplot for LJA
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $REFERDIR /containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REFERDIR/*.fa \
           -Q $INPUTDIR/LJA/assembly.fasta \
           -t png \
           --filter \
           --large \
           --layout \
           --fat \
           -p $OUTPUTDIR/LJA/ref_vs_LJA_plot \
           $OUTPUTDIR/LJA/ref_vs_LJA.delta