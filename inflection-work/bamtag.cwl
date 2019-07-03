cwlVersion: v1.0

class: CommandLineTool

baseCommand: [BamTagHistogram]

inputs:
  bamtag_tag:
    type: string
    inputBinding: 
      position: 2 
      prefix: TAG= 
      separate: false

  bamtag_input:
    type: File
    inputBinding: 
      position: 3 
      prefix: I= 
      separate: false

  bamtag_output_string:
    type: string
    inputBinding: 
      position: 4 
      prefix: O= 
      separate: false

outputs:
  bamtag_output:
    type: File
    outputBinding:
      glob: $(inputs.bamtag_output_string)

