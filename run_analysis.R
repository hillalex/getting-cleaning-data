#!/usr/bin/env Rscript
library(readr)
library(dplyr)

if (!dir.exists("output-data")) {
  dir.create("output-data")
}

if (!dir.exists("raw-data")) {
  stop("\n The source data is not in place.\n Please refer to the README for instructions.\n ")
}

read_data_file <- function(file_path) {
  read_delim(paste("raw-data", file_path, sep = "/"), delim = " ", col_names = FALSE, trim_ws = TRUE)
}

# merge test and train data
X_test <- read_data_file("test/X_test.txt")
y_test <- read_data_file("test/y_test.txt")

X_train <- read_data_file("train/X_train.txt")
y_train <- read_data_file("train/y_train.txt")

X_total <- rbind(X_test, X_train)
y_total <- rbind(y_test, y_train)

subject_test <- read_data_file("test/subject_test.txt")
subject_train <- read_data_file("train/subject_train.txt")

subject_total <- rbind(subject_test, subject_train)

# extract mean and standard deviation measurements
features <- read_data_file("features.txt")
filtered_features <- features %>%
  filter(grepl("((.*)-mean\\(\\))|((.*)-std\\(\\))", X2))

filtered_feature_cols_vector <- filtered_features[["X1"]]

data <- X_total %>%
  select(all_of(filtered_feature_cols_vector))

# label activities
activity_labels <- read_data_file("activity_labels.txt")
activity_factor <- as.factor(activity_labels[[2]])

y_total_labelled <- y_total %>%
  mutate(activity = as.factor(X1)) %>%
  select(activity)

levels(y_total_labelled[["activity"]]) <- levels(activity_factor)
data <- cbind(y_total_labelled, data)

# add subjects
data <- cbind(subject_total, data)

# add descriptive column names
nicer_names <- gsub("\\(|\\)", "", filtered_features[["X2"]])
names(data) <- c("subject", "activity", nicer_names)

# write data set to file
write.table(data, file = "output-data/data.txt", row.names = FALSE, quote = FALSE)

# calc average of each variable for each activity and subject
averages <- data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

names(averages) <- c("subject", "activity", lapply(nicer_names, function(x) paste("average", x, sep = "_")))

write.table(averages, file = "output-data/averages.txt", row.names = FALSE, quote = FALSE)
