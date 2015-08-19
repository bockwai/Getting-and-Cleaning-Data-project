#Create the Directory for downloading .zip in WD if it doesnt exist
if (!file.exists("./Coursera/HARUSD")) {
  dir.create("./Coursera/HARUSD")
}
# File URL to download
harusdurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(harusdurl,destfile = "./HARUSD/dataset.zip")

#Unzip the file
unzip(zipfile = "./HARUSD/dataset.zip",exdir = "./HARUSD")
path_rf <- file.path("./HARUSD", "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)

#Read the data tables into the following variables
activitytestdata  = read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
activitytraindata = read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
subjecttraindata = read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
subjecttestdata  = read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
featurestestdata  = read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
featurestraindata = read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

#1 merge the training and test data sets into one, first by rows
subjectdata <- rbind(subjecttraindata, subjecttestdata)
activitydata <- rbind(activitytraindata, activitytestdata)
featuresdata <- rbind(featurestraindata, featurestestdata)

#2 set names to variables
names(subjectdata) = c("subject")
names(activitydata) = c("activity")
featuresnamesdata = read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(featuresdata) = featuresnamesdata$V2

#3 merge columns to get the data frame combineddata
mergesubjectactivity = cbind(subjectdata,activitydata)
combineddata = cbind(featuresdata,mergesubjectactivity)

#4 extract only measurements of mean & std for each measurement
featuresnamessubdata = featuresnamesdata$V2[grep("mean\\(\\)|std\\(\\)", featuresnamesdata$V2)]
selectednames = c(as.character(featuresnamessubdata),"subject","activity")
combineddata = subset(combineddata,select=selectednames)

#5 use descriptive activity names to name activities in the data set
#by first loading the descriptive list of acticity names in the order
#of activity ids 1 to 6.
activitylabels = read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

#factorize the activity in data frame "combineddata" using descriptive activity names
combineddata$activity = factor(combineddata$activity);
combineddata$activity = factor(combineddata$activity,labels=as.character(activitylabels$V2))

#6 Appropriately labels data set with descriptive variable names
# the t prefix replaced by time
# Gyro is replaced by Gyroscope
# Acc is replaced by Accelerometer
# f prefix replaced by frequency
# Mag is replaced by Magnitude
# BodyBody is replaced by Body


names(combineddata) = gsub("^t", "time", names(combineddata))
names(combineddata) = gsub("Gyro", "Gyroscope", names(combineddata))
names(combineddata) = gsub("Acc", "Accelerometer", names(combineddata))
names(combineddata) = gsub("^f", "frequency", names(combineddata))
names(combineddata) = gsub("Mag", "Magnitude", names(combineddata))
names(combineddata) = gsub("BodyBody", "Body", names(combineddata))

#7 create a 2nd independent tidy data set with the ave of each variable for
# each activity and subject

library(plyr)
combineddata2 = aggregate(. ~subject + activity, combineddata, mean)
combineddata2 = combineddata2[order(combineddata2$subject,combineddata2$activity),]
write.table(combineddata2, file = "tidydata.txt",row.name=FALSE)