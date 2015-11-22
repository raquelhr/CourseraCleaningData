##----------------start of the script programme----------------##

#loading the required libraries for the script to run
library(plyr)


#files have already been downloaded to the working directory.
#proceeding to reading the respective csv files

pathfolder <- file.path("UCI HAR Dataset")
files_under_directory <- list.files(pathfolder, recursive=TRUE) #doesn't return paths, but only file names
#listing all the files under the "UCI HAR Dataset" directory
files_under_directory



##----------------TASK1----------------##
##----Merges the training and the test sets to create one data set----##



#using the names of the files, we will have to merge the X data, Y data and subject data
#the first step is to unify the data related to test X and train X, then the labels in test Y and train Y, and finally 
#subject_test and subject_train
#using the README.md file, we therefore divide the categories in the following way:

#training and testing sets
trainX <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE, sep ='')
testX  <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep ='')

#training and testing labels
trainY <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE, sep ='')
testY  <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE, sep ='')

trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep ='')
testsubject  <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep ='')

Xdata <- rbind(trainX, testX)
Ydatacodes <- rbind(trainY, testY)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep ='', col.names = c("activityID", "activity"))
subjectdata <- rbind(trainsubject, testsubject)


#none of these dataframes have column names. to enable the easier distinction:
FeaturesLabels <- read.table("UCI HAR Dataset/features.txt",header=FALSE)
#only the second column contains the labels of each extracted feature
names(Xdata)<- FeaturesLabels[,2]
names(subjectdata)<- "subjectID"
names(Ydatacodes)<- "activityID"



#now we want to build a large dataset, which includes all subject, y and x data
#note that the first column has the subjectID, the second column has the activity ID, while
#the remaining columns contain all collected data
subjectandYdatacodes <- cbind(subjectdata, Ydatacodes)
alldata <- cbind(subjectandYdatacodes, Xdata)


##----------------TASK2----------------##
##----Extract only the measurements on the mean and standard deviation for each measurement----##

#we need to select the columns that contain the words mean and standarddeviation, together with the 
#subjectID and activityID. 
#For this, we will use logical operators under the grepl command which searches for matches to the 
#arguments that follow
meanstddata <- alldata[,grepl("subjectID|activityID|mean|std", names(alldata))]



##----------------TASK3----------------##
##----Uses descriptive activity names to name the activities in the data set----##


meanstddata <- join(activity_labels, meanstddata, by = "activityID", match = "all")


##----------------TASK4----------------##
##----Appropriately labels the data set with descriptive variable names----##

#first we check again what the column names are
names(meanstddata)
#we notice some names have parenthesis, so we might want to remove them
#for this we use the gsub function to remove all parenthesis from names
#notice this already uses regular expressions (not ( nor ) can remain in the column names)
names(meanstddata) <- gsub("\\(|\\)","", names(meanstddata))

#From features_info.txt we will use a dictionary to rename the names(meanstddata)
names(meanstddata) <- gsub('Acc',"Acceleration",names(meanstddata))
names(meanstddata) <- gsub('^t',"Time",names(meanstddata))
names(meanstddata) <- gsub('GyroJerk',"AngularAcceleration",names(meanstddata))
names(meanstddata) <- gsub('Gyro',"AngularVelocity",names(meanstddata))
names(meanstddata) <- gsub('Mag',"Magnitude",names(meanstddata))
#replacing mean and Std by their Capitalised names allows for a more straightforward identification
names(meanstddata) <- gsub('\\mean',"Mean",names(meanstddata))
names(meanstddata) <- gsub('\\Std',"StandardDeviation",names(meanstddata))
names(meanstddata) <- gsub('\\Freq',"Frequency",names(meanstddata))
#need to be carefull replacing only names that strat with f, but should not replace all f's with frequency!!!
names(meanstddata) <- gsub('^f',"Frequency",names(meanstddata))

#now we can check how our database looks like
head(meanstddata,2)


##----------------TASK 5----------------##
##----From the data set in step 4, creates a second, independent tidy data set----##
##----with the average of each variable for each activity and each subject----##
dim(meanstddata)


#generating a pipe with operations
#first operation removes the activityID, which is, at this stage, unecessary
#second operation generates a mean y activity and subject ID, so that there is only one row with 
#unique activity and subject ID combinations
#notice that numcolwise applies the same operation for each column using numcolwise (except for the 
#first two columns)

means_by_activity_subjectID <- meanstddata %>% subset(select = -activityID ) %>% ddply(.(activity, subjectID), numcolwise(mean)) 

#checking we've accomplished the task
head(means_by_activity_subjectID,10)
#there should be 30 subjects per activity, and since there are 6 activities, there should be a total of 180=30*6 rows
dim(means_by_activity_subjectID)


#finally create a txt file with the output. 
#the destination file will be saved in the working directory under the name "task5.txt" 
write.table(means_by_activity_subjectID, file="task5.txt", row.names = FALSE)