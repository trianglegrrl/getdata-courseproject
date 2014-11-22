# INPUT DATA SET

This is the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The site describes it as:

> Abstract: Human Activity Recognition database built from the 
> recordings of 30 subjects performing activities of daily living (ADL) 
> while carrying a waist-mounted smartphone with embedded inertial 
> sensors.

Details on how the data were acquired and recorded can be found in `data/README.txt`.

# Feature Selection 

A description of these features is available in `features.txt`. I subset the data to only grab the mean and standard deviation values for each of the different sensors. 

More details about the sensor measurements can be found in the `features.txt`. 

The mean and standard deviation for each of these features is included:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

# OUTPUT DATA SETS

We create two output data sets.

The first is `tidy_dataset.txt`, which includes human- and R-programmer-friendly column names. The details of the features are in `features.txt`.

The second is `computed_means.txt`, which proides the means for each of the values, subset by subject (i.e. study participant) and activity (a movement state). The data set defines the following activities:

* 1 WALKING
* 2 WALKING_UPSTAIRS
* 3 WALKING_DOWNSTAIRS
* 4 SITTING
* 5 STANDING
* 6 LAYING
