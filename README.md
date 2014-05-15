# Introduction

## Context and goals

This repo contains scripts and code books for peer evaluation within the course project for the course "Getting and Cleaning Data", offered through Coursera by the Johns Hopkins University.

The goal of this project is to take an input dataset provided by the course instructors, and to programmatically transform it into a "tidy" dataset following the project instructions.

## Prerequisites

* All scripts use the R statistical programming language. A current version of R should be used when executing scripts and evaluating results.

    > R Core Team (2014). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL http://www.R-project.org/.

* As per the project instructions, the input data should be available in the current R working directory. The main analysis script `run_analysis.R` expects the input data either as the original downloaded ZIP file `getdata_projectfiles_UCI HAR Dataset.zip`, or unzipped in the folder `UCI HAR Dataset`. Optionally, the script `get_data.R` is provided, which will download the input data to the working directory, provided the data is still hosted on the course website.

# Content of this repo

1. README.md

    This instruction file

2. run_analysis.R

    The main 