---
title: "README"
author: "Steve Bond"
date: "August 17, 2015"
output: html_document
---
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps to produce project:

Run code in run_analysis.R file.  

This file will check for and, if not existant, download the Human Activity
Recognition Using Smartphones Data Set (HARUSD) as a subdirectory of your current
working directory.

It will then unzip the file, read the data tables into appropriate variables and
then merge the training and test data into 1 table.

It will then set names to the variable columns and merge the columns to get the 
the data frame "combineddata".

Then it will extract the mean and std for each measurement.  It will then assign
descriptive activity labels by factorizing the acticity in the dataframe
"combineddata" with the descritptive names.

Then it will appropriately label the data table

with descriptive variable names as follows:
# the t prefix replaced by time
# Gyro is replaced by Gyroscope
# Acc is replaced by Accelerometer
# f prefix replaced by frequency
# Mag is replaced by Magnitude
# BodyBody is replaced by Body

Lastly, it will create a new tidy data set with the ave/mean of each variable
for each activity and subject.  The new tidy data set will be created in a file
named "tidydata.txt".  The tidydata.txt file contains 1 variable per column and 1
observation per row.  The Codebook.md file contains a
description of each variable column.