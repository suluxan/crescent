#!/usr/bin/env cwl-runner

cwlVersion: v1.0

class: Workflow

inputs:
  run_name:
    type: string

  transcriptome:
    type: Directory

  fastqs:
    type: Directory

  sample:
    type: string

  jobmode:
    type: string?

  R_script_normalize:
    type: File
    
  R_script_pca:
    type: File

  R_script_clustering:
    type: File
    
  R_script_diff_expression:
    type: File

  sc_input_type:
    type: string

  resolution:
    type: string?

  project_id:
    type: string

  list_genes:
    type: string?

  opacity:
    type: string?

  pca_dimensions:
    type: string?

  percent_mito:
    type: string?

  number_genes:
    type: string?

  return_threshold:
    type: string?

steps:
    cellranger:
        run: cellranger.cwl
        in:
            run_name: run_name
            transcriptome: transcriptome
            fastqs: fastqs
            sample: sample
            jobmode: jobmode

        out: [cellranger_output]

    seurat_normalize:
        run: seurat_normalize.cwl

        in: 
            R_script: R_script_normalize
            sc_input: cellranger/cellranger_output
            sc_input_type: sc_input_type
            project_id: project_id
            list_genes: list_genes
            percent_mito: percent_mito
            number_genes: number_genes

        out: [seurat_normalize_object]

    seurat_pca:
        run: seurat_pca.cwl

        in: 
            R_script: R_script_pca
            seurat_input_object: seurat_normalize/seurat_normalize_object
            pca_dimensions: pca_dimensions

        out: [seurat_pca_object]
        
    seurat_clustering:
        run: seurat_clustering.cwl

        in: 
            R_script: R_script_clustering
            seurat_input_object: seurat_pca/seurat_pca_object
            resolution: resolution
            opacity: opacity
            
        out: [seurat_clustering_object]
        
    seurat_diff_expression:
        run: seurat_diff_expression.cwl

        in: 
            R_script: R_script_diff_expression
            seurat_input_object: seurat_clustering/seurat_clustering_object
            return_threshold: return_threshold

        out: [seurat_output]

outputs:
  seurat_outdir:
    type: Directory
    outputSource: seurat_diff_expression/seurat_output
