#install.packages("MatrixModels")
#install.packages("rpart.plot")
#library(MatrixModels)
require(rpart)
require("rpart.plot")

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
df.deals$State <- as.character(df.deals$State)
df.deals$Proposed.NER.Compared.To.Budget.NER <- as.character(df.deals$Proposed.NER.Compared.To.Budget.NER)

# save off a list of features for later use
n <- names(df.deals)
n <- n[!n=="Deal.Number"]
n <- n[!n=="Snapshot.Date"]
n <- n[!n=="AM.Probability"]
n <- n[!n=="NER"]
n <- n[!n=="Building"]
n <- n[!n=="Customer"]
#n <- n[!n=="Submarket"]
#n <- n[!n=="Proposed.NER.Compared.To.Budget.NER"]

# save off a list of numeric features for later use
n.numeric <- names(df.deals)[sapply(df.deals, is.numeric)]
n.numeric <- n.numeric[!n.numeric=="AM.Probability"]

# calculate total value so that we can measure impact.
df.deals$Total.Value <- df.deals$Deal.SF * df.deals$NER

set.seed(10)

randomVector <- sample(1:nrow(df.deals), 0.80*nrow(df.deals), replace = FALSE)

df.deals.train <- df.deals[randomVector,]
df.deals.test <- df.deals[-randomVector,]
df.deals.test <- df.deals.test[df.deals.test$Agreement!="Termination,Negotiated",]

#build formula string to be used in all model fitting
f <- as.formula(paste("Closed.As.Won ~", paste(n[!n %in% "Closed.As.Won"], collapse = " + ")))
f.glm <- f

# LINEAR REGRESSION

#deal.prob2500252500.model <- glm(Closed.As.Won ~ Agreement + Deal.Type + Primary.Leasing.Agent + Building + Deal.Square.Footage + Lease.Term..Months. + Num.Days.Since.Creation + Current.Phase.in.the.Sales..Leasing..Process + Num.of.Days.in.Current.Phase + Deal.NER...Difference.To.Budget.NER + State + ZIP + Submarket + Building.Type + Customer + Government.Indicator, data = df.deals.train, family = "binomial")
#deal.prob.model <- glm(ClosedAsWon ~ Agreement + Deal.Type + Primary.Leasing.Agent + Deal.Square.Footage + Lease.Term..Months. + Num.Days.Since.Creation + Current.Phase.in.the.Sales..Leasing..Process + Num.of.Days.in.Current.Phase + Deal.NER...Difference.To.Budget.NER + State + ZIP + Submarket + Building.Type + Government.Indicator, data = df.deals.train, family = "binomial")
#fit.glm <- glm(f.glm, data = df.deals.train, family = "binomial")
fit.glm <- glm(Closed.As.Won ~ Current.Phase.No + Agreement + Proposed.NER.Compared.To.Budget.NER, data = df.deals.train, family = "binomial")

summary(fit.glm)

df.deals.test$Linear.Model.Probability <- predict(fit.glm, newdata = df.deals.test, type = "response")

df.deals.test$Linear.Model.Probability <- round(df.deals.test$Linear.Model.Probability, digits = 2) * 100


# DECISION TREES

fit.rpart <- rpart(Closed.As.Won ~ Agreement + Deal.Type + Primary.Leasing.Agent + Deal.SF + Lease.Term.Months + No.Days.Since.Creation + Current.Phase.No + No.Days.in.Current.Phase + Proposed.NER.Compared.To.Budget.NER + State + ZIP + Submarket + Building.Type + Government.Indicator, data = df.deals.train)

plot(fit.rpart)
text(fit.rpart)
prp(fit.rpart, extra = 1)

summary(fit.rpart)

df.deals.test$Decision.Tree.Probability <- predict(fit.rpart, newdata = df.deals.test, type = "vector")
df.deals.test$Decision.Tree.Probability <- round(df.deals.test$Decision.Tree.Probability, digits = 2) * 100



# NEURAL NETWORKS

n <- names(df.deals.test)[sapply(df.deals.test, is.numeric)]
n <- n[!n=="Total.Value"]
n <- n[!n=="AM.Probability"]
n <- n[!n=="Closed.As.Won"]

f.nn <- as.formula(paste("Closed.As.Won ~", paste(n.numeric[!n.numeric %in% "Closed.As.Won"], collapse = " + ")))

fit.nn <- neuralnet(f.nn, hidden = c(5,3), data = df.deals.train, linear.output = T)

plot(fit.nn)



colname.Output <- c("Deal.Number", "Closed.As.Won", "Total.Value", "AM.Probability", "Linear.Model.Probability", "NER", "Deal.SF")



write.csv(df.deals.test[,c(colname.Output)], paste(privateDir,"\\lmresults.csv", sep = ""), row.names = FALSE)
