Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are:
We will include only mean and std for our analysis

mean(): Mean value
std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is below in serial order: 
"tbodyaccmeanX","tbodyaccmeanY","tbodyaccmeanZ","tbodyaccstdX","tbodyaccstdY","tbodyaccstdZ","tgravityaccmeanX","tgravityaccmeanY","tgravityaccmeanY","tgravityaccstdX","tgravityaccstdY","tgravityaccstdZ","tbodyaccjerkmeanX","tbodyaccjerkmeanY","tbodyaccjerkmeanZ","tbodyaccjerkstdX","tbodyaccjerkstdY","tbodyaccjerkstdZ","tbodygyromeanX","tbodygyromeanY","tbodygyromeanZ","tbodygyrostdX","tbodygyrostdY","tbodygyrostdZ","tbodygyrojerkmeanX","tbodygyrojerkmeanY","tbodygyrojerkmeanZ","tbodygyrojerkstdX","tbodygyrojerkstdY","tbodygyrojerkstdZ","tbodyaccmagmean","tbodyaccmagstd","tgravityaccmagmean","tgravityaccmagstd","tbodyaccjerkmagmean","tbodyaccjerkmagstd",            "tbodygyromagmean","tbodygyromagstd","tbodygyrojerkmagmean","tbodygyrojerkmagstd","fbodyaccmeanX","fbodyaccmeanY","fbodyaccmeanZ","fbodyaccstdX","fbodyaccstdY","fbodyaccstdZ","fbodyaccjerkmeanX","fbodyaccjerkmeanY","fbodyaccjerkmeanZ","fbodyaccjerkstdX","fbodyaccjerkstdY","fbodyaccjerkstdZ","fbodygyromeanX","fbodygyromeanY","fbodygyromeanZ","fbodygyrostdX","fbodygyrostdY","fbodygyrostdZ","fbodyaccmagmean","fbodyaccmagstd","fbodybodyaccjerkmagmean","fbodybodyaccjerkmagstd","fbodybodygyromagmean","fbodybodygyromagstd","fbodybodygyrojerkmean","fbodybodygyrojerkstd","Subject","Activity"

We will use below steps to reformat the data.

1. Combine the test set with labels and subjects into one dataframe. 
     
  ```
   Xtestset <- read.table('UCI HAR Dataset\\test\\X_test.txt')
   Ytestset <- read.table('UCI HAR Dataset\\test\\Y_test.txt')
   subjecttest <- read.table('UCI HAR Dataset\\test\\subject_test.txt')
   testset <- cbind(Xtestset,subjecttest, Ytestset)  
   
  ```  
  
  2.Same goes for the training set
  
      ```
      Xtrainset <- read.table('UCI HAR Dataset\\train\\X_train.txt')
      Ytrainset <- read.table('UCI HAR Dataset\\train\\Y_train.txt')
      subjecttrain <- read.table('UCI HAR Dataset\\train\\subject_train.txt')
      trainset <- cbind(Xtrainset, subjecttrain, Ytrainset)
      
      ```
      
3. Now merge the two sets into one 

      ```
      
      completeSet <- rbind(testset,trainset)
      
      ```
      
4. Add feature names to the merged data frame from feature info and retain on mean and std variables

        ```
         features <- readLines('UCI HAR Dataset\\features.txt')
         features <- c(features,'Subject','Activity')
          names(completeSet) <- features
          Significantfeatures <- c(grep('mean\\(\\)-|std\\(\\)|mean\\(\\)',features),562,563)
         completeSet <- completeSet[,Significantfeatures]
         
        ```
5. Replace activity code with activty labels from activity.txt and change variable names 

   ```
   activityLabels <- read.table('UCI HAR Dataset\\activity_labels.txt')
  completeSet$Activity <-  activityLabels[completeSet$Activity,2]
   names(completeSet) =       c("tbodyaccmeanX","tbodyaccmeanY","tbodyaccmeanZ","tbodyaccstdX","tbodyaccstdY","tbodyaccstdZ","tgravityaccmeanX","tgravityaccmeanY","tgravityaccmeanY","tgravityaccstdX","tgravityaccstdY","tgravityaccstdZ","tbodyaccjerkmeanX","tbodyaccjerkmeanY","tbodyaccjerkmeanZ","tbodyaccjerkstdX","tbodyaccjerkstdY","tbodyaccjerkstdZ","tbodygyromeanX","tbodygyromeanY","tbodygyromeanZ","tbodygyrostdX","tbodygyrostdY","tbodygyrostdZ","tbodygyrojerkmeanX","tbodygyrojerkmeanY","tbodygyrojerkmeanZ","tbodygyrojerkstdX","tbodygyrojerkstdY","tbodygyrojerkstdZ","tbodyaccmagmean","tbodyaccmagstd","tgravityaccmagmean","tgravityaccmagstd","tbodyaccjerkmagmean","tbodyaccjerkmagstd",           "tbodygyromagmean","tbodygyromagstd","tbodygyrojerkmagmean","tbodygyrojerkmagstd","fbodyaccmeanX","fbodyaccmeanY","fbodyaccmeanZ","fbodyaccstdX","fbodyaccstdY","fbodyaccstdZ","fbodyaccjerkmeanX","fbodyaccjerkmeanY","fbodyaccjerkmeanZ","fbodyaccjerkstdX","fbodyaccjerkstdY","fbodyaccjerkstdZ","fbodygyromeanX","fbodygyromeanY","fbodygyromeanZ","fbodygyrostdX","fbodygyrostdY","fbodygyrostdZ","fbodyaccmagmean","fbodyaccmagstd","fbodybodyaccjerkmagmean","fbodybodyaccjerkmagstd","fbodybodygyromagmean","fbodybodygyromagstd","fbodybodygyrojerkmean","fbodybodygyrojerkstd","Subject","Activity")
   
   ```
   
 6. Make another tidy dataset to show mean for all variables by activity and   
 person.
 
       ```
        setDT(completeSet)
  averagedset <- completeSet[,lapply(.SD,mean),by = c("Activity","Subject")]       
  
       ````
