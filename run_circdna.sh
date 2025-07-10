#!/bin/bash --login
#SBATCH --job-name=circdna_myc
#SBATCH --time=24:00:00
#SBATCH --mem=4GB
#SBATCH --cpus-per-task=1
#SBATCH --output=circdna_myc-%j.out

# Load Nextflow
module purge
module load Nextflow/24.10.2

# Set the relative paths to the genome files
GENOME_DIR="/mnt/scratch/vusichjo/circdna_myc/data_repo/mm10"
FASTA="$GENOME_DIR/mm10.fa"
DATA_REPO="/mnt/scratch/vusichjo/circdna_myc/data_repo"

# Define the samplesheet, outdir, workdir, and config
SAMPLESHEET="/mnt/scratch/vusichjo/circdna_myc/samplesheet.csv"
OUTDIR="/mnt/scratch/vusichjo/circdna_myc/results"
WORKDIR="/mnt/scratch/vusichjo/circdna_myc_work"
CONFIG="/mnt/scratch/vusichjo/circdna_myc/icer.config"
LICENSE="/mnt/scratch/vusichjo/circdna_myc/mosek_license_dir"

# Run the differential abundance analysis
nextflow run nf-core/circdna -r 1.1.0 -profile singularity -work-dir $WORKDIR -resume \
--input $SAMPLESHEET \
--outdir $OUTDIR \
--fasta $FASTA \
--input_format 'FASTQ' \
--circle_identifier 'ampliconarchitect' \
--mosek_license_dir $LICENSE \
--aa_data_repo $DATA_REPO \
--reference_build 'mm10' \
-c $CONFIG
