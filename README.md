# Getting And Cleaning Data

This repository is my assignment for course Getting and Cleaning Data. 
The task is to create a tidy data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Task Description:
We should create one R script called run_analysis.R that does the following.
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This repo contains the following files.
1. run_analysis.R - R scrip to perform analysis
2. CodeBook.md - document that describes the variables, data, and transformations

About run_analysis script:
This script uses the plyr and dplyr libraries. If the data files for this project is not in your working directory, the script will automatically donwnload it to the working directory and then unzip it.
Once the data is available, the script performs steps 1 to 5 on the data and produces a tidy data set.

# 1. PreAnalysis:

This script initially set the working directory and download the zip file with the data set. 
The zip file is then extracted to folder UCI HAR Dataset

Per the description of the data set, we have two sets of data. One training set and one test set. Each set has three files. As part of preprocessing, we read each file to a data table.  


# 2. Merges the training and the test sets to create one data set.
Both test and training sets and combined together. 
The rows of test data are appended beneath the rows of the training data using rbind function.


# 3. Extracts only the measurements on the mean and standard deviation for each measurement.
The labels of the x dataset are read from features.txt into *x_labels*. From this set, we identify the rows that contain mean or std() in it and store that to the *col_list* vector. Only those columns of x are extracted to a new data frame, *data*. The names are also set accordingly.


# 4. Uses descriptive activity names to name the activities in the data set
The activity information is read from activity_labels.txt file into activity_labels. 
This is then merged with the y data set so that each activity observation is now associated with its label. 
Only the description is retained and is added to the dataSet using cbind function. 
Similarly subject is also added to the dataset


# 5. Appropriately labels the data set with descriptive variable names.
The column names of data at this point has names like mean() , std() etc. 
The braces associated with the the function are removed.

# 6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Group_by function from dplyr package is used here to group the records on each activity and each subject.
The to calculate mean of all values, summarize_all operation is invoked on the grouped data.
The resultant set is written on to file: tidy_data.txt
