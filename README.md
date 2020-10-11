# Coursera "Getting and Cleaning Data" Course Project

Submission for the "Getting and Cleaning Data" end of course project.

This repo contains two tidy data sets:
1. `output-data/data.txt`
1. `output-data/averages.txt`

It also contains three scripts used to download raw data, generate the above datasets, and generate 
some metadata about the variables in the datasets, respectively:
1. `downloadData.sh`
1. `run_analysis.R` 
1. `generate_variables.R`

And a CodeBook describing the data:
1. `CodeBook.md`

See [CodeBook.md](codebook/CodeBook.md) for details.

## To regenerate the datasets from scratch
1. Requires `R`, including the `readr` and `dpylr` packages.
1. To obtain the raw data, run `./downloadData.sh` (on Linux.) Alternatively, manually download the zipped data
from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), and unzip into 
a folder in this directory called `raw-data`.
1. Run `./run-analysis.R`. Note that this script *will not run unless the previous step has been executed*.
See [CodeBook.md](codebook/CodeBook.md) for details about this script and the resulting data sets.
1. To generate lists of variables included in the datasets, run `./generate_variables.R`.
