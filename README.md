# Getting and Cleaning Data Course Project

## This file is explains the working of  run_analysis.R

**Pre-Requisites:**

1.Download the datasets from - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2.Extract the files in a folder

3.It is data collected from the accelerometers from the Samsung Galaxy S smart phone

4.Study details - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


**Steps to Do:**

1.Copy the root folder where above data has been extracted, and convert the "\" in path to "/" if required

2.replace the value of Variable "dataDir" defined in the beginning of the script

3.use source("run_analysis.R") command in RStudio, to execute the script


**Script working**

1.The script will read files present in the directory - X_train.txt,y_train.txt,X_test.txt,y_test.txt,subject_train.txt,subject_test.txt

2.It will merge corresponding files for Testing data and Training data to create complete dataset

3.it will pick the column names from features.txt and will assign it to "X" dataset

4.it will pick the Activity names from activity_labels.txt and will assign it to "y" dataset

5.The script will add string "subject" to Subject dataset having integer values to make it more descriptive

6.All above 3 datasets will be combined to form one dataset

7.The above created dataset gets aggregated with function "mean" and grouped on "subjects", & "activities"

8.The machine generated column names gets replaced with descriptive column names 

9.Our Final dataset is ready

10.This dataset is written as text file in Space delimited as well as TAB delimited files.



* - Ramakant Shankar *






