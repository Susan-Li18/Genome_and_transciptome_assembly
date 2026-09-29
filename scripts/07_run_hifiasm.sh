#!/usr/bin/env bash

#SBATCH --time=03:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=run_hifiasm
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jli/assembly_annotation_course/assembly/hifiasm/output_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/assembly/hifiasm/error_%j.e

# set directory and variable
INPUTDIR="/data/users/jli/assembly_annotation_course/raw_data/Geg-14"
OUTPUTDIR="/data/users/jli/assembly_annotation_course/assembly/hifiasm"
# create output directory
mkdir -p $OUTPUTDIR

# run hifiasm
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR /containers/apptainer/hifiasm_0.25.0.sif \
hifiasm  -o ${OUTPUTDIR}/ERR11437349.asm -t 16  ${INPUTDIR}/ERR11437349.fastq.gz

#convert the output format
awk '/^S/{print ">"$2;print $3}' "${OUTPUTDIR}/ERR11437349.asm.bp.p_ctg.gfa" > "${OUTPUTDIR}/assembly.fasta"