##load X_test,Y_test,X_train,Y_train
X_test <- read.table("G:/R_code/data/UCI HAR Dataset/test/X_test.txt", quote="\"")
X_train <- read.table("G:/R_code/data/UCI HAR Dataset/train/X_train.txt", quote="\"")
Y_test <- read.table("G:/R_code/data/UCI HAR Dataset/test/Y_test.txt", quote="\"")
Y_train <- read.table("G:/R_code/data/UCI HAR Dataset/train/Y_train.txt", quote="\"")

## combine X_test and Y_test to XY_test, X_train and Y_train to XY_train
XY_train<- cbind (Y_train,X_train)
XY_test<-cbind(Y_test,X_test)

##merge XY_train and XY_test to XY_test_train
XY_test_train <- rbind(XY_test,XY_train)

##rename the XY_test_train 's colnames 
colnames(XY_test_train) <- c("number",colnames(XY_test_train[2:562]))

##load activity_labels and merge activity_labels and XY_test_train to XY2_test_train
activity_labels <- read.table("G:/R_code/data/UCI HAR Dataset/activity_labels.txt", quote="\"")
XY2_test_train <- merge.data.frame(x=XY_test_train,y=activity_labels,by.x="number",by.y="V1",sort=F)

##rename the XY2_test_train's colnames
features <- read.table("G:/R_code/data/UCI HAR Dataset/features.txt", quote="\"")
colnames(XY2_test_train) <- c("Activity_ID",as.character(features$V2),"Activity_labels")

## put the labels_names to col 2 
XY3_test_train <- XY2_test_train[,c(1,563,2:562)]

## sorting mean and std
meanstd <-grep("std()|mean()",features$V2)
meanstd2 <- meanstd[c(-47,-48,-49,-57,-58,-65,-66,-67,-70,-73,-76,-79)]
meanstd3 <-c(1,2,meanstd2+c(2))
XY4_test_train <- XY3_test_train[,meanstd3]

#make new data set for average per vaiaable per subject
mean <- tapply(XY4_test_train[,3],XY4_test_train$Activity_ID,mean)
for (i in 4:69){
  m<-tapply(XY4_test_train[,i],XY4_test_train$Activity_ID,mean)
  mean <- cbind(mean,m)
}
#add colnames and rownames
colnamesmean <-colnames(XY4_test_train[3:69])
colnames(mean) <-colnamesmean
rownames(mean) <- activity_labels$V2

write.table(XY4_test_train, "c:/tidydata1.txt", sep="\t")
write.table(mean, "c:/tidydatamean.txt", sep="\t")