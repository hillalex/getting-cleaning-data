#!/bin/bash
set -ex

wget https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip -O temp.zip
unzip temp.zip
rm temp.zip

mv 'UCI HAR Dataset' raw-data
