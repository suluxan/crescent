#!/bin/bash

awk -v var="$(cat example.kneeplot_inflection.txt)" '$1 >= var {print}' possorted_genome_reads_per_barcode.tsv > filtered.tsv

