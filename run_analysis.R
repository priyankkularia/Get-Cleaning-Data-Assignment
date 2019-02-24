library(dplyr)
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("./UCI HAR Dataset/train/Y_train.txt")
trainsub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
testX <- read.table("./UCI HAR Dataset/test/X_test.txt")
testY <- read.table("./UCI HAR Dataset/test/Y_test.txt")
testsub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names <- read.table("./UCI HAR Dataset/features.txt")
actlabel <- read.table("./UCI HAR Dataset/activity_labels.txt")
totalX <- rbind(trainX, testX)
totalY <- rbind(trainY, testY)
totalsub <- rbind(trainsub, testsub)
selected_var <- names[grep("mean\\(\\)|std\\(\\)",names[,2]),]
totalX <- totalX[,selected_var[,1]]
colnames(totalY) <- "activity"
totalY$activitylabel <- factor(totalY$activity, labels = as.character(actlabel[,2]))
activitylabel <- totalY[,-1]
colnames(totalX) <- names[selected_var[,1],2]
colnames(totalsub) <- "subject"
total <- cbind(totalX, activitylabel, totalsub)
totalmean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(totalmean, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)
