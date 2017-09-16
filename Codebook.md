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
