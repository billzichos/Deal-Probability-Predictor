# Deal-Probability-Predictor
Predict the probability that a Deal is won given a set of factors.

##Purpose
I am setting out to be able to assign a probability of a Deal closing as won, no matter how far along it is in the negotiation process, given a set of known features (attributes).

##Data
The following data elements are available from internal systems.
1. Deal Number
2. Asset Manager
2. Leasing Rep
3. # of Days Since Creation
4. Current Phase in the Sales (Leasing) Process
5. # of Days in Current Phase
6. Deal NER % Difference To Budget NER
7. State
8. Submarket
9. Building Type (Product attribute)
10. Customer
11. Government Indicator (this may overlap too much with Customer)

##Approach
My plan is to capture the features listed above for the entire population (snapshot) of open deals.  180 days later, I will go back and mark them as won (1) or lost (0).  Those still in process will be removed from the list.  The end result is a dataset we can use to train an algorithm to use in identifying deal probabilities for future deals.

The statistical methods used for generating this model/algorithm is yet to be determined.  However, it should be a model that favors producing outputs between 0 and 1.  I may leverage Amazon Machine Learning for this step.

Going forward to make sure the algorithm continues to learn, every 90 days take a new shapshot using the same SQL query before.  After 180 days, repeat the process above - capture the outcome, strip out the incompletes and append to the training set.  That's right, the training dataset will continue to grow, which hopefully results in a better model (algorithm).  Run the same statistical methods against the updated training dataset.  The output is hopefully a continually more effective predictive algorithm and a more effective forecast of sales (leasing).

##Technologies
1. SQL - extract our data (save as CSV)
2. R - exploratory data analysis, file management, machine learning
3. Amazon Machine Learning - machine learning
4. C# or Java - build the prediction into the operational system
