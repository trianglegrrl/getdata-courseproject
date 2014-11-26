# Unit tests for run_analysis.R

if(!require('RUnit')) { install.packages('RUnit') }
if(!require('GetoptLong')) { install.packages('GetoptLong') }
if(!require('data.table')) { install.packages('data.table') }
if(!require('dplyr')) { install.packages('dplyr') }

# Load necessary packages
library(RUnit) # Unit testing
library(GetoptLong) # Interpolated strings
library(data.table) # Friendly data.frame interface
library(dplyr) # Best package evah

source('run_analysis.R')

test.getRequiredFeatures = function() {
  # Load fixture data
  features = read.table("examples/fixtures/features.txt", stringsAsFactors=F)

  required = features[getRequiredFeatures(features),'V2']

  # Should include a std() feature
  count = length(match("fBodyBodyGyroMag-std()", required))
  checkTrue(count == 1)

  # Should include a mean() feature
  count = length(match("fBodyBodyGyroMag-mean()", required))
  checkTrue(count == 1)

  # Should not include a feature that is in the file but isn't std() or mean()
  count = match("fBodyBodyAccJerkMag-kurtosis()", required)
  checkTrue(is.na(count))
}

test.humanizeNames = function() {
  givenNames = c('a-name', 'really-mean()', 'std()-thing')
  expectedNames = as.list(c('a.name', 'really.Mean', 'StdDev.thing'))

  results = humanizeNames(givenNames)

  # All three of the given names should be translated to the new format
  # and should match the expectedNames
  numberOfMatchingResults = length(intersect(expectedNames, results))
  checkTrue(numberOfMatchingResults == length(expectedNames))
}

#### PENDING TESTS ####

test.calculateMeanData = function() {
  warning("test.calculateMeanData is pending. You still need to write this test.")
}

test.runAnalysis = function() {
  warning("test.runAnalysis is pending. You still need to write this test.")
}

test.mergeAndTidyData = function() {
  warning("test.mergeAndTidyData is pending. Don't even think about writing this without refactoring into smaller methods.")
}
