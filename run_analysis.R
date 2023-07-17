##############################################################################
#
# FILE
#   run_analysis.R
#
# OVERVIEW
#   This script makes the tidy data set ("TidyData.txt) suitable to be used
#   for further analysis. Raw data represents Human Activity Recognition 
#   database, that was collected by Reyes-Ortiz et al. (2012) using smartphone
#   (Samsung Galaxy S II) accelerometer and gyroscope sensors.
#   For further details, please, refer to README.md and Codebook.md

library(archive)
library(dplyr)

##############################################################################
# PREPARATORY STEP 1 - Download data
##############################################################################

# Specify file URL
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Check if file exists in directory, otherwise download and unzip it with 
# archive package 
if (!file.exists("UCI HAR Dataset")) { 
        archive_extract(fileurl, dir = "./") 
}

##############################################################################
# PREPARATORY STEP 2 - Read data
##############################################################################

# Select only required files to read
lstfls <- list.files(path = "./", 
                     pattern = "^[Xx]|^[Yy]|^[Ss]ubject|^[Aa]ctivity|features.txt",
                     recursive = TRUE)

# Read files into list applying lapply
names(lstfls) <- paste0("UCI HAR Dataset/", names(lstfls))
listfiles <- lapply(lstfls, read.table)
names(listfiles) <- tolower(lstfls)

##############################################################################
# STEP 1 - Merges the training and the test sets to create one data set.
##############################################################################

# Create features data frame
features <- data.frame(listfiles[grep("features", names(listfiles))])

# Create activities data frame
activities <- data.frame(listfiles[grep("activity", names(listfiles))])

# Create x and y data frames
x <- data.frame(bind_rows(listfiles[grep("/x_", names(listfiles))]))
y <- data.frame(bind_rows(listfiles[grep("/y_", names(listfiles))]))

# Create subject data frame
subject <- data.frame(bind_rows(listfiles[grep("subject_", names(listfiles))]))

# Rename columns in created data frames
names(features) <- c("n","functions")
names(activities) <- c("code", "activity")
names(subject) <- "subject"
names(x) <- features$functions
names(y) <- "code"

# Merge subject y and x sets to create one data set
data_merged <- cbind(subject,y,x)

# Remove unnecessary data frames to save memory
rm(features, subject, x, y)

##############################################################################
# STEP 2 - Extracts only the measurements on the mean and standard deviation
# for each measurement. 
##############################################################################

# Select the measurements on the mean and standard deviation for each
# measurement.
mydata <- select(data_merged, subject, code, contains("mean"), contains("std"))

##############################################################################
# STEP 3 - Uses descriptive activity names to name the activities in the
# data set.
##############################################################################

# Replace activity codes with activity names
mydata$code <- activities[mydata$code, 2]
names(mydata)[2] = "activities"

# Remove unnecessary data frames to save memory
rm(activities)

##############################################################################
# STEP 4 - Appropriately labels the data set with descriptive variable names.
##############################################################################

# Rename column names with descriptive variables
names(mydata)<-gsub("Acc", "Accelerometer", names(mydata))
names(mydata)<-gsub("Gyro", "Gyroscope", names(mydata))
names(mydata)<-gsub("BodyBody", "Body", names(mydata))
names(mydata)<-gsub("Mag", "Magnitude", names(mydata))
names(mydata)<-gsub("^t", "Time", names(mydata))
names(mydata)<-gsub("^f", "Frequency", names(mydata))
names(mydata)<-gsub("tBody", "TimeBody", names(mydata))
names(mydata)<-gsub("-mean()", "Mean", names(mydata), ignore.case = TRUE)
names(mydata)<-gsub("-std()", "STD", names(mydata), ignore.case = TRUE)
names(mydata)<-gsub("-freq()", "Frequency", names(mydata), ignore.case = TRUE)
names(mydata)<-gsub("angle", "Angle", names(mydata))
names(mydata)<-gsub("gravity", "Gravity", names(mydata))
names(mydata)<-gsub("BodyBody", "Body", names(mydata))

##############################################################################
# STEP 5 - From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.
##############################################################################

# Group data and find mean for each group
tidydata <- mydata %>% group_by(subject, activities) %>% 
        summarise_each(funs(mean))

# Create tidy data set
write.table(tidydata, "TidyData.txt", row.name=FALSE, quote = FALSE)