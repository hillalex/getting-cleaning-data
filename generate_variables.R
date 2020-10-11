#!/usr/bin/env Rscript
library(readr)
library(dplyr)

variables_data <- names(read_table("output-data/data.txt", n_max = 0))
variables_averages <- names(read_table("output-data/averages.txt", n_max = 0))

write.table(variables_data, file = "codebook/variables_data.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(variables_averages, file = "codebook/variables_averages.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)
