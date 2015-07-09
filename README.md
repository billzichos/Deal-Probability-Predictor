# Deal-Probability-Predictor
Predict the probability that a Deal is won given a set of factors.  Progress is being maintained on the [wiki](https://github.com/billzichos/Deal-Probability-Predictor/wiki).

##Purpose
My goal is to assign a probability of a Deal closing as won, no matter how far along it is in the negotiation process, given a set of known features (or attributes).

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
My plan is to capture the features listed above with periodic snapshots of our open deals every 60 days.  These periodic snapshots will be kept in separate files with each row representing a single deal.  As the deals in these snapshots are closed over time, I will mark as won (1) or lost (0) and add them to an accumulating file.  The end result is a dataset we can use to train a deal probability prediction model.

The statistical methods used for generating this model/algorithm are yet to be determined.  However, it should be a method that favors producing outputs between 0 and 1.  I may leverage Amazon Machine Learning for this step.

To make sure the model continues to improve, the periodic snapshots and posting to the accumulating file will continue to happen.  Re-training the model against the growing dataset will effectively increase the its accuracy.

## Testing


##Technologies
1. SQL - extract our data (save as CSV)
2. R - exploratory data analysis, file management, machine learning
3. Amazon Machine Learning - machine learning
4. C# or Java - build the prediction into the operational system (CRM)
5. Python - potential file management
6. Excel - a lot of times, its just easier...

## Future Considerations
1. Additional or a different mix of features.
2. Predict how a deal will change during the negotiation lifecycle.
3. Recommend a starting base rent amount.
4. Different data collection frequencies.