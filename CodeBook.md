X_test  :read file from "UCI HAR Dataset/test/X_test.txt"
X_train :read file from "UCI HAR Dataset/train/X_train.txt"
Y_test  :read file from "UCI HAR Dataset/test/Y_test.txt"
Y_train :read file from "UCI HAR Dataset/train/Y_train.txt"

XY_train : combine Y_train and X_train
XY_test  : combine Y_test and X_test

XY_test_train : combine XY_test and XY_train

activity_labels : read file from "UCI HAR Dataset/activity_labels.txt"
XY2_test_train  : match and merge XY2_test_train and activity_labels by activity id 

features  : read file from "UCI HAR Dataset/features.txt"

XY3_test_train  : change the col order from XY2_test_train 

meanstd <-
