# install required packages if they aren't installed.
if(!require('data.table')) { install.packages('data.table') }
if(!require('plyr')) { install.packages('plyr') }

# load required packages
library(data.table)
library(plyr)

# Helper function to select just the mean and stddev features 
getRequiredFeatures = function(features) {
  grep("-(mean|std)\\(", features[, 'V2'])  
}

# Helper function to make column names friendlier to mere humans 
# (and R users, for that matter)
humanizeNames = function(vectorb) {
  # Replace function names with words and dashes with dots
  lapply(vectorb, function(value) {
    value = gsub('-', '.', value)
    value = gsub('mean\\(\\)', 'Mean', value)
    value = gsub('std\\(\\)', 'StdDev', value)
    
    value
  })
}

mergeAndTidyData = function() {
  # Set up all of the necessary data by reading it in from our data directory
  testValues = read.table("data/X_test.txt")
  testActivities = read.table("data/y_test.txt")
  testSubjects = read.table("data/subject_test.txt")

  trainValues = read.table("data/X_train.txt")
  trainActivities = read.table("data/y_train.txt")
  trainSubjects = read.table("data/subject_train.txt")

  activityLabels = read.table("data/activity_labels.txt")

  features = read.table("data/features.txt", stringsAsFactors=F)

  # Create merged data sets for "test" and "train"
  # (Requirement #1)
  values = rbind(testValues, trainValues)
  activities = rbind(testActivities, trainActivities)
  subjects = rbind(testSubjects, trainSubjects)

  # We only want mean and sd, so extract a vector with those.
  # (Requirement #2)
  requiredFeatures = getRequiredFeatures(features)

  # Select only the required features
  values = values[, requiredFeatures]

  # Get human-readable labels for activity values
  # (Requirement #3)
  activities[, 1] = activityLabels[activities[, 1], 'V2']

  # Make the column names more readable and friendlier to future R-inas and R-inos
  # (Requirement #4)
  names(values) = humanizeNames(features[requiredFeatures, 'V2'])
  names(activities) = "Activity"
  names(subjects) = "Subject"

  # Return the bound data sets (Activity, Subject, and then the data)
  cbind(activities, subjects, values)
}

# calculateMeanData() - Get average of each variable and each subject
# (Requirement #5)
calculateMeanData = function (data) {
  ddply(data, .(Activity, Subject), numcolwise(mean))
}

# runAnalysis() runs the analysis. 
runAnalysis = function() {
  # merge the tables
  tidyData = mergeAndTidyData()

  # compute the means
  meanData = calculateMeanData(tidyData)

  # write the result to disk

  write.table(tidyData, "tidy_dataset.txt", row.names=T)

  write.table(meanData, "computed_means.txt", row.names=F)
}
