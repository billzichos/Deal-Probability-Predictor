privateDir <- "C:\\Users\\Bill\\Documents\\Private-Github-Files"

setwd(privateDir)

Deals <- "Deal.csv"

col.Deals <- c("Deal.Number", "Snapshot.Date", "Agreement", "Deal.Type", "Primary.Leasing.Agent", "Building", "Deal.SF", "Lease.Term.Months", "No.Days.Since.Creation", "Current.Phase.No", "No.Days.in.Current.Phase", "Proposed.NER.Compared.To.Budget.NER", "State", "ZIP", "Submarket", "Building.Type", "Customer", "Government.Indicator", "AM.Probability", "NER", "Closed.As.Won")

df.deals <- read.csv(Deals, header = TRUE, as.is = FALSE, col.names = col.Deals)

df.deals$Deal.Number <- as.character(df.deals$Deal.Number)
df.deals$Snapshot.Date <- as.Date(df.deals$Snapshot.Date, "%Y-%m-%d")
df.deals$Deal.SF <- as.numeric(df.deals$Deal.SF)
df.deals$Lease.Term.Months <- as.numeric(df.deals$Lease.Term.Months)
df.deals$No.Days.in.Current.Phase <- as.numeric(df.deals$No.Days.in.Current.Phase)
df.deals$NER <- as.numeric(df.deals$NER)

set.seed(10)

randomVector <- sample(1:nrow(df.deals), 0.70*nrow(df.deals), replace = FALSE)

df.deals.train <- df.deals[randomVector,]
df.deals.test <- df.deals[-randomVector,]
df.deals.test <- df.deals.test[df.deals.test$Agreement!="Termination,Negotiated",]


# LINEAR REGRESSION

#deal.prob2500252500.model <- glm(ClosedAsWon ~ Agreement + Deal.Type + Primary.Leasing.Agent + Building + Deal.Square.Footage + Lease.Term..Months. + Num.Days.Since.Creation + Current.Phase.in.the.Sales..Leasing..Process + Num.of.Days.in.Current.Phase + Deal.NER...Difference.To.Budget.NER + State + ZIP + Submarket + Building.Type + Customer + Government.Indicator, data = df.deals.train, family = "binomial")
#deal.prob.model <- glm(ClosedAsWon ~ Agreement + Deal.Type + Primary.Leasing.Agent + Deal.Square.Footage + Lease.Term..Months. + Num.Days.Since.Creation + Current.Phase.in.the.Sales..Leasing..Process + Num.of.Days.in.Current.Phase + Deal.NER...Difference.To.Budget.NER + State + ZIP + Submarket + Building.Type + Government.Indicator, data = df.deals.train, family = "binomial")
deal.prob.model <- glm(Closed.As.Won ~ Agreement + Deal.Type + Primary.Leasing.Agent + No.Days.Since.Creation + State + Government.Indicator, data = df.deals.train, family = "binomial")
summary(deal.prob.model)

df.deals.test$Total.Value <- df.deals.test$Deal.SF * df.deals.test$NER

df.deals.test$Linear.Model.Probability <- predict(deal.prob.model, newdata = df.deals.test, type = "response")

df.deals.test$Linear.Model.Probability <- round(df.deals.test$Linear.Model.Probability, digits = 2) * 100

colname.Output <- c("Deal.Number", "Closed.As.Won", "Total.Value", "AM.Probability", "Linear.Model.Probability", "NER", "Deal.SF")

write.csv(df.deals.test[,c(colname.Output)], paste(privateDir,"\\lmresults.csv", sep = ""), row.names = FALSE)
