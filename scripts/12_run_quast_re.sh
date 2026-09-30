#!/usr/bin/env bash

#SBATCH --time=06:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_quast
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/assembly_evaluation/quast/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/assembly_evaluation/quast/error_%j.e


# set directory and variable

INPUTDIR="/data/users/jli/assembly_annotation_course/assembly/"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/assembly_evaluation/quast/with_reference"
REFERDIR="/data/users/jli/assembly_annotation_course/raw_data/references"
# create the output directory
mkdir -p $OUTPUTDIR

# run quast

apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $REFERDIR /containers/apptainer/quast_5.2.0.sif \
quast.py $INPUTDIR/flye/assembly.fasta $INPUTDIR/hifiasm/assembly.fasta $INPUTDIR/LJA/assembly.fasta $INPUTDIR/LJA_di/assembly.fasta \
-r $REFERDIR/*.fa.gz \
-g $REFERDIR/*.gff3 \
-o $OUTPUTDIR \
-t 10 \
-e \
--large \
--labels "flye,hifiasm,LJA,LJA_di"