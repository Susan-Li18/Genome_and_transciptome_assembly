#!/usr/bin/env bash

#SBATCH --time=12:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_trinity
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/assembly/trinity/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/assembly/trinity/error_%j.e


# set directory and variable

INPUTDIR="/data/users/jli/assembly_annotation_course/read_QC/fastp"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/assembly/trinity"

mkdir -p $OUTPUTDIR

#load the module
module purge
module load Trinity/2.15.1-foss-2021a

Trinity --version
# run trinity
Trinity --seqType fq --left ${INPUTDIR}/*_1_clean.fastq.gz --right ${INPUTDIR}/*_2_clean.fastq.gz --output ${OUTPUTDIR} --max_memory 50G --CPU 10