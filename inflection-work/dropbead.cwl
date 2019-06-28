cwlVersion: v1.0

class: CommandLineTool

baseCommand: [Rscript]

inputs:
  R_script:
    type: File
    inputBinding: 
      position: 0 
  
  tsv_input:
    type: File
    inputBinding: 
      position: 1 
      prefix: -i  

  dropbead_outdir:
    type: Directory
    inputBinding: 
      position: 2 
      prefix: -o 

  dropbead_project_id:
    type: string
    inputBinding: 
      position: 3 
      prefix: -p 

outputs:
  dropbead_plot_output:
    type: Directory
    outputBinding:
      glob: $(inputs.dropbead_outdir)
