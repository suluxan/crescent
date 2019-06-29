cwlVersion: v1.0

class: CommandLineTool

requirements:
  DockerRequirement:
    dockerImageId: crescent-v3

baseCommand: [Rscript]

inputs:

  R_script:
    type: File
    inputBinding: 
      position: 0 

  inflection:
    type: File
    inputBinding: 
      position: 1
      prefix: -i

  input_tsv:
    type: File
    inputBinding: 
      position: 2  
      prefix: -b

  
outputs:
  inflection_output:
    type: File
    outputBinding:
      glob: filtered_inflection_final.tsv

