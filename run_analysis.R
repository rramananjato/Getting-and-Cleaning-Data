## setting working directory
setwd("C:/DCO/R/Getting-and-Cleaning-Data")

library(plyr)
library (dplyr)
## reading train set data
train <- read.fwf("train/X_train.txt", widths= rep(16,561), header=F, skip=0)
names <-read.csv("features.txt", sep=" ", header=F)  ## reading names from features.txt
colnames(train) <- names$V2
lab <- read.csv("train/y_train.txt", sep=" ", header=F)
sub <- read.csv("train/subject_train.txt", sep=" ", header=F) 
train2 <- cbind(train, lab$V1, sub$V1)
train2 <- mutate(train2, type="train")

## reading test set data
test <- read.fwf("test/X_test.txt", widths= rep(16,561), header=F, skip=0)
colnames(test) <- names$V2
lab <- read.csv("test/y_test.txt", sep=" ", header=F)
sub <- read.csv("test/subject_test.txt", sep=" ", header=F)
test2 <- cbind(test, lab$V1, sub$V1)
test2 <- mutate(test2, type="test")



## merging test and training datasets
master <- rbind(train2, test2)

## keep only mean and std variables
keep <- (grepl("mean", names$V2)|grepl("std", names$V2))& !grepl("meanFreq", names$V2) ## keeping only mean and std variables
master2 <- master[keep[TRUE]]

write.table(master2, "data.csv", row.name=FALSE)
