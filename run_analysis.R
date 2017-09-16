run_analysis <- function()
{
  library('data.table')
  Xtestset <- read.table('UCI HAR Dataset\\test\\X_test.txt')
  Ytestset <- read.table('UCI HAR Dataset\\test\\Y_test.txt')
  subjecttest <- read.table('UCI HAR Dataset\\test\\subject_test.txt')
  testset <- cbind(Xtestset,subjecttest, Ytestset)
  Xtrainset <- read.table('UCI HAR Dataset\\train\\X_train.txt')
  Ytrainset <- read.table('UCI HAR Dataset\\train\\Y_train.txt')
  subjecttrain <- read.table('UCI HAR Dataset\\train\\subject_train.txt')
  trainset <- cbind(Xtrainset, subjecttrain, Ytrainset)
  completeSet <- rbind(testset,trainset)
  features <- readLines('UCI HAR Dataset\\features.txt')
  features <- c(features,'Subject','Activity')
  names(completeSet) <- features
  Significantfeatures <- c(grep('mean\\(\\)-|std\\(\\)|mean\\(\\)',features),562,563)
  completeSet <- completeSet[,Significantfeatures]
  activityLabels <- read.table('UCI HAR Dataset\\activity_labels.txt')
  completeSet$Activity <-  activityLabels[completeSet$Activity,2]
  names(completeSet) = c("tbodyaccmeanX","tbodyaccmeanY","tbodyaccmeanZ","tbodyaccstdX","tbodyaccstdY","tbodyaccstdZ","tgravityaccmeanX","tgravityaccmeanY","tgravityaccmeanY","tgravityaccstdX","tgravityaccstdY","tgravityaccstdZ","tbodyaccjerkmeanX","tbodyaccjerkmeanY","tbodyaccjerkmeanZ","tbodyaccjerkstdX","tbodyaccjerkstdY","tbodyaccjerkstdZ","tbodygyromeanX","tbodygyromeanY","tbodygyromeanZ","tbodygyrostdX","tbodygyrostdY","tbodygyrostdZ","tbodygyrojerkmeanX","tbodygyrojerkmeanY","tbodygyrojerkmeanZ","tbodygyrojerkstdX","tbodygyrojerkstdY","tbodygyrojerkstdZ","tbodyaccmagmean","tbodyaccmagstd","tgravityaccmagmean","tgravityaccmagstd","tbodyaccjerkmagmean","tbodyaccjerkmagstd",
              "tbodygyromagmean","tbodygyromagstd","tbodygyrojerkmagmean","tbodygyrojerkmagstd","fbodyaccmeanX","fbodyaccmeanY","fbodyaccmeanZ","fbodyaccstdX","fbodyaccstdY","fbodyaccstdZ","fbodyaccjerkmeanX","fbodyaccjerkmeanY","fbodyaccjerkmeanZ","fbodyaccjerkstdX","fbodyaccjerkstdY","fbodyaccjerkstdZ","fbodygyromeanX","fbodygyromeanY","fbodygyromeanZ","fbodygyrostdX","fbodygyrostdY","fbodygyrostdZ","fbodyaccmagmean","fbodyaccmagstd","fbodybodyaccjerkmagmean","fbodybodyaccjerkmagstd","fbodybodygyromagmean","fbodybodygyromagstd","fbodybodygyrojerkmean","fbodybodygyrojerkstd","Subject","Activity")
  setDT(completeSet)
  averagedset <- completeSet[,lapply(.SD,mean),by = c("Activity","Subject")]
  write.table(averagedset,file = "tidyData.txt",row.name=FALSE) 
 }