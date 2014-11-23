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

# Helper function to convert numbered activities to their
# human-readable labels
getLabeledActivities = function(activities, activityLabels) {
  # Convert to data.tables to get access to setkey()
  workingActivities = data.table(activities)
  workingActivityLabels = data.table(activityLabels)

  # Select the key columns
  setkey(workingActivities, 'V1')
  setkey(workingActivityLabels, 'V1')

  # Return the column with readable labels
  workingActivities[workingActivityLabels, 'V2']
}

# mergeAndTidyData() - Get and create the merged data and name them properly
# 
# This is an ugly function. I would try to refactor it if I had more time, 
# but its ugliness is sequential and step-by-step, so it should be easy to
# follow.
mergeAndTidyData = function() {
  # Set up all of the necessary data by reading it in from our data directory
  testValues = read.table("data/X_test.txt")
  testActivities = read.table("data/y_test.txt")
  subjectTest = read.table("data/subject_test.txt")

  trainValues = read.table("data/X_train.txt")
  trainActivities = read.table("data/y_train.txt")
  subjectTrain = read.table("data/subject_train.txt")

  activityLabels = read.table("data/activity_labels.txt")

  features = read.table("data/features.txt", stringsAsFactors=F)

  # Create merged data sets for "test" and "train"
  # (Requirement #1)
  values = rbind(testValues, trainValues)
  activities = rbind(testActivities, trainActivities)
  subjects = rbind(subjectTest, subjectTrain)

  # We only want mean and sd, so extract a vector with those.
  # (Requirement #2)
  requiredFeatures = getRequiredFeatures(features)

  # Select only the required features
  values = values[, requiredFeatures]

  # Get human-readable labels for activity values
  # (Requirement #3)
  cleanedActivities = getLabeledActivities(activities, activityLabels)

  # Make the column names more readable and friendlier to future R-inas and R-inos
  # (Requirement #4)
  names(values) = humanizeNames(features[requiredFeatures, 'V2'])
  names(cleanedActivities) = "Activity"
  names(subjects) = "Subject"

  # Return the bound data sets (Activity, Subject, and then the data)
  cbind(cleanedActivities, subjects, values)
}

# calculateMeanData() - Get average of each variable and each subject
# (Requirement #5)
calculateMeanData = function (data) {
  # ddply is very, very cool.
  # http://www.inside-r.org/packages/cran/plyr/docs/ddply

  # Split the frame by subject and activity, compute the means on the
  # numeric columns, recombine into a frame, and then return that frame.
  # It's split/apply/combine, but in a single function.
  ddply(data, 
    .(Subject, Activity), 
    function(cols) { 
      numericCols = sapply(cols, is.numeric)

      colMeans(cols[, numericCols])
    }
  )
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
