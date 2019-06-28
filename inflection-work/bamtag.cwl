cwlVersion: v1.0

class: CommandLineTool

baseCommand: [java, -jar]

inputs:
  jar_executable:
    type: File
    inputBinding: 
      position: 0 

  tool_name:
    type: string
    inputBinding: 
      position: 1  

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

