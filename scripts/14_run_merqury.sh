#!/usr/bin/env bash

#SBATCH --time=06:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_merqury
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/assembly_evaluation/merqury/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/assembly_evaluation/merqury/error_%j.e


# set directory and variable

INPUTDIR="/data/users/jli/assembly_annotation_course/assembly/"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/assembly_evaluation/merqury"
RAWDATA="/data/users/jli/assembly_annotation_course/raw_data/Geg-14"
# create the output directory
mkdir -p $OUTPUTDIR


# set environment variable
export MERQURY="/usr/local/share/merqury"

# prepare meryl dbs (use recommend k=31)
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $RAWDATA /containers/apptainer/merqury_1.3.sif \
meryl k=31 count \
      threads=16 \
      output $OUTPUTDIR/Geg14_HiFi.meryl \
      $RAWDATA/*.fastq.gz || exit 1


#create the flye output folder
mkdir -p "$OUTPUTDIR/flye"
cd "$OUTPUTDIR/flye" || exit 1
# run merqury for flye
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $RAWDATA /containers/apptainer/merqury_1.3.sif \
bash $MERQURY/merqury.sh \
     $OUTPUTDIR/Geg14_HiFi.meryl \
     $INPUTDIR/flye/assembly.fasta \
     flye_merqury

#create the hifiasm output folder
mkdir -p "$OUTPUTDIR/hifiasm"
cd "$OUTPUTDIR/hifiasm" || exit 1
# run merqury for hifiasm
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $RAWDATA /containers/apptainer/merqury_1.3.sif \
bash $MERQURY/merqury.sh \
     $OUTPUTDIR/Geg14_HiFi.meryl \
     $INPUTDIR/hifiasm/assembly.fasta \
     hifiasm_merqury

#create the LJA output folder
mkdir -p "$OUTPUTDIR/LJA"
cd "$OUTPUTDIR/LJA" || exit 1
# run merqury for hifiasm
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR --bind $RAWDATA /containers/apptainer/merqury_1.3.sif \
bash $MERQURY/merqury.sh \
     $OUTPUTDIR/Geg14_HiFi.meryl \
     $INPUTDIR/LJA/assembly.fasta \
     LJA_merqury