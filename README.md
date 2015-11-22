## CourseraCleaningData project
## prepared by raquelhr and submitted for evaluation on 22 Nov 2015



Guidelines for the project 

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



Instructions for the project

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



This repository contains:

* README.md: this file which contains basic information on the purpose of this repository
* CodeBook.md: explanatory notes on the transformation of raw data into tidy data 
* run_analysis.R: R script that transforms the raw databases (spread over the UCI HAR Dataset) into a single tidy database which contains the average of each variable organised per activity and per subject (ie, per person)



How to run this R script

1. If you use Rstudio, open the console to set the desired working directory
2. Download the full untidy dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip onto your working directory
3. Run the R script called "run_analysis.R" (it will load the plyr package, so if you don't have it installed, be sure to install it beforehand by typing install.packages("plyr") before attempting to run the R script)