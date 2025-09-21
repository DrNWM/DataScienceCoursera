getwd()
library(dplyr)

# Unzip the file and list contents to verify
zip_file <- "project.zip"
unzip(zip_file)
dir()

# Set work directory and view the contents of folders
setwd("./UCI HAR Dataset")
dir()
dir("test")
dir("train")

# Read metadata
activity_labels <- read.table("./activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("./features.txt", col.names = c("feature_id", "feature_name"))

# Read and combine test data
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")
X_test <- read.table("./test/X_test.txt", col.names = features$feature_name)
y_test <- read.table("./test/y_test.txt", col.names = "code")
test_data <- cbind(subject_test, y_test, X_test)

# Read and combine train data
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")
X_train <- read.table("./train/X_train.txt", col.names = features$feature_name)
y_train <- read.table("./train/y_train.txt", col.names = "code")
train_data <- cbind(subject_train, y_train, X_train)

# Merge
merged_data <- rbind(train_data, test_data)
dim(merged_data)

# Original grep to get mean and std features
mean_std_features <- grep("mean\\(\\)|std\\(\\)", features$feature_name, value = TRUE)

# Clean mean_std_features to match merged_data's column names
cleaned_features <- mean_std_features
cleaned_features <- gsub("-", ".", cleaned_features)     # Replace - with .
cleaned_features <- gsub("\\(\\)", "..", cleaned_features) # Replace () with .          # Remove trailing dot if any

# Verify the cleaned names
head(cleaned_features)  # Should show names like "tBodyAcc.mean.X"

# Now filter valid features
valid_features <- cleaned_features[cleaned_features %in% colnames(merged_data)]
head(valid_features)   # Confirm names match, e.g., "tBodyAcc.mean.X"

# Select the columns
selected_data <- merged_data[, c("subject", "code", valid_features), drop = FALSE]

# Verify the result
dim(selected_data)  # Should have all rows, ~68 columns (2 + 66 features)
head(colnames(selected_data))  # Should include "subject", "code", "tBodyAcc.mean.X", etc.

# Perform left join with selected_data
joined_data <- selected_data %>%
  left_join(activity_labels, by = "code")
joined_data <-  select(joined_data,subject,code,activity,everything())
 

tidy_data <- joined_data %>%
  group_by(subject, activity) %>%
  summarise(across(where(is.numeric), mean, .names = "avg_{.col}"), .groups = "drop")
write.table(tidy_data, "tidy_dataset.txt", row.names = FALSE)
