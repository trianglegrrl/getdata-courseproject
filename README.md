# getdata-009-courseproject

Solution to the [Getting and Cleaning Data](https://class.coursera.org/getdata-009/) course project.

Sensored by Alaina Hardie, @trianglegrrl

### This repo includes the following files:

* This README
* `CODEBOOK.md`, a code book for the source and tidied data set
* Data from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
* These data are tidied by the `runAnalysis()` function (and its helper functions) in `run_analysis.R` and it creates two data sets.
* The two data sets, the contents of which are described in `CODEBOOK.md`: `tidy_dataset.txt` and `computed_means.txt`. 

### run_analysis.R

This script performs the following functions:

1. Tidy and organize the dataset
 * Read the raw data
 * Merge the raw test and training data sets
 * Select only the mean and standard deviation values
 * Turn the activity values from numbers into human-readable text
 * Create column labels that are friendlier to humans (and hopefully R users, too)
 * Generate a tidy data set

2. Write a data set that computes the means of the values by activity and subject
 * Use `ddply()` because it allows me to this in the simplest, most straightforward way possible.