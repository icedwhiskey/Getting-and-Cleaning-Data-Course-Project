# **Code Book**

## **Overview**

The `run_analysis.R` script  makes the tidy data set `TidyData.txt` suitable to be used for further analysis. It contains data for  Raw data represents Human Activity Recognition database performed by 30 volunteers within an age bracket of 19-48 years performing six different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). Data was collected by Reyes-Ortiz et al. (2012) using smartphone (Samsung Galaxy S II) accelerometer and gyroscope sensors ([Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)). The `TidyData.txt` data set includes avarage values for accelerometer and gyroscope parameters for each volunteer (`subject`) and `activities`.

## **Process**

The process of running `run_analysis.R` includes 2 preparatory steps and 5 step as described by project's definition. The `dplyr` and `archive` packages were used in this script.

* **Preparatory Step 1** - Download data

1. Specify file URL in `fileurl`
1. Check if `UCI HAR Dataset` exists in directory, otherwise download and unzip it with `archive` package

* **Preparatory Step 2** - Read data

1. Search and select only required files to read by creating list `lstfls`
1. Add "UCI HAR Dataset/" to `lstfls` names to specify path to files in directory
1. Read files into list `listfiles` applying lapply
1. Apply lower case to `listfiles` names
 
* **Step 1** - Merges the training and the test sets to create one data set.

1. Create `features` data frame by searching "features" in `listfiles` names
1. Create `activities` data frame by searching "activity" in `listfiles` names
1. Create `x` and `y` data frames by searching "/x_" and "/y_"" in `listfiles` names
1. Create `subject` data frame by searching "subject_" in `listfiles` names
1. Rename columns in created data frames
1. Merge `subject`, `y` and `x` sets to create one data set `data_merged`
1. Remove unnecessary data frames to save memory
 
* **Step 2** - Extracts only the measurements on the mean and standard deviation for each measurement.

1. Select the measurements on the mean and standard deviation for each measurment in `mydata`
 
* **Step 3** - Uses descriptive activity names to name the activities in the data set.

1. Replace activity codes in `mydata$code` with activity names in `activities` data set
1. Remove `activities` data to save memory
 
* **Step 4** - Appropriately labels the data set with descriptive variable names.

1. Rename column names in `mydata` with descriptive variables
 
* **Step 5** - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. Group `mydata` by `subject` and `activities` and find `mean` for each group
1. Create tidy data set `TidyData.txt`
 
## **Variables**

`TidyData.txt` has following variables:

### Identifiers

* `subject` - The ID of volunteer (test subject)
* `activities` - The type of activity performed

### All variables
 
 ```r
 [1] "subject"                                          
 [2] "activities"                                       
 [3] "TimeBodyAccelerometerMean()-X"                    
 [4] "TimeBodyAccelerometerMean()-Y"                    
 [5] "TimeBodyAccelerometerMean()-Z"                    
 [6] "TimeGravityAccelerometerMean()-X"                 
 [7] "TimeGravityAccelerometerMean()-Y"                 
 [8] "TimeGravityAccelerometerMean()-Z"                 
 [9] "TimeBodyAccelerometerJerkMean()-X"                
[10] "TimeBodyAccelerometerJerkMean()-Y"                
[11] "TimeBodyAccelerometerJerkMean()-Z"                
[12] "TimeBodyGyroscopeMean()-X"                        
[13] "TimeBodyGyroscopeMean()-Y"                        
[14] "TimeBodyGyroscopeMean()-Z"                        
[15] "TimeBodyGyroscopeJerkMean()-X"                    
[16] "TimeBodyGyroscopeJerkMean()-Y"                    
[17] "TimeBodyGyroscopeJerkMean()-Z"                    
[18] "TimeBodyAccelerometerMagnitudeMean()"             
[19] "TimeGravityAccelerometerMagnitudeMean()"          
[20] "TimeBodyAccelerometerJerkMagnitudeMean()"         
[21] "TimeBodyGyroscopeMagnitudeMean()"                 
[22] "TimeBodyGyroscopeJerkMagnitudeMean()"             
[23] "FrequencyBodyAccelerometerMean()-X"               
[24] "FrequencyBodyAccelerometerMean()-Y"               
[25] "FrequencyBodyAccelerometerMean()-Z"               
[26] "FrequencyBodyAccelerometerMeanFreq()-X"           
[27] "FrequencyBodyAccelerometerMeanFreq()-Y"           
[28] "FrequencyBodyAccelerometerMeanFreq()-Z"           
[29] "FrequencyBodyAccelerometerJerkMean()-X"           
[30] "FrequencyBodyAccelerometerJerkMean()-Y"           
[31] "FrequencyBodyAccelerometerJerkMean()-Z"           
[32] "FrequencyBodyAccelerometerJerkMeanFreq()-X"       
[33] "FrequencyBodyAccelerometerJerkMeanFreq()-Y"       
[34] "FrequencyBodyAccelerometerJerkMeanFreq()-Z"       
[35] "FrequencyBodyGyroscopeMean()-X"                   
[36] "FrequencyBodyGyroscopeMean()-Y"                   
[37] "FrequencyBodyGyroscopeMean()-Z"                   
[38] "FrequencyBodyGyroscopeMeanFreq()-X"               
[39] "FrequencyBodyGyroscopeMeanFreq()-Y"               
[40] "FrequencyBodyGyroscopeMeanFreq()-Z"               
[41] "FrequencyBodyAccelerometerMagnitudeMean()"        
[42] "FrequencyBodyAccelerometerMagnitudeMeanFreq()"    
[43] "FrequencyBodyAccelerometerJerkMagnitudeMean()"    
[44] "FrequencyBodyAccelerometerJerkMagnitudeMeanFreq()"
[45] "FrequencyBodyGyroscopeMagnitudeMean()"            
[46] "FrequencyBodyGyroscopeMagnitudeMeanFreq()"        
[47] "FrequencyBodyGyroscopeJerkMagnitudeMean()"        
[48] "FrequencyBodyGyroscopeJerkMagnitudeMeanFreq()"    
[49] "Angle(TimeBodyAccelerometerMean,Gravity)"         
[50] "Angle(TimeBodyAccelerometerJerkMean),GravityMean)"
[51] "Angle(TimeBodyGyroscopeMean,GravityMean)"         
[52] "Angle(TimeBodyGyroscopeJerkMean,GravityMean)"     
[53] "Angle(X,GravityMean)"                             
[54] "Angle(Y,GravityMean)"                             
[55] "Angle(Z,GravityMean)"                             
[56] "TimeBodyAccelerometerSTD()-X"                     
[57] "TimeBodyAccelerometerSTD()-Y"                     
[58] "TimeBodyAccelerometerSTD()-Z"                     
[59] "TimeGravityAccelerometerSTD()-X"                  
[60] "TimeGravityAccelerometerSTD()-Y"                  
[61] "TimeGravityAccelerometerSTD()-Z"                  
[62] "TimeBodyAccelerometerJerkSTD()-X"                 
[63] "TimeBodyAccelerometerJerkSTD()-Y"                 
[64] "TimeBodyAccelerometerJerkSTD()-Z"                 
[65] "TimeBodyGyroscopeSTD()-X"                         
[66] "TimeBodyGyroscopeSTD()-Y"                         
[67] "TimeBodyGyroscopeSTD()-Z"                         
[68] "TimeBodyGyroscopeJerkSTD()-X"                     
[69] "TimeBodyGyroscopeJerkSTD()-Y"                     
[70] "TimeBodyGyroscopeJerkSTD()-Z"                     
[71] "TimeBodyAccelerometerMagnitudeSTD()"              
[72] "TimeGravityAccelerometerMagnitudeSTD()"           
[73] "TimeBodyAccelerometerJerkMagnitudeSTD()"          
[74] "TimeBodyGyroscopeMagnitudeSTD()"                  
[75] "TimeBodyGyroscopeJerkMagnitudeSTD()"              
[76] "FrequencyBodyAccelerometerSTD()-X"                
[77] "FrequencyBodyAccelerometerSTD()-Y"                
[78] "FrequencyBodyAccelerometerSTD()-Z"                
[79] "FrequencyBodyAccelerometerJerkSTD()-X"            
[80] "FrequencyBodyAccelerometerJerkSTD()-Y"            
[81] "FrequencyBodyAccelerometerJerkSTD()-Z"            
[82] "FrequencyBodyGyroscopeSTD()-X"                    
[83] "FrequencyBodyGyroscopeSTD()-Y"                    
[84] "FrequencyBodyGyroscopeSTD()-Z"                    
[85] "FrequencyBodyAccelerometerMagnitudeSTD()"         
[86] "FrequencyBodyAccelerometerJerkMagnitudeSTD()"     
[87] "FrequencyBodyGyroscopeMagnitudeSTD()"             
[88] "FrequencyBodyGyroscopeJerkMagnitudeSTD()" 
```

## **References**

Reyes-Ortiz,Jorge, Anguita,Davide, Ghio,Alessandro, Oneto,Luca, and Parra,Xavier. (2012). Human Activity Recognition Using Smartphones. UCI Machine Learning Repository. [https://doi.org/10.24432/C54S4K](https://doi.org/10.24432/C54S4K).
