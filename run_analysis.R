##load library reshape which helps in shaping dataset
library(reshape2)


##load activity_labels.txt and features.txt then subset it to get the column with values

activityLabels <- read.table("activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("features.txt")
features[,2] <- as.character(features[,2])


#grep() is used to get only the data of mean and std. deviation as asked
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)


##load all training datasets
train <- read.table("./train/X_train.txt")[featuresWanted]
trainActivities <- read.table("./train/Y_train.txt")
trainSubjects <- read.table("./train/subject_train.txt")
##combine all training data
train <- cbind(trainSubjects, trainActivities, train)
##load all test dataset
test <- read.table("./test/X_test.txt")[featuresWanted]
testActivities <- read.table("./test/Y_test.txt")
testSubjects <- read.table("./test/subject_test.txt")
##combine all test data
test <- cbind(testSubjects, testActivities, test)


##Combine training and test data and changing the column names
combinedData <- rbind(train, test)
colnames(combinedData) <- c("subject", "activity", featuresWanted.names)

##Convert the datatype of variables into factor 
combinedData$activity <- factor(combinedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
combinedData$subject <- as.factor(combinedData$subject)
combinedData.melted <- melt(combinedData, id = c("subject", "activity"))
combinedData.mean <- dcast(combinedData.melted, subject + activity ~ variable, mean)


##Our data is cleaned, now store tidy data in a new text file
write.table(combinedData.mean, "tidy_data.txt", row.names=FALSE, quote=FALSE)