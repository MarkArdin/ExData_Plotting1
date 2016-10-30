# Exploratory Data Analysis Week 1 Peer assessed project

## Data Preparation

Each script includes a datadir variabble that youshoudl set to a locaion containing the
file "household_power_consumption.txt".

Each script converts the date columnn to class (date) and filters the file to retain only records with dates in the range >= "2007-02-01" and <= "2007-02-02")

A new POSIXct column is also created for use in the plots requiring day information

Prior to the creation of each plot rows with the ? value (which represents na in this dataset) are removed and remaining values convertd to the numeric class.

## Plot4.R

This repeats the filtering separately for each of the plots as the columns being used differ



