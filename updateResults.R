#Update the periodic snapshot with Results if known
library(dplyr)

snapshotFilename <- "OpenDeals20150601.csv"

results <- read.csv("~//Private-Github-Files//sample_results.csv")
# str(results)

snapshot <- read.csv(paste("~//Private-Github-Files//", snapshotFilename, sep =""))
# str(snapshot)
# summary(snapshot)

comb <- merge(snapshot, results, by.x = 'Deal.Number', by.y = 'Deal.Number')
# summary(comb)
# str(comb)

comb$ClosedAsWon[comb$Status=="Lost"] <- 0
comb$ClosedAsWon[comb$Status=="Won"] <- 1

completeDataset <- select(comb, 1:21)
# str(completeDataset)
# str(completeDataset$ClosedAsWon)
# summary(completeDataset)
# summary(completeDataset$ClosedAsWon)

write.csv(completeDataset,paste("~//Private-Github-Files//",snapshotFilename, sep = ""), row.names = FALSE)
