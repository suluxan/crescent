cwlVersion: v1.0

class: CommandLineTool

baseCommand: [Rscript]

inputs:
  R_script_dropbead:
    type: File
    inputBinding: 
      position: 0 
    default:
      class: File
      location: dropbead.R
  
  tsv_input:
    type: File
    inputBinding: 
      position: 1 
      prefix: -i  

  dropbead_project_id:
    type: string
    inputBinding: 
      position: 3 
      prefix: -p 

outputs:
  dropbead_output:
    type: File
    outputBinding:
      glob: DROPBEAD/$(inputs.dropbead_project_id).kneeplot_inflection.txt 
