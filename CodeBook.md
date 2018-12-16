# CodeBook for the tidy dataset (Getting and Cleaning Data Course Project)

## Data source

The data for this project can be obtained here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This dataset represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## About the Data set
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain

## About the R code

### Step 1: Read the test and training set data
The objective here is to read the test and training data tables into R. Four basic level data sets will be defined and created:
* test data set
* train data set
* features data set
* activity labels data set

### Step 2: Create column names for the test and training tables
The objective here is to assign column names to the test and training tables. At this stage the data sets have been created with the right coloumn names.
Names of 561 table variables are stored in features.txt

### Step 3: Merge test and train tables
The outcome of this step is to create the main data table by merging both test and train tables

### Step 4: Extract only measurements on the mean and standard deviation
First the grepl function is used to search column names and return logical vector (TRUE/FALSE) of matched elements.
Then the subset of table columns has been created to get the required dataset.

### Step 5: Create tidy data set
The tidy data set contains the average of all variables for each activity and subject. This step involves:
* Aggregation of data by using aggregate function
* Sorting of data by subjectID, activityID
* Cleaning of variable names to remove "()" and "-", and to capitalize the first letters of "mean" and "std"

### Step 6: Save tidy data set
Write the ouput to a text file: tidyDataset.txt
