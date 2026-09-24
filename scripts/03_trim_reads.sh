#!/usr/bin/env bash
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=02:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=run_fastp
#SBATCH --output=/data/users/jli/assembly_annotation_course/read_QC/fastp/output_fastqc_%j.o
#SBATCH --error=/data/users/jli/assembly_annotation_course/read_QC/fastp/error_fastqc_%j.e

# set directory
OUTPUTDIR=/data/users/jli/assembly_annotation_course/read_QC/fastp
INPUTDIR=/data/users/jli/assembly_annotation_course/raw_data

# create the output directory
mkdir -p $OUTPUTDIR

# Run fastp on PacBio HiFi reads for statistics only.  Disable all default
# filtering/trimming so that the output contains the same reads and bases as
# the input.
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR \
 /containers/apptainer/fastp_0.24.1.sif \
 fastp -Q -L -A -G \
       -i ${INPUTDIR}/Geg-14/ERR11437349.fastq.gz \
       -o ${OUTPUTDIR}/ERR11437349_clean.fastq.gz \
       -h ${OUTPUTDIR}/Geg-14.fastp.html \
       -j ${OUTPUTDIR}/Geg-14.fastp.json

# run the fastp for RNA, 
apptainer exec --bind $INPUTDIR --bind $OUTPUTDIR \
 /containers/apptainer/fastp_0.24.1.sif \
 fastp -i ${INPUTDIR}/RNAseq_Sha/ERR754081_1.fastq.gz \
       -I ${INPUTDIR}/RNAseq_Sha/ERR754081_2.fastq.gz \
       -o ${OUTPUTDIR}/ERR754081_1_clean.fastq.gz \
       -O ${OUTPUTDIR}/ERR754081_2_clean.fastq.gz \
       --cut_tail \
       --cut_tail_window_size 4 \
       --cut_tail_mean_quality 20 \
       --detect_adapter_for_pe \
       -q 20 \
       -u 30 \
       -n 5 \
       -l 50 \
       -h ${OUTPUTDIR}/RNAseq_Sha.fastp.html \
       -j ${OUTPUTDIR}/RNAseq_Sha.fastp.json
