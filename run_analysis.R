# Author: E. Valencia
# May 2014
# Script to create a tidy dataset from the provided data

# Step 1: Merge training and test data to create a dataset

# Read test data
test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_subject <- read.table('./UCI HAR Dataset/test/subject_test.txt')
test_y <- read.table('./UCI HAR Dataset/test/y_test.txt')

# Merge the three test data objects
test_x <- cbind(test_x, test_y, test_subject)

# Read train data
train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_subject <- read.table('./UCI HAR Dataset/train/subject_train.txt')
train_y <- read.table('./UCI HAR Dataset/train/y_train.txt')

# Merge the three train data objects
train_x <- cbind(train_x, train_y, train_subject)

# Finally merge the two datasets and free up memory by deleting data no longer used
dat <- rbind(train_x, test_x)
rm(train_y, train_subject, train_x, test_y, test_subject, test_x)

# Step 2: Select only mean and std measurements
features <- read.table('./UCI HAR Dataset/features.txt')

# Use features to name data columns and also name added columns
colnames(dat) <- features[,2]
colnames(dat)[562:563] <- c("Activity","Subject")
rm(features)

# Select columns that have mean() or std() in its name, along with 'Activity' and 'Subject' columns
dat <- dat[,c(grep("(mean|std)\\(\\)",colnames(dat)),562,563)]

# Step 3/4: Use descriptive activity names instead of  1 to 6 numeration

# Convert activity numbers to factors
dat$Activity <- as.factor(dat$Activity)

# Read activity names
activities <- read.table('./UCI HAR Dataset/activity_labels.txt')

# Replace factors by activity names
dat$Activity <- factor(dat$Activity,labels=activities[,2])


# Reorder columns for readabality
dat <- dat[c(67:68,1:66)]

####### Now we have a tidy dataset which is 'dat' !!! ##########

# Write first data set into tab delimited text file
write.table(dat,'./dat.txt', sep='\t', row.names=FALSE)

# Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject

# Split tidy dataset by activities and subjects
res <- split(dat,interaction(dat$Activity,dat$Subject))

# Compute means of desired rows
means <- lapply(names(res),function(x){
    colMeans(res[[x]][,3:68])
  })

# Combine list of means into data frame
dat2 <- do.call(rbind.data.frame, means)

# Re-add activity names and subject numbers
dat2 <- cbind(rep(activities[,2],30),rep(1:30,each=6),dat2)

# Clean-up all unused data
rm(activities, means, res)

# Restablish column names and we are done - 'dat2' is our second dataset!!!
colnames(dat2) <- colnames(dat)

# Write second data set into tab delimited text file
write.table(dat2,'./dat2.txt', sep='\t', row.names=FALSE)
