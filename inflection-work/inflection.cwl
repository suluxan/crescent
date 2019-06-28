cwlVersion: v1.0

class: CommandLineTool
requirements:
  - class: ShellCommandRequirement


baseCommand: []

inputs:
  inflection:
    type: File
    inputBinding: 
      position: 0 

  input_tsv:
    type: File
    inputBinding: 
      position: 1  

  output_tsv:
    type: File
    inputBinding: 
      position: 1  
  
arguments: 
  - "awk -v '$(cat $(inputs.inflection))' '$1 >= var {print}' $(inputs.input_tsv) > $(inputs.output_tsv)"
    shellQuote: false

outputs:
  inflection_output:
    type: File
    outputBinding:
      glob: $(inputs.output_tsv)

