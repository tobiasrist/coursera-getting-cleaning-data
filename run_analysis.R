## Check for source data and unzip if necessary
if (!file.exists("UCI HAR Dataset")) {
  if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
    stop("Was expecting HAR Dataset folder or zip file in the working directory. Please use the get_data.R script to load the necessary data to execute this script.")
  } else {
    unzip("getdata_projectfiles_UCI HAR Dataset.zip")
  }
}

## Load the dataset
subjectsTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
activitiesTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
featuresTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
subjectsTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
activitiesTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
featuresTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")

## Load the labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
names(activityLabels) <- c("activityID", "activityName")
featureLabels <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

## Combine the input data into one common dataframe
test <- cbind(subjectsTest, activitiesTest, featuresTest)
train <- cbind(subjectsTrain, activitiesTrain, featuresTrain)
data <- rbind(test, train)
names(data)[1:2] <- c("subjectID", "activityID")

## Extract the relevant features (means & std deviations) from featureLabels
means <- grep("mean\\(\\)", featureLabels[, 2])
meanFreqs <- grep("meanFreq\\(\\)", featureLabels[, 2])
stds <- grep("std\\(\\)", featureLabels[, 2])
relevantFeatures <- sort(c(means, meanFreqs, stds, 555:561))  ## featureLabels 555:561 also represent mean values, as per the input data description

## Clean up & apply labels for the relevant features
relevantFeatureLabels <- featureLabels[relevantFeatures, 2]
relevantFeatureLabels <- sub("mean", "Mean", relevantFeatureLabels)
relevantFeatureLabels <- sub("std", "Std", relevantFeatureLabels)
relevantFeatureLabels <- sub("gravity", "Gravity", relevantFeatureLabels)
relevantFeatureLabels <- sub("\\(t", "T", relevantFeatureLabels)
relevantFeatureLabels <- gsub("-", "", relevantFeatureLabels)
relevantFeatureLabels <- gsub(",", "", relevantFeatureLabels)
relevantFeatureLabels <- gsub("\\(|\\)", "", relevantFeatureLabels)
names(data)[relevantFeatures + 2] <- relevantFeatureLabels

## Clean up activity labels
activityLabels[, 2] <- tolower(activityLabels[, 2])
activityLabels[, 2] <- sub("_d", "D", activityLabels[, 2])
activityLabels[, 2] <- sub("_u", "U", activityLabels[, 2])

## Merge activity labels to the full data set
data <- merge(data, activityLabels)

## Create a reduced dataset to work with from here
reducedData <- data[, c(2, ncol(data), relevantFeatures + 2)]

## Create the second tidy data set, calculating the means of all activities per subject and activity type
tidy <- aggregate(reducedData[, 3:ncol(reducedData)], by = reducedData[, 1:2], FUN = mean)
tidy <- tidy[order(tidy[, 1], tidy[, 2]), ]
row.names(tidy) <- 1:nrow(tidy)

## Write the result files to subdirectory "Output"
if (!file.exists("Output")) {dir.create("Output")}
write.table(tidy, "./Output/tidy.txt")
