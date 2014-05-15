## Check for source data and unzip if necessary
if (!file.exists("UCI HAR Dataset")) {
  if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
    stop("Was expecting HAR Dataset folder or zip file in the working directory. Please use the get_data.R script to load the necessary data to execute this script.")
  } else {
    unzip("getdata_projectfiles_UCI HAR Dataset.zip")
  }
}
