run_analysis.R does the process of cleaning the dataset as described in Course Project instructions.

1.We download the dataset and extract the UCI HAR Dataset.
2.We include "reshape" library and we read in the tables activity_labels and features into "activityLabels" and "features" variable.
3.Then we change the datatype of 2nd column to character type.
4.From features we extract the observations which have mean and standard devition in reading.
5.Then we clean the data by substituting.
6.Read the training and test datasets and merge them.
7.Convert the columns type into factor type.
8.The cleaned dataset of 180 rows, 88 columns present in combinedData.mean is written into "tidy_data.txt".

The column  names of tidy_data are the different activities mentioned in activity_labels and the observations correspond to means of each variable for each activity and each subject.