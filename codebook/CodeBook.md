## Raw data

The raw data is a dataset collected from accelerometers and gyroscopes from the Samsung Galaxy S smartphone.
 A full description of this dataset is available at the site where the data was obtained:
                                   
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data is included here in the directory `raw-data`, and more can be read about the study 
in `raw-data/README.txt`.

## Tidy data

There are 2 tidy data sets included here in the `output-data` directory:

### data.txt

This dataset contains means and standard deviations of various measurements taken by smartphone accelerometers and gyroscopes from 30 
volunteer subjects engaged in one of 6 activity types:

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING
 
There are 10299 observations (rows) in the dataset.

Each observation (row) in the dataset contains 68 variables. The file `output-data/variables_data.txt` contains the 
complete list of these variables. To interpret these variables:

1. `subject` - an identifier of the volunteer subject
1. `activity` - one of the 6 activity types listed above

variables 3 - 68 identify a particular measurement, the meaning of which 
is described by the file `features_info.txt` (please note `features-info.txt` describes 
a superset of the variables included in this dataset.)

### averages.txt

This dataset takes the mean, for each subject and activity type, of each of the measurements 
described above.
 
As there are 30 subjects and 6 activity types, there are 30 * 6 = 180 observations (rows) in this dataset.

Each observation (row) contains 68 variables. The file `output-data/variables_average.txt` contains 
the complete list of these variables. To interpret these variables:

1. `subject` - an identifier of the volunteer subject
1. `activity` - one of the 6 activity types listed above

variables 3 - 68 refer to the average (mean) for a particular measurement for the given subject and 
activity type. As before, the meaning of each measurement is described by the file `features_info.txt`
(please note `features-info.txt` describes a superset of the variables referenced in this dataset.)

## Recipe

To generate the 2 tidy datasets from the raw data, the script `run_analysis.R` does the following:

1. Recombines test and train data from the raw dataset: reads in the `{}/X_{}.txt`,`{}/y_{}.txt`, and `{}/subject_{}.txt` files from the 
`test` and `train` subdirectories in the raw data directory, and combines these into 3 dataframes
`X_total`, `y_total` and `subject_total`. These dataframes collectively describe the full set of 10299 observations; each observation
containing a vector of measurements (found in `X_total`), an activity type id (found in `y_total`) and a subject id 
(found in `subject_total`).

1. Filters `X_total` to just the measurements we are interested in - means and standard deviations.

1. Combines the table obtained in the previous step with `y_total` to get a single table including both activity types and measurements. Uses the `activity_labels.txt` data in
 the raw data directory to convert the numeric activity types to human readable ones.
 
1. Combines the data obtained in the previous step with `subject_total` to get a single table including
subjects.

1. Writes the new dataset to file at `output-data/data.txt`.

1. Groups the above data by subject and activity type and generates a new table with the mean 
for each group.

1. Writes the data obtained in the previous step to file at `output-data/averages.txt`.
