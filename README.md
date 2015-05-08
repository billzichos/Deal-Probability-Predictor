# Deal-Probability-Predictor
Predict the probability that a Deal is won given a set of factors.  Progress is being maintained on the [wiki](https://github.com/billzichos/Deal-Probability-Predictor/wiki).

##Purpose
My goal is to be able to assign a probability of a Deal closing as won, no matter how far along it is in the negotiation process, given a set of known features (or attributes).

##Data
The following data elements can be derived from internal systems, and are likely good predictors.

1. Deal Number
2. Agreement
3. Deal Type
4. Primary Leasing Agent
5. Building
6. Deal Square Footage
7. Lease Term (Months)
8. # of Days Since Creation
9. Current Phase in the Sales (Leasing) Process
10. # of Days in Current Phase
11. Deal NER % Difference To Budget NER
12. State
13. ZIP
14. Submarket
15. Building Type (Product attribute)
16. Customer
17. Government Indicator (this may overlap too much with Customer)

##Approach
My plan is to capture the features listed above for the entire population (snapshot) of open deals.  180 days later, I will go back and mark them as won (1) or lost (0).  Those still in process will be removed from the list.  The end result is a dataset we can use to train an algorithm to be used for calculating deal probabilities of new/current deals.

The statistical methods used for generating this model/algorithm are yet to be determined.  However, it should be a method that favors producing outputs between 0 and 1.  I may leverage Amazon Machine Learning for this step.

Going forward to make sure the algorithm continues to learn, every 90 days take a new shapshot using the same SQL query used to get the original snapshot.  After 180 days, repeat the process above - capture the outcome, strip out the incompletes and append to the existing training set.  That's right, the training dataset will continue to grow.  Run the same statistical methods against the updated training dataset.  The output is hopefully a continually more effective predictive algorithm and a more accurate forecast of sales (leasing).

##Technologies
1. SQL - extract our data (save as CSV)
2. R - exploratory data analysis, file management, machine learning
3. Amazon Machine Learning - machine learning
4. C# or Java - build the prediction into the operational system (CRM)
5. Python - potential file management
6. Excel - a lot of times, its just easier...
