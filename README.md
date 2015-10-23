# Getting And Cleaning Data Course Project

## The course project contains the following files:
1. The actual R script of the project: run_analysis.R 
2. The final clean data set created: tidyDataSet.txt
3. The code book for the tidyDataSet: CodeBook.md

## Steps in getting tidy data set:
1. If not already downloaded, gets the UCI HAR Dataset and saves in current folder.
2. If not already unzipped, extracts the dataset in current folder.
3. Loads the features and activities into R
4. Loads training and test datasets for mean and standard deviation columns.
5. Merges activities and subject as another dataset.
6. Merges training, activities and subjects datasets together.
7. Uses activities and subjects as factors.
8. Tidy data set is created and written to file.
