cwlVersion: v1.0

class: Workflow

requirements:
  DockerRequirement:
    dockerImageId: crescent-v3

inputs:
  bamtag_tag:
    type: string

  bamtag_input:
    type: File

  bamtag_output_string:
    type: string 

  R_script_dropbead:
    type: File 

#  tsv_input:
#    type: File

  dropbead_project_id: 
    type: string 

  R_script_inflection:
    type: File

#  inflection_point:
#    type: File

#  input_tsv:
#    type: File


  R_script_submatrix:
    type: File 

  mtx_files: 
    type: Directory

#  final_tsv:
#    type: File

steps:
    bamtag:
        run: bamtag.cwl
        in:
            bamtag_input: bamtag_input
            bamtag_tag: bamtag_tag
            bamtag_output_string: bamtag_output_string

        out: [bamtag_output]

    dropbead:
        run: dropbead.cwl
        in:
            R_script_dropbead: R_script_dropbead
            tsv_input: bamtag/bamtag_output
            dropbead_project_id: dropbead_project_id 

        out: [dropbead_output]

    inflection:
        run: inflection.cwl
        in:
            R_script_inflection: R_script_inflection
            inflection_point: dropbead/dropbead_output
            input_tsv: bamtag/bamtag_output

        out: [inflection_output]

    submatrix:
        run: submatrix.cwl
        in:
            R_script_submatrix: R_script_submatrix
            mtx_files: mtx_files
            final_tsv: inflection/inflection_output 

        out: [submatrix_output]

outputs:
  submatrix_outdir:
    type: Directory
    outputSource: submatrix/submatrix_output
