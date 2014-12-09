# getdata-courseproject

Solution to the [Getting and Cleaning Data](https://class.coursera.org/getdata-009/) course project.

Sensored by Alaina Hardie, @trianglegrrl

### This repo includes the following files:

* This README
* `CODEBOOK.md`, a code book for the source and tidied data set
* `tests.R`; running `source('tests.R')` will run the unit tests and report results
* `examples/TESTING_README.md` tells you why you should write unit tests.
* `examples/runit.*` - the actual unit tests
* `examples/fixtures/*`, fixture data for the unit tests
* `data/*`, data from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
* `run_analysis.R`, the main code for the program
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
 * Write the tidy set to disk

2. Write a data set that computes the means of the values by activity and subject
 * Divide the tidy data set by Subject and Activity
 * Calculate means for remaining columns
 * Write the resulting table of means to disk
