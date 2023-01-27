![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Lab | Comparing regression models


For this lab, we will be using the same dataset we used in the previous labs. We recommend using the same notebook since you will be reusing the same variables you previous created and used in labs. 

### Instructions

1. In this final lab, we will model our data. Import sklearn `train_test_split` and separate the data.

2. We will start with removing outliers, if you have not already done so.  We have discussed different methods to remove outliers. Use the one you feel more comfortable with, define a function for that. Use the function to remove the outliers and apply it to the dataframe.

3. Create a copy of the dataframe for the data wrangling.

4. Normalize the continuous variables. You can use any one method you want.

5. Encode the categorical variables (See the hint below for encoding categorical data!!!)

6. The time variable can be useful. Try to transform its data into a useful one. Hint: Day week and month as integers might be useful.

7. Since the model will only accept numerical data, check and make sure that every column is numerical, if some are not, change it using encoding.


## Hint for Categorical Variables

You should deal with the categorical variables as shown below (for ordinal encoding, dummy code has been provided as well):
Encoder Type | Column 
-----------------|-----------------
One hot | state
Ordinal | coverage
Ordinal | employmentstatus
Ordinal | location code
One hot | marital status
One hot | policy type
One hot | policy
One hot | renew offercustomer_df
One hot | sales channel
One hot | vehicle class
Ordinal | vehicle size

##### Dummy code
data["coverage"] = data["coverage"].map({"Basic" : 0, "Extended" : 1, "Premium" : 2})

given that column "coverage" in the dataframe "data" has three categories:

"basic", "extended", and "premium" and values are to be represented in the same order.



8. Try a simple linear regression with all the data to see whether we are getting good results.

9. Great! Now define a function that takes a list of models and train (and tests) them so we can try a lot of them without repeating code.

10. Use the function to check `LinearRegressor` and `KNeighborsRegressor`.

11. You can check also the `MLPRegressor` for this task!

12. Check and discuss the results.
