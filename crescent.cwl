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

  R_script:
    type: File

  sc_input_type:
    type: string

  resolution:
    type: string?

  outdir:
    type: Directory

  project_id:
    type: string

  summary_plots:
    type: string?

  colour_tsne_discrete:
    type: File?

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

        out: [cellranger_meta_output, cellranger_output]

    seurat:
        run: seurat.cwl

        in: 
            R_script: R_script
            sc_input: cellranger/cellranger_output
            sc_input_type: sc_input_type
            resolution: resolution
            outdir: outdir
            project_id: project_id
            summary_plots: summary_plots
            colour_tsne_discrete: colour_tsne_discrete
            list_genes: list_genes
            opacity: opacity
            pca_dimensions: pca_dimensions
            percent_mito: percent_mito
            number_genes: number_genes
            return_threshold: return_threshold

        out: [seurat_output]

outputs:
  cellranger_outdir:
    type: Directory
    outputSource: cellranger/cellranger_output

  seurat_outdir:
    type: Directory
    outputSource: seurat/seurat_output
