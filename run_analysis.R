# -------------------------------------------------------------------------------------------- 
# Here are the data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
# =======================================================================

library(plyr)
library(dplyr)

# Set the working directory
setwd("D:\\DataScience\\CourseEra\\03.GettingAndCleaningData\\Project")

# Download the zip file and extract to folder
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("UCIdata.zip")){
  download.file(url,"UCIdata.zip", mode = "wb")
}
unzip("UCIdata.zip", files = NULL, exdir=".")

# Read the data from training set
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# Read the data from test set
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

#####################################################################
## 1. Merges the training and the test sets to create one data set.
#####################################################################
x <- rbind(x_train, x_test)
subject <- rbind(subject_train, subject_test)
y <- rbind(y_train, y_test)

#############################################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#############################################################################################

#2a. Get the labels of the x dataset from features.txt
x_labels <- read.table("UCI HAR Dataset/features.txt")

#2b. Get the rows that contain mean or std() in it
col_list <- grep("mean()|std()", x_labels[, 2])

#2c. Extract those columns from the dataset x
data <- x[, col_list]

#2d. Set the column names accordingly.
names(data) <- x_labels[col_list,2]

############################################################################
## 3. Uses descriptive activity names to name the activities in the data set
############################################################################

#3a. Read the activity labels from the activity_labels.txt file
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

#3b. Merge the y data set with activity_labels so that each activity number is associated with its label
activity <- join(y,activity_labels, by="V1")

#3c. Only keep the labels of the activity in the data set and keep label as "Activity"
activity$V1 <- NULL
names(activity) <- c("Activity")

#3d. Append the activity list to the original data set.
data <- cbind(activity, data)

#3e. Similarly append the person details to the data set
names(subject) <- c("Subject")
data <- cbind(subject, data)

##############################################################################
## 4. Appropriately labels the data set with descriptive variable names.
##############################################################################
names(data) <- sapply(names(data), function(x) {gsub("[()]", "",x)})

##############################################################################
## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.
##############################################################################
new_tidy_set <- data %>%group_by(Subject, Activity) %>% summarise_all("mean")
write.table(new_tidy_set, "tidy_data.txt", sep = ",")