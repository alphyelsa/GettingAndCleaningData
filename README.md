# Getting And Cleaning Data

Contents
This repository is my assignment for course Getting and Cleaning Data. 
The task is to create a tidy data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In detail, We should create one R script called run_analysis.R that does the following.
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
