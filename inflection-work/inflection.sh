#!/bin/bash
#
#$ -cwd 

cd /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr

module load python/2.7
source /cluster/home/smohanra/pughlab/projects/crescent/toil-example/toil.sh

export TMPDIR=./tmps

toil-cwl-runner --debug inflection.cwl inflection_inputs.yaml

