X_test  :read file from "UCI HAR Dataset/test/X_test.txt"
X_train :read file from "UCI HAR Dataset/train/X_train.txt"
Y_test  :read file from "UCI HAR Dataset/test/Y_test.txt"
Y_train :read file from "UCI HAR Dataset/train/Y_train.txt"
subject_test :read file from "UCI HAR Dataset/test/subject_test.txt"
subject_train:read file from "UCI HAR Dataset/subject_train.txt"

features  : read file from "UCI HAR Dataset/features.txt"

XY_train : combine subject_train,Y_train ,and X_train
XY_test  : combine subject_test, Y_test, and X_test

XY_test_train : combine XY_test and XY_train

meanstd  : the location of the std and mean in features$V2
meanstd2 : delete the item with meanFreq
meanstd3 : c(1,2,meanstd2+c(2))
XY2_test_train : the data only with mean() and std()

activity_labels : read file from "UCI HAR Dataset/activity_labels.txt"
XY2_test_train : add activity labels names in data

XY3_test_train : reorder the col 

XY4_test_train : delete the label names
XY5_test_train : ndependent tidy data set with the average of each variable for each activity and each subject. 
XY6_test_train : add labels names back

XY7_test_train : reorder the tidy data
