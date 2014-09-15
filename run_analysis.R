## -------------------------------------------------------------------------------------------------- ##
#  Ramakant Shankar
#  Getting and Cleaning Data : Course Project
#  Script name : run_analysis.R  
#  Source Data : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#  data collected from the accelerometers from the Samsung Galaxy S smart phone
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## -------------------------------------------------------------------------------------------------- ##
#	"run_analysis.R" that does the following tasks:
#		1.Merges the training and the test sets to create one data set.
#		2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#		3.Uses descriptive activity names to name the activities in the data set
#		4.Appropriately labels the data set with descriptive variable names. 
#		5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## -------------------------------------------------------------------------------------------------- ##


## -------------------------------------------------------------------------------------------------- ##
#  Reading data - the data has already been downloaded and extracted
## -------------------------------------------------------------------------------------------------- ##

	# Defining Root Data directory
		dataDir <- "C:/Users/rshankar/Desktop/Coursera/Getting and Cleaning Data/Assignment/UCI HAR Dataset"

	# Define x & y dataset paths for Test & Train 
		xTrain <- paste(dataDir, "/train/X_train.txt",sep="")
		yTrain <- paste(dataDir, "/train/y_train.txt",sep="")
		xTest  <- paste(dataDir, "/test/X_Test.txt",sep="")
		yTest  <- paste(dataDir, "/test/y_Test.txt",sep="")

	# Define Dataset paths for Subject
		subjectTrain <- paste(dataDir, "/train/subject_train.txt",sep="")
		subjectTest  <- paste(dataDir, "/test/subject_test.txt",sep="")

	# Define dataset Paths for features and activities
		features <- paste(dataDir, "/features.txt", sep="")
		activityLabels <- paste(dataDir, "/activity_labels.txt", sep="")

	# Load data from the files
		xTrainData <- read.table(xTrain)
		yTrainData <- read.table(yTrain)
		xTestData  <- read.table(xTest)
		yTestData  <- read.table(yTest)
		
		featuresData       <- read.table(features)
		activityLabelsData <- read.table(activityLabels)
		
		subjectTrainData   <- read.table(subjectTrain)
		subjectTestData    <- read.table(subjectTest)

## -------------------------------------------------------------------------------------------------- ##
#  Merges the training and the test sets to create one data set & Labels the columns 
## -------------------------------------------------------------------------------------------------- ##		
		
	# Assign columns names of "x" data from features data
		names(xTrainData) <- featuresData[,2]
		names(xTestData)  <- featuresData[,2]

	# Merge Training and test Data
		xData <- rbind(xTrainData,xTestData)
		yData <- rbind(yTrainData,yTestData)
		subjectData <- rbind(subjectTrainData,subjectTestData)
	# Assigns name to the column subject
		names(subjectData) <- "subjects"

## -------------------------------------------------------------------------------------------------- ##
#   Extracts only the measurements on the mean and standard deviation for each measurement. 
## -------------------------------------------------------------------------------------------------- ##	
		
	# Find column no with mean and Standard deviation measurements only
		meanDevColNos <- grep("mean\\(\\)|std\\(\\)",ignore.case = TRUE,featuresData[,2])

	# Create "x" dataset with Mean and Dev values only
		xMeanDevData <- xData[,meanDevColNos]

## -------------------------------------------------------------------------------------------------- ##
#  Uses descriptive activity names to name the activities in the data set, and combine subjects,activity & Measurements together
## -------------------------------------------------------------------------------------------------- ##			
	# Attach activity Label to yData
		yActivityData <- merge(x=yData,y=activityLabelsData)
		yActivityData <- yActivityData[2]
		names(yActivityData) <- "activities"

	# Concatenate "Subject" to each value to make it more descriptive rather integers only
		subjectData$subjects <- paste("subject",subjectData$subjects)

	# combine Datasets Subject, Activity and Mean & Std. Deviation Data
		allData <- cbind(subjectData,yActivityData,xMeanDevData)

	# Calculate mean of each column group by Subjects and Activities
		avgMeasurements <- aggregate(allData[,-1:-2],by = list(subjects,activities), FUN=mean)

	# Rename 1st 2 columns, as it get named like group.1 & Group.2
		names(avgMeasurements)[1] <- "subjects"
		names(avgMeasurements)[2] <- "activities"

## -------------------------------------------------------------------------------------------------- ##
#  creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## -------------------------------------------------------------------------------------------------- ##	
	# Write the final result to file
		write.table(avgMeasurements,"avgMeasurements.txt",row.name=FALSE)
		write.table(avgMeasurements,"avgMeasurementsTAB.txt",row.name=FALSE,sep="\t") # TAB delimited file