#!/bin/bash
#
#$ -cwd 

cd /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr

module load R
module load python/2.7
source /cluster/home/smohanra/pughlab/projects/crescent/toil-example/toil.sh

export TMPDIR=./tmps

toil-cwl-runner --debug dropbead.cwl dropbead_inputs.yaml

#java \
#    -jar \
#    /cluster/projects/pughlab/projects/crescent/toil-example/cwl/cr/tmps/tmpNSoOpp/stg41cda321-32e8-41ea-b4dd-741f445dc1b5/dropseq.jar \
#    BamTagHistogram \
#    TAG=CB \
#    I=/cluster/projects/pughlab/projects/crescent/toil-example/cwl/cr/tmps/tmpNSoOpp/stgae40c19e-9cb4-4fe9-87df-9ed329ebe741/possorted_genome_bam.bam \
#    O=possorted_genome_reads_per_barcode.tsv


#toil-cwl-runner --debug --disableCaching --workDir /mnt/work1/users/home2/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/tmps  cellranger.cwl cr_inputs.yaml
#toil-cwl-runner --debug --tmpdir-prefix /mnt/work1/users/home2/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/tmps --tmp-outdir-prefix /mnt/work1/users/home2/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/tmps cellranger.cwl cr_inputs.yaml
 
