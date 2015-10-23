rm(list=ls())

library(reshape2)

sourceFilename <- "UCIHARDataset.zip"
tidyFilename <- "tidyDataSet.txt"

## Download UCI HAR dataset from provided link
if (!file.exists(sourceFilename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, sourceFilename)
}

## Unzip the downloaded dataset
if (!file.exists("UCI HAR Dataset")) { 
  unzip(sourceFilename) 
}

## Extract the needed features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
featuresNeeded <- grep(".*mean.*|.*std.*", features[,2])

## Appropriate naming of variables in data set
featureNames <- features[featuresNeeded,2]
featureNames <- gsub('-mean', 'Mean', featureNames)
featureNames <- gsub('-std', 'Std', featureNames)
featureNames <- gsub('[-()]', '', featureNames)

## Load individual training activities and bind them
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainingActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainingSet <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresNeeded]
trainingSet <- cbind(trainingSubjects, trainingActivities, trainingSet)

## Load individual test activities and bind them
testingSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testingActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testingSet <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresNeeded]
testingSet <- cbind(testingSubjects, testingActivities, testingSet)

## Bind training and testing datasets
completeSet <- rbind(trainingSet, testingSet)

## Include normalized feature names in complete data set
colnames(completeSet) <- c("subject", "activity", featureNames)

## Extract activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

## Convert subject to factor for melting
completeSet$subject <- as.factor(completeSet$subject)

## Convert activities to factor for melting
completeSet$activity <- factor(completeSet$activity, levels = activityLabels[,1], labels = activityLabels[,2])

completeMeltedSet <- melt(completeSet, id = c("subject", "activity"))
completeMeanSet <- dcast(completeMeltedSet, subject + activity ~ variable, mean)

## Write the tidy data
write.table(completeMeanSet, tidyFilename, row.names = FALSE, quote = FALSE)



