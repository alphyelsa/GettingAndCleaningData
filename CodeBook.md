# 1. PreAnalysis:

This script initially set the working directory and download the zip file with the data set. 
The zip file is then extracted to folder UCI HAR Dataset

Per the description of the data set, we have two sets of data. One training set and one test set. Each set has three files.
train.txt - Training set.
subject_train.txt - Identifies the subject who performed the training/test.
y_train.txt - Training labels.

As part of preprocessing, we read each file to a data table.

The variables used in this step are:
X_train : values of variables in train
y_train : activity ID in train
subject_train : subject IDs for train

X_test : values of variables in test
y_test : activity ID in test
subject_test : subject IDs for test


# 2. Merges the training and the test sets to create one data set.
Both test and training sets and combined together. 
The rows of test data are appended beneath the rows of the training data using rbind function.

The variables used in this step are:
x : combined values of variables
y : corresponding activity ID
subject : corresponding subject IDs


# 3. Extracts only the measurements on the mean and standard deviation for each measurement.
The labels of the x dataset are read from features.txt into *x_labels*. From this set, we identify the rows that contain mean or std() in it 
and store that to the *col_list* vector. Only those columns of x are extracted to a new data frame, *data*. 
The names are also set accordingly.

The variables used in this step are:
x_labels : description(label) of each variables in X_test and X_train
col_list : Those labels that have either mean or std() in them.
data     : The resultant data frame containing only mean and standard deviation values.


# 4. Uses descriptive activity names to name the activities in the data set
The activity information is read from activity_labels.txt file into activity_labels. 
This is then merged with the y data set so that each activity observation is now associated with its label. 
Only the description is retained and is added to the dataSet using cbind function. 
Similarly subject is also added to the dataset

The variables used in this step are:
activity_labels : Description of activity IDs in y_test and y_train
activity        : The join of activity id and activity labels.


# 5. Appropriately labels the data set with descriptive variable names.
The column names of data at this point has names like mean() , std() etc. 
The braces associated with the the function are removed.


# 6. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
Group_by function from dplyr package is used here to group the records on each activity and each subject.
The to calculate mean of all values, summarize_all operation is invoked on the grouped data.
The resultant set is written on to file: tidy_data.txt

The variables used in this step are:
new_tidy_set    : The resultant tidy data set.
