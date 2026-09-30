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


# run mummerplot for flye_vs_hifiasm
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $INPUTDIR/flye/assembly.fasta  \
           -Q $INPUTDIR/hifiasm/assembly.fasta \
           -t png \
           --filter \
           --large \
           --layout \
           --fat \
           -p $OUTPUTDIR/flye_vs_hifiasm/flye_vs_hifiasm_plot \
           $OUTPUTDIR/flye_vs_hifiasm/flye_vs_hifiasm.delta

# run mummerplot for hifiasm_vs_LJA
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $INPUTDIR/hifiasm/assembly.fasta \
           -Q $INPUTDIR/LJA/assembly.fasta \
           -t png \
           --filter \
           --large \
           --layout \
           --fat \
           -p $OUTPUTDIR/hifiasm_vs_LJA/hifiasm_vs_LJA_plot \
           $OUTPUTDIR/hifiasm_vs_LJA/hifiasm_vs_LJA.delta

# run mummerplot for flye_vs_LJA
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $INPUTDIR/flye/assembly.fasta \
           -Q $INPUTDIR/LJA/assembly.fasta \
           -t png \
           --filter \
           --large \
           --layout \
           --fat \
           -p $OUTPUTDIR/flye_vs_LJA/flye_vs_LJA_plot \
           $OUTPUTDIR/flye_vs_LJA/flye_vs_LJA.delta