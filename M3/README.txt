==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


README for UCI HAR Dataset Analysis
Project Overview
This project processes the UCI Human Activity Recognition (HAR) dataset to create a tidy dataset with the average of mean and standard deviation features for each subject and activity. The dataset contains measurements from smartphone sensors for human activities (e.g., walking, sitting). The final output is a summarized dataset grouped by activity code and subject, with descriptive activity labels.

Dataset
The UCI HAR dataset is sourced from:

Source: UCI Machine Learning Repository
Files Used:
features.txt: Contains 561 feature names for sensor measurements.
activity_labels.txt: Maps activity codes (1–6) to names (e.g., 1 = WALKING).
train/X_train.txt, train/y_train.txt, train/subject_train.txt: Training data with features, activity codes, and subject IDs.
test/X_test.txt, test/y_test.txt, test/subject_test.txt: Test data with features, activity codes, and subject IDs.
Data Description:
Features include time and frequency domain signals (e.g., tBodyAcc-mean()-X, tBodyAcc-std()-Y).
Activities: 6 types (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
Subjects: 30 individuals (1–30).
Objective
The goal is to:

Merge training and test datasets.
Extract only mean and standard deviation features (e.g., columns containing mean() or std()).
Add descriptive activity names by joining with activity_labels.txt.
Create a tidy dataset with the average of each feature per subject and activity.
Prerequisites
Software: R (version 4.0 or higher).
Packages: dplyr (for data manipulation).
install.packages("dplyr")
library(dplyr)
Directory Structure: Place the UCI HAR dataset in a folder named UCI HAR Dataset in your working directory.
Code Description
The R script (run_analysis.R) performs the following steps:

Load Data:
Reads features.txt and activity_labels.txt.
Loads training and test datasets (X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt, subject_test.txt).
Merge Data:
Combines training and test datasets into a single data frame (merged_data) with columns for subject, code (activity), and 561 features.
Assigns feature names from features.txt to merged_data columns.
Extract Mean and Std Features:
Selects columns with mean() or std() in their names using grep.
Handles column name mismatches by cleaning feature names (replacing - and () with .).
Creates selected_data with subject, code, and mean/std features (~68 columns).
Add Activity Labels:
Performs a left join with activity_labels to add descriptive activity names (e.g., WALKING) based on the code column.
Group and Summarize:
Groups data by code and activity (and optionally subject).
Computes the mean of each numeric feature per group, producing a tidy dataset.
How to Run
Download the Dataset:
Download and unzip the UCI HAR dataset from here.
Place the UCI HAR Dataset folder in your R working directory.
Run the Script:
Save the R script as run_analysis.R.
Set your working directory in R:
setwd("path/to/your/directory")
Source the script:
source("run_analysis.R")
Output:
selected_data: Data frame with subject, code, and mean/std features.
joined_data: Adds activity column with descriptive labels.
summarized_data: Tidy dataset with mean feature values per code and activity (or subject and activity).
Output Format
Final Dataset: summarized_data is a tidy data frame with:
Columns: code, activity, subject (if grouped by subject), and mean values for each mean/std feature.
Rows: One per unique combination of code and subject (e.g., 6 activities × 30 subjects = 180 rows if grouped by both).
Saved as tidy_data.txt (if exported):
write.table(summarized_data, "tidy_data.txt", row.names = FALSE)
Challenges and Solutions
Column Name Mismatch: Feature names in features.txt (e.g., tBodyAcc-mean()-X) didn’t match merged_data’s cleaned names (e.g., tBodyAcc.mean.X). Fixed by cleaning feature names with gsub to replace - and () with ..
Join Issues: Ensured code columns in selected_data and activity_labels were numeric for proper left join.
Files Included
run_analysis.R: Main script for data processing.
tidy_data.txt: (Optional) Exported tidy dataset.
README.md: This file, explaining the project.
License
This project uses the UCI HAR dataset, which is publicly available for research. The code is licensed under MIT License.


