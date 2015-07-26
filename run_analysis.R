## Read in all required data files
wd <- getwd()
filelocation <- paste(wd,"/UCI HAR Dataset",sep="")
testfiles <- paste(wd,"/UCI HAR Dataset/test",sep="")
trainfiles <- paste(wd,"/UCI HAR Dataset/train",sep="")
setwd(testfiles)
testSUBJ <- read.table("subject_test.txt")
testdata <- read.table("X_test.txt")
testAct <- read.table("y_test.txt")
setwd(trainfiles)
trainSUBJ <- read.table("subject_train.txt")
traindata <- read.table("X_train.txt")
trainAct <- read.table("y_train.txt")
setwd(filelocation)
activities <- read.table("activity_labels.txt") 
features <- read.table("features.txt")

## Load the packages necessary for the script
library(dplyr)
library(reshape2)

## Merge all data together and assign column names

## Merge the test and train data sets (Step 1)
data <- rbind(testdata,traindata)
subjects <- rbind(testSUBJ,trainSUBJ)
actnum <-  rbind(testAct,trainAct)

## Add column labels to each data set (Step 4)
colnames(data) <- features[,2]
colnames(subjects) <- "Subject"
colnames(actnum) <- "ActivityNum"

## Combine all data into one set
data <- cbind(subjects,actnum,data)

## Create a new column to lookup the Activity description
## which correlates to the Acitivity number (Step 3)
activities <- rename(activities, Activity=V2)
data <- merge(data,activities,by.x="ActivityNum",by.y="V1")

## Subset the data to only columns displaying the mean or
## standard deviation for each measurement (Step 2)

## Extract only measurements including the mean
means <- data[,grep("mean()",names(data),ignore.case=TRUE,fixed=TRUE)]

## Extract only measurements including the standard deviation
stds <- data[,grep("std()",names(data),ignore.case=TRUE,fixed=TRUE)]

## Extract the first 3 columns of the dataset
info <- data[,c(2,564)]

## Merge all 3 subsets together
newdata <- cbind(info,means,stds)

## Create a second data set with the average of each
## variable for each activity and each subject (step 5)

## Create a tall skinny data set which creates a new row for
## each value of each variable
dataMelt <- melt(newdata,id=c("Subject","Activity"),measure.vars=3:68)

## Summarize the data by the mean for each Activity and Subject
sumData <- dcast(dataMelt, Activity+Subject~variable,mean)
## Make column names valid
newColNames <- make.names(names(sumData),unique=TRUE)
colnames(sumData) <- newColNames



