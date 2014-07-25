 # GCD Peer Assessment
========================================================
This is the README.md in my Getting and Cleaning Data Course project submission Github repository. 
This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data used for the curresnt assignment representa data collected from the accelerometers from the Samsung Galaxy S smartphone.

## Files in this repository
This repository includes 
- This Readme.md file
- Codebook.md a data dictionary of relevance
- run_analysis.R the R code file used to clean and organise the data

It does not contain -
- The originale dataset used (it can be found on the website as mentioned below)
- The summary data generated (it is submitted on the coursera website)

## The Data

I have used data downloaded from -

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

on 23rd July 2014.

## Meta Data

This repository contains a file called CodeBook.md,
It describes the variables, the data, and any transformations or work that I performed to clean up the data. 

## The Process

The run_Analysis.R file in this repository actually cleans the data. 
It also includes code to download and unzip the data if it is not already present in the current working directory at the runtime.
Following are the steps taken -
- Download data and metadata (if not already there) and unzip the same in current working directory. The files go into a subdirectory "./UCI HAR Dataset""
- Decide on the columns that are useful. I have taken column with 'mean' or 'std' in their names - but not 'Mean' or 'meanFreq' - that is my understanding of the problem statement -"only the measurements on the mean and standard deviation for each measurement"
-Read the test and train datasets - each are divided into three files (subject giving the subject number, y giving the activity the subject was carrying out and X giving the various readings and calculated figures(561 per row))
-Extract useful colummns from train and test data sets to form a single dataset
- This is end of part 1 of the assignment

For the second portion we use the reshape2 and plyr packages
-First we melt the filtered data to get a normalised vector (third normal Form = All non-key columns depend on key and complete key)
-We then summarise as averages and save the table.
-This saved table is uploaded as part of the assignment on Coursera website

## Extra Code
Beyond this I have put 2 extra sets of code -
- To pretty print, I have generated a cross tab
- In order to further tidy the data, I have interpreted the variable names and made them in to separate columns - just in case needed to subset for further analysis

## The Output

The assignment involves cleaning the raw data to obtain a tidy data set.
The tidy data itself has been submitted on the coursera website as a txt file upload.
There are 30 Subjects * 6 activities * 66 parameters of interest = 11880 Rows in the  summary table.

