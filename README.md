# courseproject
The scripts within this Repo perform a transformation on the data for this study: 

 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

That data is accessible here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data accessible through the link below is not tidy and the Run_Analysis.R script
contained in this repo transforms these elements into a tidy and usable data set (masterdata). 

This script also extracts only the measures of mean and standard deviation for each
feature in the original data set and creates a new separate data set (meanandstdsdata). meanandstdsdata provides
the average of each variable for each activity and each subject. 

The codebook included in this repo describes the variables, the original data, and the transformations required
to tidy the data. 
