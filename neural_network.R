#install.packages("neuralnet")

library("neuralnet")

privateDir <- "C:\\Users\\Bill\\Documents\\Private-Github-Files"

setwd(privateDir)

Deals <- "Deal.csv"

col.Deals <- c("Deal.Number", "Snapshot.Date", "Agreement", "Deal.Type", "Primary.Leasing.Agent", "Building", "Deal.SF", "Lease.Term.Months", "No.Days.Since.Creation", "Current.Phase.No", "No.Days.in.Current.Phase", "Proposed.NER.Compared.To.Budget.NER", "State", "ZIP", "Submarket", "Building.Type", "Customer", "Government.Indicator", "AM.Probability", "NER", "Closed.As.Won")

df.deals <- read.csv(Deals, header = TRUE, as.is = FALSE, col.names = col.Deals)

df.deals$Snapshot.Date <- as.Date(df.deals$Snapshot.Date, "%Y-%m-%d")

df.deals$Deal.Number <- as.character(df.deals$Deal.Number)

set.seed(10)

randomVector <- sample(1:nrow(df.deals), 0.70*nrow(df.deals), replace = FALSE)

df.deals.train <- df.deals[randomVector,]
df.deals.test <- df.deals[-randomVector,]
df.deals.test <- df.deals.test[df.deals.test$Agreement!="Termination,Negotiated",]

nn <- neuralnet(Closed.As.Won ~ No.Days.Since.Creation, hidden = c(5,3), data = df.deals.train, linear.output = T)

plot(nn)