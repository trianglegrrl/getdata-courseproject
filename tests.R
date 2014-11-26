# Unit tests for run_analysis.R
# http://en.wikipedia.org/wiki/Unit_testing
#
# Unit tests are a way to say "given these inputs/stimuli,
# I expect my code to give me this outputs/behaviours".
#
# For example, in R, consider that I have a function called
# `add(x, y)` that returns the sum of `x` and `y`. If you
# called it as `add(1, 4)`, you would expect it to return `5`.
# So then you write a test for it, which is basically:
#
#     result = add(1, 4)
#     if(result != 5 ) { abort(paste("I expected 5 but got ", result) }
#
# ...except we are using RUnit, which lets us condense that to an uglier
# but more useful:
#
#     result = add(1, 4)
#     checkTrue(result == 5)
#
# If `add(1, 4)` doesn't return `5`, it means the function is broken, and
# you should go back to fix it.
#
# It doesn't seem like a big deal with a function like this, but consider
# that you had a more complicated function. If you are changing something
# in that function, one small mistake could cascade through other parts
# of your program. Unit tests help you identify a problem and fix it before
# you roll your code out for people to use and grants to fund.

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
  features = read.table("fixtures/features.txt", stringsAsFactors=F)

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