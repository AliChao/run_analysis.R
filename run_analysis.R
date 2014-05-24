## 1.Merges the training and the test sets to create one data set.
##load X_test,Y_test,X_train,Y_train,subject_test,subject_train
X_test <- read.table("G:/R_code/data/UCI HAR Dataset/test/X_test.txt", quote="\"")
X_train <- read.table("G:/R_code/data/UCI HAR Dataset/train/X_train.txt", quote="\"")
Y_test <- read.table("G:/R_code/data/UCI HAR Dataset/test/Y_test.txt", quote="\"")
Y_train <- read.table("G:/R_code/data/UCI HAR Dataset/train/Y_train.txt", quote="\"")
subject_test <- read.table("G:/R_code/data/UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("G:/R_code/data/UCI HAR Dataset/train/subject_train.txt", quote="\"")

##change the colnames 
features <- read.table("G:/R_code/data/UCI HAR Dataset/features.txt", quote="\"")
colnames(X_test) <- c(as.character(features$V2))
colnames(X_train) <- c(as.character(features$V2))
colnames(Y_test) <- c("labels_ID")
colnames(Y_train) <- c("labels_ID")
colnames(subject_test) <-c ("subject")
colnames(subject_train) <-c ("subject")

## combine X_test and Y_test to XY_test, X_train and Y_train to XY_train
XY_test<-cbind(subject_test,Y_test,X_test)
XY_train<- cbind (subject_train,Y_train,X_train)

##merge XY_train and XY_test to XY_test_train
XY_test_train <- rbind(XY_test,XY_train)

## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
## sorting mean and std
meanstd <-grep("std()|mean()",features$V2)
meanstd2 <- meanstd[c(-47,-48,-49,-57,-58,-65,-66,-67,-70,-73,-76,-79)]
meanstd3 <-c(1,2,meanstd2+c(2))
XY2_test_train <- XY_test_train[,meanstd3]

## 3.Uses descriptive activity names to name the activities in 
##the data set(have done in stage 1)

## 4.Appropriately labels the data set with descriptive activity names. 
##load activity_labels and merge activity_labels and XY2_test_train to XY2_test_train
activity_labels <- read.table("G:/R_code/data/UCI HAR Dataset/activity_labels.txt", quote="\"")
colnames(activity_labels) <- c("labels_ID","Activity_labels")
XY2_test_train <- merge.data.frame(x=XY2_test_train,y=activity_labels,by.x="labels_ID",by.y="labels_ID",sort=F)

## put the labels_names to col 2 
XY3_test_train <- XY2_test_train[,c(1,70,2,3:69)]

## 5. Creates a second, independent tidy data set with the
##average of each variable for each activity and each subject. 
## delete the labels_names 
XY4_test_train <- XY3_test_train[,c(1,3:70)] 
XY5_test_train <-aggregate(XY4_test_train[,c(3:69)],by=list(labels_ID=XY4_test_train$labels_ID,subject=XY4_test_train$subject),FUN=mean)

## add the labels_names back  
XY6_test_train <-merge.data.frame(x=activity_labels,y=XY5_test_train,by.x="labels_ID",by.y="labels_ID",sort=F)

## order the tidy data 
XY7_test_train <-XY6_test_train[order(XY6_test_train$labels_ID,XY6_test_train$subject),]
rownames(XY7_test_train) <-c()

#outcome
write.table(XY3_test_train, "c:/tidydata1.txt", sep="\t")
write.table(XY7_test_train, "c:/tidydatamean.txt", sep="\t")