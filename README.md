Getting and Cleaning Data - Project
===================================

(by E. Valencia, May 2014)

The script run_analysis.R creates 2 tidy datasets from the inertial data files. 

To run this script, the 'UCI HAR Dataset' uncompressed folder should be at the same folder than the script.

The output are 2 new tidy datasets in independent tab-separated text files named 'dat.txt' and 'dat2.txt', corresponding to the datasets required in steps 4 and 5 of the project.

Script steps
------------

The script performs the following actions in order to get to the resulting datasets:

1. Read data files from test observations: X_test.txt (data), subject_test.txt (subject number for each measurement), and y_test.txt (activity number for each measurement).

2. Create a 'test' data frame by combining the three data pieces from the previous step.

3. Read data files from train observations: X_train.txt (data), subject_train.txt (subject number for each measurement), and y_train.txt (activity number for each measurement).

4. Create a 'train' data frame by combining the data pieces from the previous step.

5. Combine the train and test data frames into a singe data frame.

6. Read the 'features.txt' files to obtain the name of each measurement, and use them no name the data frame columns.

7. Keep only the columns that have 'mean()' or 'std()' in its name.

8. Read the 'activity_labels.txt' file, and replace the activity numbers by its logical name (i.e. text).

9. Write this first tidy dataset into a tab-separated text file named 'dat.txt'.

10. Split the data frame by activities and subjects.

11. Compute the average of each measurement (i.e. column) and combine the resulting rows into a data frame.

12. Write the final data frame into another tab-separated text file named 'dat2.txt'.