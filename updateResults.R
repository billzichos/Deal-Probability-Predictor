#Update the periodic snapshot with Results if known
library(dplyr)

# setwd("~/Private-Github-Files")

# specify the snapshot file to update with actual results
snapshotFilename <- "OpenDeals20150508.csv"

# import the actual results
results <- read.csv("~//Private-Github-Files//results.csv")
# str(results)

# import the point-in-time snapshot
snapshot <- read.csv(paste("~//Private-Github-Files//", snapshotFilename, sep =""))
# str(snapshot)
# summary(snapshot)

# merge the snapshot and results files, creating a single dataset
comb <- merge(snapshot, results, by.x = 'Deal.Number', by.y = 'Deal.Number')
# summary(comb)
# str(comb)

# update the closedsaswon field based on the value in the status field.
comb$ClosedAsWon[comb$Status=="Lost"] <- 0
comb$ClosedAsWon[comb$Status=="Won"] <- 1

# add only the fields from the snapshot dataset to the final dataset.
completeDataset <- select(comb, 1:21)
# str(completeDataset)
# str(completeDataset$ClosedAsWon)
# summary(completeDataset)
# summary(completeDataset$ClosedAsWon)

# overwrite the orginal snapshot file
write.csv(completeDataset,paste("~//Private-Github-Files//",snapshotFilename, sep = ""), row.names = FALSE)