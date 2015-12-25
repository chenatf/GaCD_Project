library(dplyr)
library(tidyr)

features<-read.table("./UCI HAR Dataset/features.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

features<-tbl_df(features)
activity_labels<-tbl_df(activity_labels)
X_test<-tbl_df(X_test)
y_test<-tbl_df(y_test)
subject_test<-tbl_df(subject_test)
X_train<-tbl_df(X_train)
y_train<-tbl_df(y_train)
subject_train<-tbl_df(subject_train)

names(X_test)<-features$V2
names(X_train)<-features$V2
names(y_test)<-"activity_labels"
names(y_train)<-"activity_labels"
names(subject_test)<-"subject"
names(subject_train)<-"subject"
names(activity_labels)<-c("activity_labels","activities")

X_test<-as.data.frame(t(X_test))
X_test<-unique(X_test)
X_test<-as.data.frame(t(X_test))
X_train<-as.data.frame(t(X_train))
X_train<-unique(X_train)
X_train<-as.data.frame(t(X_train))

X_test_mean<-select(X_test,contains("mean()"))
X_test_std<-select(X_test,contains("std()"))
test_set<-bind_cols(subject_test,y_test,X_test_mean,X_test_std)
rm("X_test_mean");rm("X_test_std")
X_train_mean<-select(X_train,contains("mean()"))
X_train_std<-select(X_train,contains("std()"))
train_set<-bind_cols(subject_train,y_train,X_train_mean,X_train_std)
rm("X_train_mean");rm("X_train_std")

data_set<-bind_rows(test_set,train_set)
data_set<-arrange(data_set,subject,activity_labels)

data_set<-inner_join(data_set,activity_labels)
data_set<-select(data_set,-activity_labels)

names(data_set)<-sub("()","",names(data_set),fixed = TRUE)
names(data_set)<-gsub("-mean","",names(data_set),fixed = TRUE)
names(data_set)<-gsub("-","_",names(data_set),fixed = TRUE)
data_set<-gather(data_set,features,mean,tBodyAcc_X:fBodyBodyGyroJerkMag)
names(data_set)<-gsub("_std","",names(data_set),fixed = TRUE)
data_set<-gather(data_set,features,std,tBodyAcc_X:fBodyBodyGyroJerkMag)
data_set[,5]<-NULL

data_set_groups<-group_by(data_set,subject,activities,features)
data_set_tidy<-summarise(data_set_groups,mean=mean(mean),std=mean(std))

write.table(data_set_tidy,"./data_set_tidy.txt",row.names = FALSE)