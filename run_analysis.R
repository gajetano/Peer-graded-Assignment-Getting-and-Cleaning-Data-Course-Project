# READ DATA
#==========
# Construct path to the data
pathdata = file.path("./UCI HAR Dataset")
# Read training tables
xtrain = read.table(file.path(pathdata, "train", "X_train.txt"), header = FALSE)
ytrain = read.table(file.path(pathdata, "train", "y_train.txt"), header = FALSE)
subject_train = read.table(file.path(pathdata, "train", "subject_train.txt"), header = FALSE)
#Read testing tables
xtest = read.table(file.path(pathdata, "test", "X_test.txt"), header = FALSE)
ytest = read.table(file.path(pathdata, "test", "y_test.txt"), header = FALSE)
subject_test = read.table(file.path(pathdata, "test", "subject_test.txt"), header = FALSE)
#Read features and activity labels data
features = read.table(file.path(pathdata, "features.txt"), header = FALSE)
activityLabels = read.table(file.path(pathdata, "activity_labels.txt"), header = FALSE)

# LABEL DATA
#===========
#Create column Values for the training tables
colnames(xtrain) = features[, 2]
colnames(ytrain) = "activityId"
colnames(subject_train) = "subjectId"
#Create column Values for the testing tables
colnames(xtest) = features[, 2]
colnames(ytest) = "activityId"
colnames(subject_test) = "subjectId"
#Create column values for the activity labels and features
colnames(activityLabels) <- c('activityId','activityType')
colnames(features) <- c('featureId','featureType')

# MERGE TEST AND TRAIN TABLES
#============================
mergeTrain = cbind(ytrain, subject_train, xtrain)
mergeTest = cbind(ytest, subject_test, xtest)
mergeAll = rbind(mergeTrain, mergeTest)

# EXTRACT ONLY MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION
#=============================================================
colNames = colnames(mergeAll)
# mean_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
mean_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("-(mean|std)\\(", colNames))
MeanAndStd = mergeAll[, mean_std]

# MERGE DESCRIPTIVE ACTIVITY NAMES
#=================================
MeanAndStd = merge(MeanAndStd, activityLabels, by='activityId', all.x=TRUE)

# CREATE TIDY DATA SET (AGGREGATION, SORTING, CLEANING VARIABLE NAMES)
#=====================================================================
# Aggregation
tidyDataset = aggregate(. ~subjectId + activityId + activityType, MeanAndStd, mean)
# Sorting
tidyDataset = tidyDataset[order(tidyDataset$subjectId, tidyDataset$activityId),]
# Cleaning variable names
cnames = colnames(tidyDataset)
newcnames = gsub('mean\\()', "Mean", cnames, ignore.case = TRUE)
newcnames = gsub('std\\()', "Std", newcnames, ignore.case = TRUE)
newcnames = gsub("-", "", newcnames, ignore.case = TRUE)
newcnames = gsub("BodyBody", "Body", newcnames, ignore.case = TRUE)
colnames(tidyDataset) = newcnames

# SAVE TIDY DATA SET
#===================
write.table(tidyDataset, file.path(pathdata, "tidyDataset.txt"), row.name=FALSE)

