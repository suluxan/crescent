cwlVersion: v1.0

class: CommandLineTool

#requirements:
#  DockerRequirement:
#    dockerImageId: crescent-v3

baseCommand: [Rscript]

inputs:

  R_script_inflection:
    type: File
    inputBinding: 
      position: 0 
    default:
      class: File
      location: inflection_filter.R

  inflection_point:
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

