## Raw data

The raw data is a dataset collected from accelerometers and gyroscopes from the Samsung Galaxy S smartphone.
 A full description of this dataset is available at the site where the data was obtained:
                                   
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

From the original dataset description:
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
>
>  The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Processed data

There are two tidy data sets included here in the `output-data` directory:

### data.txt

This dataset contains means and standard deviations of various measurements taken by smartphone accelerometers and gyroscopes from 30 
volunteer subjects engaged in one of 6 activity types:

* `WALKING`
* `WALKING_UPSTAIRS`
* `WALKING_DOWNSTAIRS`
* `SITTING`
* `STANDING`
* `LAYING`
 
There are 10299 observations (rows) in the dataset.

Each observation (row) in the dataset contains 68 variables. The file [variables_data.txt](variables_data.txt) contains the 
complete list of these variables. To interpret these variables:

1. `subject` - an identifier of the volunteer subject
1. `activity` - one of the 6 activity types listed above

variables 3 - 68 identify a particular measurement, the meaning of which 
is described by the file [variables_info.txt](variables_info.txt) (please note `variables_info.txt` describes 
a superset of the variables included in this dataset.)

### averages.txt

This dataset takes the mean, for each subject and activity type, of each of the measurements 
described above.
 
As there are 30 subjects and 6 activity types, there are 30 * 6 = 180 observations (rows) in this dataset.

Each observation (row) contains 68 variables. The file [variables_average.txt](variables_averages.txt) contains 
the complete list of these variables. To interpret these variables:

1. `subject` - an identifier of the volunteer subject
1. `activity` - one of the 6 activity types listed above

variables 3 - 68 refer to the average (mean) for a particular measurement for the given subject and 
activity type. As before, the meaning of each measurement is described by the file [variables_info.txt](variables_info.txt) 
(please note `variables_info.txt` describes a superset of the variables referenced in this dataset.)

## Recipe

The two datasets described were created by running the [run_analysis.R](../run_analysis.R) script in the 
root directory of this repo using R version 3.6.3 with `readr_1.3.1` and `dplyr_1.0.2` on Ubuntu 18.04.5 LTS (Bionic Beaver).

Before running `run_analysis.R`, the `downloadData.sh` script was run, which imports raw data into a directory named `raw-data`.

The script `run_analysis.R` does the following:

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

1. Writes the new dataset to file at [output-data/data.txt](../output-data/data.txt)

1. Groups the above data by subject and activity type and generates a new table with the mean 
for each group.

1. Writes the data obtained in the previous step to file at [output-data/averages.txt](../output-data/averages.txt)
