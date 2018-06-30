require(dplyr)
require(magrittr)


##############################################################################################
#STEP 1 - get and combine training and test sets to create one data set 
##############################################################################################

###load the datasets into variables in R
test_values <- read.table("C:/Users/john/Desktop/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="", stringsAsFactors = FALSE)
training_values <- read.table("C:/Users/john/Desktop/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="", stringsAsFactors = FALSE)
varnames <- read.table("C:/Users/john/Desktop/UCI HAR Dataset/features.txt", quote="\"", comment.char="", stringsAsFactors = FALSE)
test_activites <- read.table("C:/Users/john/Desktop/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="", stringsAsFactors = FALSE)
training_activities <- read.table("C:/Users/john/Desktop/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="", stringsAsFactors = FALSE)
test_subjects <- read.table("C:/Users/john/Desktop/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="", stringsAsFactors = FALSE)
training_subjects <- read.table("C:/Users/john/Desktop/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="", stringsAsFactors = FALSE)
activity_labels <- read.table("C:/Users/john/Desktop/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="", stringsAsFactors = FALSE)

### apply labels to variables
names(test_values) <- varnames$V2
names(training_values) <- varnames$V2
names(test_activites) <- "activity"
names(training_activities) <- "activity"
names(test_subjects) <- "subject"
names(training_subjects) <- "subject"

### combine data sets
testcombine1 <- cbind(test_activites,test_values)
testcomplete <- cbind(test_subjects, testcombine1)
traincombine1 <- cbind(training_activities, training_values)
traincomplete <- cbind(training_subjects,traincombine1)
masterdata <- rbind(testcomplete,traincomplete)

###############################################################################################
#STEP 2 - extract only the measurements on the mean and standard deviation for each measurement
###############################################################################################

#create the list of indexes for all means and SDs among the 561 features
meansandstds <- grepl("mean\\(\\)|std\\(\\)", varnames$V2)
cols <- varnames$V2[meansandstds]

#subset the file to just those variables and save it in a new data set and subject and activity 
meanandstdsdata <- masterdata[,c("subject","activity", cols)]

##############################################################################################
#STEP 3 - use descriptive activity names to name the activites in the data set
############################################################################################## <- 

#recode variables in the new data set
meanandstdsdata$activity <- with(meanandstdsdata, ifelse(activity == 1, "walking", 
                                                         ifelse(activity == 2, "walkingupstairs",
                                                                ifelse(activity == 3, "walkingdownstairs",
                                                                       ifelse(activity == 4, "sitting",
                                                                              ifelse(activity == 5, "standing", "laying"))))))


##############################################################################################
#STEP 4 - appropriately label the data set with descriptive variable names
##############################################################################################

#This is completed in Step 1 (see apply labels to variables)

##############################################################################################
#STEP 5 - leverage this data set to create a new data set with the average of each variable 
#for each activity and each subject
##############################################################################################

agg <- meanandstdsdata %>%
                dplyr::group_by(subject, activity) %>%
                dplyr::summarise_all(mean)

