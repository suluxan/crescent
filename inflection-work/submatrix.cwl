cwlVersion: v1.0

class: CommandLineTool

requirements:
  DockerRequirement:
    dockerImageId: crescent-v3

baseCommand: [Rscript]

inputs:

  R_script_submatrix:
    type: File
    inputBinding: 
      position: 0 
  
  mtx_files:
    type: Directory
    inputBinding:
      position: 1
      prefix: -i

  final_tsv:
    type: File
    inputBinding: 
      position: 2  
      prefix: -b

  
outputs:
  submatrix_output:
    type: Directory
    outputBinding:
      glob: SUBMATRIX

