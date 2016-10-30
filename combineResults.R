file1 <- read.csv("~//Private-Github-Files//OpenDeals20150508.csv", as.is = TRUE)
file2 <- read.csv("~//Private-Github-Files//OpenDeals20150601.csv", as.is = TRUE)
file3 <- read.csv("~//Private-Github-Files//OpenDeals20150804.csv", as.is = TRUE)
file4 <- read.csv("~//Private-Github-Files//OpenDeals20151001.csv", as.is = TRUE)
file5 <- read.csv("~//Private-Github-Files//OpenDeals20151201.csv", as.is = TRUE)

file1$Snapshot.DateTime <- as.Date("2015-05-08")
file2$Snapshot.DateTime <- as.Date("2015-06-01")
file3$Snapshot.DateTime <- as.Date("2015-08-04")
file4$Snapshot.DateTime <- as.Date("2015-10-01")
file5$Snapshot.DateTime <- as.Date("2015-12-01")

file1.Complete <- file1[!is.na(file1$ClosedAsWon),]
file2.Complete <- file2[!is.na(file2$ClosedAsWon),]
file3.Complete <- file3[!is.na(file3$ClosedAsWon),]
file4.Complete <- file4[!is.na(file4$ClosedAsWon),]
file5.Complete <- file5[!is.na(file5$ClosedAsWon),]

df.Complete <- rbind(file1.Complete, file2.Complete, file3.Complete, file4.Complete, file5.Complete)
#on 12/14/2015 there were 391 records in this dataset.

#df.Complete <- rbind(file3.Complete, file4.Complete, file5.Complete)

#if no probability is assigned, assume zero
df.Complete$Probability[df.Complete$Probability=="NULL"] <- 0
df.Complete$Probability <- as.numeric(df.Complete$Probability)

write.csv(df.Complete,"~//Private-Github-Files//Deal.csv", row.names = FALSE)