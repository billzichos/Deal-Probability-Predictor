require(rpart)

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


fit <- rpart(Closed.As.Won ~ Agreement + Deal.Type + Primary.Leasing.Agent + No.Days.Since.Creation + State + Government.Indicator, data = df.deals.train)

# fit <- rpart(
#         Survived ~ 
#                 Pclass+title+Sex+Embarked,
#         method = "class",
#         data=train.ready
# )

plot(fit)
text(fit)

#Prediction <- predict(fit, score.ready, type="class")
#Prediction <- predict(fit, df.deals.test)
df.deals.test$Decision.Tree.Probability <- predict(fit, newdata = df.deals.test, type = "vector")
df.deals.test$Decision.Tree.Probability <- round(df.deals.test$Decision.Tree.Probability, digits = 2) * 100

colname.Output <- c("Deal.Number", "Closed.As.Won", "AM.Probability", "Decision.Tree.Probability", "NER", "Deal.SF")

write.csv(df.deals.test[,c(1,21,19, 22, 20, 7)], paste(privateDir,"\\rpartresults.csv", sep = ""), row.names = FALSE)


#submit <- data.frame(PassengerId = score.ready$PassengerId, Survived = Prediction)

# create the csv file
#write.csv(file="bz_titanic_4.csv", x=submit, row.names=FALSE)