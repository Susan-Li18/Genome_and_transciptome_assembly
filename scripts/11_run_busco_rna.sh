#!/usr/bin/env bash

#SBATCH --time=06:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_busco
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/assembly_evaluation/busco/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/assembly_evaluation/busco/error_%j.e


# set directory and variable

INPUTDIR="/data/users/jli/assembly_annotation_course/assembly/"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/assembly_evaluation/busco"

# create the output directory
mkdir -p $OUTPUTDIR

# run busco

apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/busco_5.7.1.sif \
busco -i $INPUTDIR/$1/Trinity.fasta \
      --out_path $OUTPUTDIR \
      -o $1 \
      -m transcriptome \
      -l brassicales_odb10 \
      -c 16