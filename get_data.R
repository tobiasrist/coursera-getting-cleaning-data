## Download data from the URL provided through Coursera
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")
