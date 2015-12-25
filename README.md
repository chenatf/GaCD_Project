### Load the dplyr library.
### Load the tidyr library.
##Read the dataset and stored in the data frame format.
### features: List of all features.
### activity_labels: Links the class labels with their activity name.
### X_train: Training set.
### y_train: Training labels.
### X_test: Test set.
### y_test: Test labels.
### subject_train: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
### subject_test: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
###The data into a suitable for "dplyr" library data frame format.
##Naming the columns of data.
##Remove duplicate column.
###Transfer X_test to remove duplicate rows, then transpose.(removing the X_test duplicate column)
###Transfer X_train to remove duplicate rows, then transpose.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
###Select test set column containing “mean()” into X_test_std.
###Select test set column containing “std()” into X_test_std.
###Combined subject_test, y_test, X_test_mean X_test_std to as test_set according to column.
###Delete X_test_mean and X_test_std.
###Select train set column containing “mean()” into X_train_std.
###Select train set column containing “std()” into X_train_std.
###Combined subject_train, y_train, X_train_mean X_train_std to as train_set according to column.
###Delete X_train_mean and X_train_std.
###Merges the training and the test sets to create one data set.
###Merging test_set and train_set to create one data set called data_set in rows.
### sort data_set in the order of the subject,the same subject value in the order of activity_labels.
##Uses descriptive activity names to name the activities in the data set.
###Merging data_set and activity_labels in the same column name.(the same column name is activity_labels)
###Delete activity_labels columns in data_set.
##Appropriately labels the data set with descriptive variable names. 
###Delete "()" in the data_set column names.
###Delete "-mean" in the data_set column names.
###Replace "-" to "_" in the data_set column names.
###The data_set from tBodyAcc_X to fBodyBodyGyroJerkMag column,the column names as the values of the features,the values as the values of the mean.

