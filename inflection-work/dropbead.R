####################################
### Javier Diaz - javier.diazmejia@gmail.com
### Script to obtain a knee-plot and its inflection
###
####################################

####################################
### Required libraries
####################################
### 'optparse'   to handle one-line-commands
### 'dropbead'   to generate the knee-plot and get inflection. Install with:
###              library(devtools)
###              install_github("rajewsky-lab/dropbead")
####################################

suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(dropbead))

####################################
### Get inputs from command line arguments
####################################

option_list <- list(
  make_option(c("-i", "--infile"), default="NA",
              help="A path/name to either a <tab> delimited *file* with number of reads per barcode, like:
              #INPUT=/path_to_file/file.bam  TAG=XC FILTER_PCR...
              203177  CTTATGGCTTTA
              196369  TTAGCGCTTATA
              151561  CGGCTGCTAATC
              Presumably produced by Dropseq-tools 'BAMTagHistogram'"),
  #   
  make_option(c("-p", "--prefix_outfiles"), default="NA",
              help="A prefix for outfile names, e.g. your project ID")

)

opt <- parse_args(OptionParser(option_list=option_list))

Infile          <- opt$infile
#Outdir          <- opt$outdir
PrefixOutfiles  <- opt$prefix_outfiles
#Tempdir         <- "~/temp" ## Using this for temporary storage of outfiles because sometimes long paths of outdirectories casuse R to leave outfiles unfinished
Tempdir         <- "DROPBEAD"

MaxNumberOfCells <- 30000 ### Note this parameter may change the inflection point


StartTimeOverall<-Sys.time()

####################################
### Check that mandatory parameters are not 'NA' (default)
####################################

ListMandatory<-list("infile", "outdir", "prefix_outfiles")
for (param in ListMandatory) {
  if (length(grep('^NA$',opt[[param]], perl = T))) {
    stop(paste("Parameter -", param, " can't be 'NA' (default). Use option -h for help.", sep = "", collapse = ""))
  }
}

####################################
### Create outdirs and get path of files
### Basically replacing any '~/' by the User HOME, because otherwise it conflicts with system(...)
####################################
#writeLines("\n*** Create outdirs ***\n")
#CommandsToGetUserHomeDirectory<-("eval echo \"~$USER\"")
#UserHomeDirectory<-system(command = CommandsToGetUserHomeDirectory, input = NULL, wait = T, intern = T)
#
#Outdir<-gsub("^~/",paste(c(UserHomeDirectory,"/"), sep = "", collapse = ""), Outdir)
#Tempdir<-gsub("^~/",paste(c(UserHomeDirectory,"/"), sep = "", collapse = ""), Tempdir)
#Outdir<-gsub("/$", "", Outdir)
#Tempdir<-gsub("/$", "", Tempdir)
#
#Infile<-gsub("^~/",paste(c(UserHomeDirectory,"/"), sep = "", collapse = ""), Infile)
#
#dir.create(file.path(Outdir),   showWarnings = F, recursive = T)
dir.create(file.path(Tempdir),  showWarnings = F, recursive = T)

OutPdf<-paste(Tempdir,"/", PrefixOutfiles, ".kneeplot.pdf",collapse="",sep="")
OutInf<-paste(Tempdir,"/", PrefixOutfiles, ".kneeplot_inflection.txt",collapse="",sep="")

####################################
### Load read-counts per cell data and get knee-plot
####################################
InfileTab <- Infile 
print(paste("Start reading table of read-counts from:",InfileTab))

mat<-as.data.frame(read.table(InfileTab,header=F))
pdf(OutPdf)
plotCumulativeFractionOfReads(mat, cutoff = MaxNumberOfCells, draw.knee.point = TRUE)
dev.off()
InflectionPoint<-estimateCellNumber(mat[, 1], max.cells = MaxNumberOfCells)
write(file=OutInf,x=InflectionPoint)

####################################
### Report used options
####################################
OutfileOptionsUsed<-paste(Tempdir,"/",PrefixOutfiles,".kneeplot_UsedOptions.txt", sep="")
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

OutfileCPUusage<-paste(Tempdir,"/",PrefixOutfiles,".kneeplot_CPUusage.txt", sep="")
ReportTime<-c(
  paste("overall",TookTimeOverall,collapse = "\t")
)

write(file = OutfileCPUusage, x=c(ReportTime))

####################################
### Moving outfiles into outdir
####################################

#outfiles_to_move <- list.files(Tempdir,pattern = c(paste(PrefixOutfiles, ".kneeplot", sep=""), paste(PrefixOutfiles, ".reads_per_barcode.tsv", sep="")), full.names = F)
#sapply(outfiles_to_move,FUN=function(eachFile){
#  file.copy(from=paste(Tempdir,"/",eachFile,sep=""),to=paste(Outdir,"/",eachFile,sep=""),overwrite=T)
#  file.remove(paste(Tempdir,"/",eachFile,sep=""))
#})

####################################
### Finish
####################################

print("END - All done!!!")
quit()
