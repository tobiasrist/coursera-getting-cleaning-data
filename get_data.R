## Download data from the URL provided through Coursera
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(Sys.info()["sysname"] == "Darwin") {
    download.file(url, destfile = "./getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")
  } else {
    download.file(url, destfile = "./getdata_projectfiles_UCI HAR Dataset.zip")
  }