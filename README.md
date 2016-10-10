# Project description project
The `tidyDaset.txt` file included in this repository was produced for the Coursera Course Project, "Getting and Cleaning Data". The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

# Data set information
`tidyDataset.txt` is a blended data set that contains the average mean and average standard deviation of measurements summarized by activityID and subjectID fetched from data stored into [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
A full description of data collected from the accelerometers is available at the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

# Data set content
* `tidyDaset.txt` contains 181 rows by 69 columns 
* Header row is included
* Columns are white space delimited

## Columns of tidyDaset.txt
Here a brief description of columns of `tidyDaset.txt`

* 1st column - activityID
* 2nd column - activityName
* 3rd column - subjectID
* 4th - 69th columns - Average of the specific mean or standard deviation of the original measurements  for each activity and each subject

For a more detailed description of measurement columns see [CodeBook.md](https://github.com/crossbow/GettingAndCleaningDataProject/blob/master/CodeBook.md) included in current repository.

# Original data set
Original data set can be found at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

# How to produce tidy data set
In order to produce `tidyDataset.txt` you need [R](https://www.r-project.org/) installed on your computer. From R current working directory
execute  the `run_analysis.R` script included in current repository. For example, from R prompt you can type:
```
source("run_analysis.R")
```  
The script writes a file named `tidyDataset.txt` into `data` folder inside R current working directory. The script has been verified on R version 3.3.1 (2016-06-21) -- "Bug in Your Hair" - Platform: x86_64-apple-darwin13.4.0 (64-bit)

# Files used to produce tidy data set
From the original data set, `run_analysis.R` script unzip the following files only:

* "UCI HAR Dataset/activity_labels.txt"
* "UCI HAR Dataset/features.txt"
* "UCI HAR Dataset/train/subject_train.txt"
* "UCI HAR Dataset/train/y_train.txt"
* "UCI HAR Dataset/train/X_train.txt"
* "UCI HAR Dataset/test/subject_test.txt"
* "UCI HAR Dataset/test/y_test.txt"
* "UCI HAR Dataset/test/X_test.txt"

Files are stored into a folder named `data` inside R current working directory

# Description of run_analysis.R
`run_analysis.R` performs the following steps:

1. Downloads and unzip original dataset from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names.
6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject
7. Writes the data set created in step 6 into a file named `tidyDataset.txt`
