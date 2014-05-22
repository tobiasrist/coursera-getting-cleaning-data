# Introduction

## Context and goals

This repo contains scripts and code books for peer evaluation within the course project for the course "Getting and Cleaning Data", offered through Coursera by the Johns Hopkins University.

The goal of this project is to take an input dataset provided by the course instructors, and to programmatically transform it into a "tidy" dataset following the project instructions.

## Prerequisites

* All scripts use the R statistical programming language. A current version of R should be used when executing scripts and evaluating results.

   > R Core Team (2014). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL http://www.R-project.org/.

* As per the project instructions, the input data should be available in the current R working directory. The main analysis script `run_analysis.R` expects the input data either as the original downloaded ZIP file `getdata_projectfiles_UCI HAR Dataset.zip`, or unzipped in the folder `UCI HAR Dataset`. Optionally, the script `get_data.R` is provided, which will download the input data to the working directory, as long as the data is still hosted on the course website.

# Content of this repo

1. README.md   
   This instruction file

2. run_analysis.R   
   The main analysis script, further described in section "Processing Steps"
   
3. CodeBook.md   
   A description of the tidy data set, explaining all variables
   
4. get_data.R   
   An optional script that downoads the input data from the course website
   
5. LICENSE   
   MIT licensing conditions for the whole repo, as proposed by GitHub
   
# Interpretation of the Input Dataset

* In the "root" directory of the dataset (folder `UCI HAR Dataset`), 2 relevant labeling files can be found:   
   * `activity_labels.txt` contains a cross-reference that links activity IDs with descriptive activity labels (e.g. 1 = walking)
   * `features.txt` contains the variable names for the 561 variables that form the bulk of the input dataset
   * The other files in the root directory are explanatory text files that describe the nature and structure of the dataset, but need not be further processed
* The subfolders `test` and `train` contain identically structured files that divide the overall dataset into 2 subsets:
   * `subject_test.txt` and `subject_train.txt` contain the IDs of individual persons ("subjects") who volunteered to participate in the study. Each subject ID is repeated several times, once for each individual observation of an activity that the subject performed.
   *  `X_test.txt` and `X_train.txt` contain the actual set of 561 variables recorded for each individual observation of an activity. Each row represents an observation, each column a variable, with the variable name available by applying the `features.txt` file from the root directory.
   * `y_test.txt` and `y_train.txt` contain the activity IDs for the activities performed by the subjects during each observation.
* The subfolders `Inertial Signals` within the `test` and `train` folders contain the original signals from the smartphone sensors used to observe the activities. As this data is already pre-processed to form the respective `X_test.txt` and `X_train.txt` files, these subfolders are ignored in the context of this project.

# Processing Steps

The processing steps performed by the `run_analysis.R` script are clearly structured using comments within the script file, but are explained in further detail here.

1. The script checks if the input dataset exists in the R working directory and unzips it if necessary. An error message is displayed in case the dataset is not found in the current working directory.
2. The data from the `test` and `train` subfolders is loaded into individual R objects
3. The labeling data from the "root" directory is loaded into individual R objects, the colums of the `activityLabels`object are properly named
4. The data from step 2 is combined into one large data frame, so that each row contains a complete observation including the subject ID, activity ID and the respective measured variables. The test and train datasets are combined so that the data frame containes all observations from both sets.
5. The relevant variables as per the project description are identified from the `featureLabels` object using regular expressions; the index of the relevant variables is stored in a new object `relevantFeatures`. The following variables are considered relevant:
   * Variables containing `mean()`, `std()`or `meanFreq()`within their respective name
   * Variables 555 - 561, as the `features_info.txt`file explains that these are means as well that were obtained using a different technique   

   In total, 86 of the original 561 variables are deemed relevant using this approach.
6. The labels for the relevant variables are cleaned-up, e.g. removing brackets, dashes and other unwanted characters. The labels are named following the "camel" approach to make them more readable, i.e. each component of the variable name starts with a capital letter (except for the first), but all other characters are lower case (e.g. `thisIsMyVariableName`).   
The cleaned-up names are applied to the data frame from step 4.
7. The activity labels are cleaned-up in the same way (lower case, "camel" approach)
8. The activity labels are merged into the combined data frame, so that each observation is not only identified by an activity ID, but also the respective clear-text activity name.
9. A reduced (intermediary) data frame is created that contains only subject ID, clear-text activity name and the relevant variables as per step 5.
10. The final, tidy dataset is created by aggregating the intermediary dataset from step 9 to only contain one row per subject ID / activity name combination. The variables are aggregated using the `mean()` function.   
The tidy dataset is ordered by subject ID & activity name. The row names of the data frame are cleaned up to avoid future confusion.
11. An `Output` subfolder within the working directory is created if necessary, and the tidy dataset is written to disk.

# Output
The output of the `run_analysis.R` script is the file `tidy.txt` that can be found in the `Output` subfolder of the working directory after successfully running the script. The fie is formatted in a way so that it can be read into R using the `read.table()` function with its default values.