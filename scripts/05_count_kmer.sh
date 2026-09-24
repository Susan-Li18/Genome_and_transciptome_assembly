#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=40G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=count_kmer
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/read_QC/count_kmer/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/read_QC/count_kmer/error_%j.e


# set the directory and variable
INPUTDIR="/data/users/jli/assembly_annotation_course/read_QC/fastp"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/read_QC/count_kmer"
seq="${INPUTDIR}/ERR11437349_clean.fastq.gz"
OUTPUT="${OUTPUTDIR}/Geg-14.jf"

# create the folder
mkdir -p "$OUTPUTDIR"

# run jellyfish  
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/jellyfish-2.2.6--0.sif \
jellyfish count -C -m 21 -s 5G -t 4 -o "$OUTPUT" <(zcat "$seq") 

# create the histogram
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/jellyfish-2.2.6--0.sif \
jellyfish histo -t 4 "$OUTPUT" > ${OUTPUTDIR}/Geg-14.histo

