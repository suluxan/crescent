oldw <- getOption("warn")
options( warn = -1 )

library(optparse)

####################################
### Get inputs from command line argumets
####################################
#
option_list <- list(
  make_option(c("-i", "--inflection_point"), default="NA"),
  #
  make_option(c("-b", "--barcodes"), default="NA")
  )

opt <- parse_args(OptionParser(option_list=option_list))

Inflection            <- opt$inflection_point
Barcodes              <- opt$barcodes


a <- read.csv(file = Inflection, sep = "\t", header = F)

b <- read.csv(file = Barcodes, sep = "\t", header = F, comment.char = "#")

c <- b[b$V1 > a$V1, ]


write.table(c, file = "filtered_inflection_final.tsv", sep = "\t", quote = F, row.names = F, col.names = F)
