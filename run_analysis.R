#
# Getting and Cleaning Data Course Project
#

# Download dataset into working directory
workingdirectory <- getwd()
zipfile <- "getdata_projectfiles_UCI HAR Dataset.zip"
destfile <- file.path(workingdirectory, zipfile)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(destfile)) {
    download.file(url, destfile = destfile, method = "curl") # Linux and Mac OS X only
    # download.file(url, destfile = destfile) # Windows only
}

# Unzip needed files only
datafolder <- "data"
files <- c("UCI HAR Dataset/activity_labels.txt", "UCI HAR Dataset/features.txt", "UCI HAR Dataset/train/subject_train.txt", "UCI HAR Dataset/train/y_train.txt", "UCI HAR Dataset/train/X_train.txt", "UCI HAR Dataset/test/subject_test.txt", "UCI HAR Dataset/test/y_test.txt", "UCI HAR Dataset/test/X_test.txt")
unzip(destfile, files = files, junkpaths = TRUE, exdir = datafolder)

# 1. Merges the training and the test sets to create one data set.

# Subjects setup
trainSubjectsFile <- file.path(workingdirectory, datafolder, "subject_train.txt")
trainSubjects <- read.table(trainSubjectsFile, col.names="subjectID")
testSubjectsFile <- file.path(workingdirectory, datafolder, "subject_test.txt")
testSubjects <- read.table(testSubjectsFile, col.names="subjectID")
subjects <-rbind(trainSubjects, testSubjects)

# Activities setup
trainActivitiesFile <- file.path(workingdirectory, datafolder, "y_train.txt")
trainActivities <- read.table(trainActivitiesFile, col.names="activityID")
testActivitiesFile <- file.path(workingdirectory, datafolder, "y_test.txt")
testActivities <- read.table(testActivitiesFile, col.names="activityID")
activities <-rbind(trainActivities, testActivities)

# Features setup
featuresFile <- file.path(workingdirectory, datafolder, "features.txt")
features <- read.table(featuresFile, col.names = c("featureID", "featureName"))

# Sanitize column names
features$featureName <-gsub("\\-", "_", features$featureName)
features$featureName <-gsub("\\(", "_", features$featureName)
features$featureName <-gsub("\\)", "_", features$featureName)
features$featureName <-gsub("\\,", "_", features$featureName)

# Measurements setup
trainMeasurementsFile <- file.path(workingdirectory, datafolder, "X_train.txt")
trainMeasurements <- read.table(trainMeasurementsFile, col.names = features$featureName)
testMeasurementsFile <- file.path(workingdirectory, datafolder, "X_test.txt")
testMeasurements <- read.table(testMeasurementsFile, col.names = features$featureName)
measurements <-rbind(trainMeasurements, testMeasurements)

# Compose one dataset setup
completeDataset <- cbind(subjects, activities, measurements)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
columnsMeanStd <- grep("_mean__|_std__", colnames(completeDataset))
partialDataset <- completeDataset[ , c(1, 2, columnsMeanStd)]

# 3. Uses descriptive activity names to name the activities in the data set
activityLabelsFile <- file.path(workingdirectory, datafolder, "activity_labels.txt")
activityLabels <- read.table(activityLabelsFile, col.names=c("activityID", "activityName"), header=F)
partialDataset <- merge(activityLabels, partialDataset, by="activityID")

# 4. Appropriately labels the data set with descriptive variable names.
names(partialDataset) <- gsub("__", "\\(\\)", names(partialDataset))
names(partialDataset) <- sub("^t", "Time", names(partialDataset))
names(partialDataset) <- sub("^f", "Freqdomain", names(partialDataset))
names(partialDataset) <- sub("Acc", "Acceleration", names(partialDataset))
names(partialDataset) <- sub("Gyro", "Gyroscope", names(partialDataset))
names(partialDataset) <- sub("Mag", "Magnitude", names(partialDataset))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyDataset <- aggregate(partialDataset[,4:ncol(partialDataset)], by = list(activityName = partialDataset$activityName, subjectID = partialDataset$subjectID, activityID = partialDataset$activityID), FUN=mean, na.rm=TRUE)

# Arrange first three columns in the same order of previous dataset and apply a meaningful description to computed columns
tidyDataset <- tidyDataset[, c(3,1,2,4:ncol(tidyDataset))]
avgHeaders <- lapply(names(tidyDataset[4:ncol(tidyDataset)]), function (x) paste(c('Average_',x), collapse="") )
newHeaders <- c("activityID", "activityName", "subjectID", avgHeaders)
colnames(tidyDataset) <- newHeaders

# Write dataset into a file
tidyDatasetFile <- file.path(workingdirectory, datafolder, "tidyDataset.txt")
write.table(tidyDataset, file=tidyDatasetFile, row.name=FALSE)

msg <- paste0("tidyDataset is available in ",tidyDatasetFile)
cat(msg)
