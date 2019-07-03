####################################
### Javier Diaz - javier.diazmejia@gmail.com
### Script that takes a mtx set of files (barcodes.tsv, genes.tsv and matrix.mtx)
### and a list of barcodes and returns a new set of mtx files restricted to
### --select_barcodes and --select_genes
####################################

####################################
### Required libraries
####################################
suppressPackageStartupMessages(library(DropletUtils))  # to habdle reading and writing mtx files
suppressPackageStartupMessages(library(Matrix))        # to get rowSums (number of reads for each barcode)
suppressPackageStartupMessages(library(optparse))      # (CRAN) to handle one-line-commands
####################################

####################################
### Turning warnings off for the sake of a cleaner aoutput
####################################
oldw <- getOption("warn")
options( warn = -1 )

####################################
### Get inputs from command line argumets
####################################
#
option_list <- list(
  make_option(c("-i", "--input"), default="NA",
              help="Path/name to a 10X *directory* with barcodes.tsv, genes.tsv and matrix.mtx files"),
#
  make_option(c("-b", "--select_barcodes"), default="NA",
              help="One of three options:
              A path/name for the *file* with the list of barcodes to select, one-per-row
              Or type a *numeric value* to print barcodes with a *sum* across all genes >= *numeric value*
              Or type 'ALL' to print all barcodes from --input into outfile")
#
#  make_option(c("-g", "--select_genes"), default="NA",
#              help="One of three options:
#              A path/name for the *file* with the list of genes to select, one-per-row
#              Or type a *numeric value* to print genes with a *sum* across all barcodes >= *numeric value*
#              Or type 'ALL' to print all genes from --input into outfile"),
#
  )

opt <- parse_args(OptionParser(option_list=option_list))

Input          <- opt$input
SelectBarcodes <- opt$select_barcodes
SelectGenes    <- "ALL"
Outdir         <- "SUBMATRIX"
PrefixOutfiles <- "selected_gene_bc_matrices"
print(SelectBarcodes)

StartTimeOverall<-Sys.time()

####################################
### Check that mandatory parameters are not 'NA' (default)
####################################

ListMandatory<-list("input")
for (param in ListMandatory) {
  if (length(grep('^NA$',opt[[param]], perl = T))) {
    stop(paste("Parameter -", param, " can't be 'NA' (default). Use option -h for help.", sep = "", collapse = ""))
  }
}

####################################
### Create outdirs
####################################

#CommandsToGetUserHomeDirectory<-("eval echo \"~$USER\"")
#UserHomeDirectory<-system(command = CommandsToGetUserHomeDirectory, input = NULL, wait = T, intern = T)
#
#Outdir<-gsub("^~/",paste(c(UserHomeDirectory,"/"), sep = "", collapse = ""), Outdir)
OutdirFinal<-paste(Outdir, "/selected_gene_bc_matrices",  sep = "", collapse = "")
dir.create(file.path(OutdirFinal), recursive = T)

####################################
### Load data
####################################

print("Before matrix reading")
print(Input)
#fullmat.sce<-read10xCounts(samples = Input, col.names = T, type=c("sparse"), version=c("3"))
fullmat.sce<-read10xCounts(samples = Input, col.names = T)
print("After matrix reading")

####################################
### Select barcodes
####################################

print("Before barcodes reading")
if (regexpr("^ALL$", SelectBarcodes, ignore.case = T)[1] == 1) {
  colNamesForNewOutput<-colnames(fullmat.sce)
}else if (is.numeric(SelectBarcodes) == T) {
  colNamesForNewOutput<-colSums(counts(fullmat.sce)) > SelectBarcodes
}else{
  select_bcs.file<-read.table(file = SelectBarcodes, header = F, row.names = 2)
  colNamesForNewOutput<-rownames(select_bcs.file)
}
print("After barcodes reading")

####################################
### Select genes
####################################

if (regexpr("^ALL$", SelectGenes, ignore.case = T)[1] == 1) {
  rowNamesForNewOutput<-rownames(fullmat.sce)
}else if (is.numeric(SelectGenes) == T) {
  rowNamesForNewOutput<-rowSums(counts(fullmat.sce)) > SelectGenes
}else{
  select_genes.file<-read.table(file = SelectGenes, header = F, row.names = 1)
  rowNamesForNewOutput<-rownames(select_genes.file)
}

####################################
### Make new matrix
####################################

print("Before submatrix reading")
submat.sce<-fullmat.sce[rowNamesForNewOutput,colNamesForNewOutput]
print("After submatrix reading")


####################################
### Write output
####################################
print("Before out writing")
write10xCounts(path = OutdirFinal, x = counts(submat.sce) , barcodes=colnames(submat.sce), gene.id=rowData(submat.sce)$ID,
               gene.symbol=rowData(submat.sce)$Symbol, overwrite=T, version=c("3"))
print("After out writing")

####################################
### Report used options
####################################
OutfileOptionsUsed<-paste(Outdir,"/",PrefixOutfiles,".submatrix_from_mtx_UsedOptions.txt", sep="")
TimeOfRun<-format(Sys.time(), "%a %b %d %Y %X")
write(file = OutfileOptionsUsed, x=c(TimeOfRun,"\n","Options used:"))

for (optionInput in option_list) {
  write(file = OutfileOptionsUsed, x=(paste(optionInput@short_flag, optionInput@dest, opt[optionInput@dest], sep="\t", collapse="\t")),append = T)
}

####################################
### Report time used
####################################
EndTimeOverall<-Sys.time()

TookTimeOverall <-format(difftime(EndTimeOverall, StartTimeOverall, units = "secs"))
OutfileCPUusage<-paste(Outdir,"/",PrefixOutfiles,".submatrix_from_mtx_CPUusage.txt", sep="")
ReportTime<-c(
  paste("overall",TookTimeOverall,collapse = "\t")
)

write(file = OutfileCPUusage, x=c(ReportTime))

####################################
### Turning warnings on
####################################
options(warn = oldw)

####################################
### Finish
####################################

print("END - All done!!!")

quit()
