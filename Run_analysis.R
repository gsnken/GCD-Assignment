#Download and unzip if need be
       if(!file.exists("./FUC.zip")){
            download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="./FUC.zip", method="curl")
             unzip("./FUC.zip")
       }
#Read meta data
       xCols <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
       aLab<-read.table("./UCI HAR Dataset/activity_labels.txt")
#Decide the columns you need
       neededCols<-subset(xCols, grepl( "mean|std",xCols$V2))
       #we have not taken the "Mean" columns, we will also drop the meanFreq columns -
       neededCols<-subset(neededCols, !grepl( "meanFreq",neededCols$V2))
#Read Test Data
       subTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
       aTest<-read.table("./UCI HAR Dataset/test/y_test.txt")
       xTest<-read.table("./UCI HAR Dataset/test/X_test.txt")
#Read Train Data
       subTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
       aTrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
       xTrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
       
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Use descriptive activity names to name the activities in the data set
       FiltData <- rbind(
           cbind(Subject=subTest$V1, Activity=aLab[aTest$V1,2], subset(xTest[1,neededCols[,1]])),
           cbind(Subject=subTrain$V1, Activity=aLab[aTrain$V1,2], subset(xTrain[1,neededCols[,1]]))
       )
#FiltData is teh response of Part1 of the assignment       
       

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(reshape2)
#In tidy data, Each variable forms a column.
       
#In tidy data, Each observation forms a row. So we melt the data For each subject, activity  
       colnames(FiltDatan) <- c("Subject", "Activity", neededCols[,2]) 
       molten<-melt(FiltData, id.vars=c("Subject","Activity"))
#We now generate average for each variable / subject/activity
library("plyr")
       d<-ddply(molten,.(Subject,Activity,variable),summarise,Means=round(mean(value),2))
       write.table(d, file="./Summary Table.txt")
#I have uploaded the above file       
#End of Part 2 of the assignment
       
       
#EXTRA CODE BELOW  ############
       #We may print it more human readable with -
       d1<-xtabs(Means ~. , data=d)
       print(d1)   
       
       #Also, our column names which have now become 'Variable' in molten, carry much info
       # So first, Decipher the column names
       neededCols<- cbind(neededCols,BorG=tapply(neededCols$V2,neededCols$V1, 
                                                 FUN=function(x) if (grepl("Body",x)) "Body" else "Gravity" ))
       neededCols<- cbind(neededCols,AorG=tapply(neededCols$V2,neededCols$V1, 
                                                 FUN=function(x) if (grepl("Acc",x)) "Acc" else "Gyro" ))
       neededCols<- cbind(neededCols,mors=tapply(neededCols$V2,neededCols$V1,
                                                 FUN=function(x) if (grepl("mean",x)) "mean" else "sd" ))
       neededCols<- cbind(neededCols,torf=tapply(neededCols$V2,neededCols$V1, 
                                                 FUN=function(x) if (substr(x,1,1) =="t") "time" else "Fourier" ))
       neededCols<- cbind(neededCols,jerk=tapply(neededCols$V2,neededCols$V1,
                                                 FUN=function(x) if (grepl("Jerk",x)) "Jerk" else "None" ))
       neededCols<- cbind(neededCols,magnitude=tapply(neededCols$V2,neededCols$V1,
                                                      FUN=function(x) if (grepl("Mag",x)) "Magnitude" else "None" ))
       neededCols<- cbind(neededCols,axis=tapply(neededCols$V2,neededCols$V1,
                                                 FUN=function(x) { if (grepl("-X",x)) "X" 
                                                                   else if(grepl("-Y",x)) "Y" 
                                                                   else if(grepl("-Z", x)) "Z" 
                                                                   else "Combined"
                                                 } 
       ))
       colnames(neededCols)[2]<-"variable"
       d<-join(d,neededCols,by="variable")
#We can join the tables to get the explicit flags for each measure 
#But this is not the table I am uploading

#in tidy data, Each type of observational unit forms a table.
#But since our data is now easily subsettable, we will leave it there.
       ####### END OF FILE