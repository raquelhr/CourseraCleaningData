## CourseraCleaningData project
## prepared by raquelhr and submitted for evaluation on 22 Nov 2015


In this file we explain how the R script works to transform the raw data into tidy data 



How to run this R script?

1. If you use Rstudio, open the console to set the desired working directory
2. Download the full untidy dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip onto your working directory
3. Run the R script called "run_analysis.R" (it will load the plyr package, so if you don't have it installed, be sure to install it beforehand by typing install.packages("plyr") before attempting to run the R script)



What does the R script do?

The R script is divided into tasks that address each of the points in the instructions from the coursera course, and which have been transcribed to the README.md file which accompanies this repository


* TASK1
After identifying what each file in the original UCI HAR Dataset folder constains, we want to merge the testing and trainig date and we divide the data into Xdata that includes trainX and testX data, which corresponds to the values of different measurements made. We also create the dataframe Ydatacodes which includes the trainY and testY data, which identifies the activity type. Finally, we also want to label the different measurements made in the X files with the corresponding names. This is what the subjectdata does.

Finally we put all these data, Xdata, Ydatacodes and subjectdata together. We also introduce column names, for an accurate identification. The resulting dataframe is called "alldata" in the script. None of the steps in this task requires any special package.


* TASK2
With the dataset produced, we only want to keep the columns that contain the words mean or standard, and for completeness also the subject ID and activity corresponding to those columns. In this step we use logical operators (we want mean OR STD or subjectID OR activityID) under the grepl command. The resulting dataframe is called "meanstddata" in the R script.


* TASK3 
We use discriptive names for the activities, rather than activity numbers. We accomplish this by implementing the join function.
 

* TASK4
Now, we use discriptive names for each measurement. We start by removing the parenthesis in the column names. In the column names of the dataframe, whenever we see the element "Acc" we will replace by "Acceleration", any names that start by '^t' with "Time", replacing'GyroJerk' by "AngularAcceleration",replacing 'Gyro' by "AngularVelocity", replacing 'Mag' by "Magnitude", replacing '\\mean' by "Mean", replacing '\\Freq' by "Frequency", replacing all parts that start with f with "Frequency"

* TASK5

We create a dataframe called "means_by_activity_subjectID" that removes the activityID column (which is not necessary anymore), and computes the mean by activity and by subjectID. The script ends by creating a txt file called "task5.txt" in the working directory which contains all the measurements averaged out by subjectID and activity, with no row labels

NOTE ON RELEVANT UNITS

* all acceleration measurements are written in standard gravity units 'g'
* angular velocities have units of radians/second