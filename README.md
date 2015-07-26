# Getting and Cleaning Data Course Project

## run_Analysis.R Description
This script will load the required data sets provided in the UCI HAR Dataset into R for processing. The output of this script is a tidy data set summarizing the averages of the data by activity and subject for select mean and standard deviation variables.

## Before running the script
 - Save the UCI HAR Dataset to your working directory
 - Install the R packages "dplyr" and "reshape 2". Loading these libraries is included in the script
 
## What the script does
1. Reads in all required data files
2. Loads the packages necessary for executing the script (dplyr and reshape2)
3. Merges the measurements, subjects, and activity numbers data sets for train and test (Step 1 of the assignment) condensing the original 6 files to 3 datasets using an rbind
4. Adds column labels to each dataset, using the provided features dataset as the labels for the measurements data
5. Combines the 3 datasets into one with the subjects and activity numbers in the front followed by the measurements using a cbind
6. Renames the second column of the provided activities dataset to "Activity Name" for clarity after merging
7. Creates a new column to contain activity descriptions by looking up the associated number in the provided activities dataset using the merge function
8. Create a subset of the data to only include column names containing the word "mean" using the grep function to search for this string
9. Create a subset of the data to only include column names containing the word "std" using the grep function to search for this string
10. Create a subset of the data to include the first and last columns of the dataset (Subject and Activty)
11. Merge the three subsets together using cbind to produce a new data frame including only Subject, Activity, and the mean and standard deviation variables
12. Create a tall skinny dataset using the melt function where each value for each variable becomes it's own row
13. Summarize the data into a new table using the dcast function to display the average across each variable by Activity and by Subject producing the final tidy data set

## Summary of final tidy data set
180 observations of 68 variables