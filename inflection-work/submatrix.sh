#!/bin/bash
#
#$ -cwd 

cd /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/javier

module load R
Rscript /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/javier/submatrix/submatrix.R -i /cluster/home/smohanra/pughlab/projects/crescent/premrna_test/test0/troy_test1_premrna0/outs/raw_gene_bc_matrices/GRCh38-1.2.0_premrna -o /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/javier/submatrix_outputs -b /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/dropbead_filted.tsv -g ALL 


#Rscript /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/javier/Seurat_clustering_wrapper/Runs_Seurat_Clustering.R -i /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/javier/example_files/examples/inputs/from_cellranger/outs/filtered_gene_bc_matrices -t 10X -r 1 -o /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/javier/seurat_outputs -p example_10X -s n -c /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/javier/example_files/examples/inputs/gene_rows_cell_columns/Matrix_GenesInRows_CellsInColumns.tsv -g MALAT1,GAPDH -a 0.1 -d 10 -m Inf,0.05 -n 200,8000 -e 0.01
#Rscript /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/javier/Seurat_clustering_wrapper/Runs_Seurat_Clustering.R -i /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/saved_outputs/run1/outs/filtered_gene_bc_matrices/GRCh38-1.2.0_premrna -t 10X -r 1 -o /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/javier/seurat_outputs -p example_10X -s n -c /cluster/home/smohanra/pughlab/projects/crescent/toil-example/cwl/cr/javier/example_files/examples/inputs/gene_rows_cell_columns/Matrix_GenesInRows_CellsInColumns.tsv -g MALAT1,GAPDH -a 0.1 -d 10 -m Inf,0.05 -n 200,8000 -e 0.01










