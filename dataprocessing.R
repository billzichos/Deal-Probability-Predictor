privateDir <- "C:\\Users\\Bill\\Documents\\Private-Github-Files"

setwd(privateDir)

unprocessedSnap <- "OpenDeals20150508.csv"
#unprocessedSnap <- "OpenDeals20150601.csv"
#unprocessedSnap <- "OpenDeals20150804.csv"
#unprocessedSnap <- "OpenDeals20151001.csv"
#unprocessedSnap <- "OpenDeals20151201.csv"

snap <- read.csv(unprocessedSnap, header = TRUE, as.is = TRUE)
results <- read.csv("results.csv", header = TRUE)

str(snap)

snap$Agreement <- as.factor(snap$Agreement)
snap$Deal.Type <- as.factor(snap$Deal.Type)

table(snap$Agreement, snap$Deal.Type)

snap$Primary.Leasing.Agent <- as.factor(snap$Primary.Leasing.Agent)
snap$Deal.NER...Difference.To.Budget.NER <-
        as.factor(snap$Deal.NER...Difference.To.Budget.NER)
snap$State <- as.factor(snap$State)
snap$ZIP <- as.factor(snap$ZIP)

table(snap$Primary.Leasing.Agent, snap$State)

snap$Submarket <- as.factor(snap$Submarket)

table(snap$Primary.Leasing.Agent, snap$Submarket)

snap$Building.Type <- as.factor(snap$Building.Type)
snap$Government.Indicator <- as.factor(snap$Government.Indicator)

snap$Deal.Square.Footage <- as.numeric(snap$Deal.Square.Footage)
snap$Lease.Term..Months. <- as.numeric(snap$Lease.Term..Months.)
snap$Num.Days.Since.Creation <- as.numeric(snap$Num.Days.Since.Creation)
snap$Current.Phase.in.the.Sales..Leasing..Process <-
        as.numeric(snap$Current.Phase.in.the.Sales..Leasing..Process)
snap$Num.of.Days.in.Current.Phase <- as.numeric(snap$Num.of.Days.in.Current.Phase)

summary(snap)

names(snap)
names(results)

help(merge)

snapWithResults <- merge(
        snap, results, by.x = "Deal.Number", by.y = "Deal.Number", all = FALSE
        )

str(snapWithResults)

write.csv(paste("processed",unprocessedSnap, sep=""))


# 1. Read in the snapshot file.
# 2. Strip out a list of all the Deal Numbers we want to check.
# 3. Check which Deals are still open.  Remove them.
# 4. Of the remaining deals, obtain won or lost status.
# 5. Add the status to file.
# 6. Append file to master file.