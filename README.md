# client_churn
This project estimates the probability of churn and the expected gain from taking actions, taking into account the profits and losses that arise from whether a customer stays or leaves.


# Problem:

A cable service company has a customer churn problem.

Therefore, they want to take actions to score customers and establish the cutoff of the model to decide whether to take action on different customers. Customers with the highest probability of churning will be contacted to offer discounts, upgrades, etc.

To do this, it is necessary to estimate the probability of churn and estimate the expected gain from taking actions, taking into account the profits and losses that arise from whether a customer stays or leaves.

# Explanation of the code

This code can be divided into two parts, the first part involves loading and processing a dataset, while the second part creates graphs to visualize the relationships between some variables and the target variable.

In the first part of the code, the 'tidyverse' library is loaded, a CSV file is read and stored in 'data1', and then the column names of the dataset are changed. Some columns are converted to factor data type, which is a categorical data type in R.

In the second part of the code, several graphs are created using 'ggplot2' and 'gcookbook' libraries. The graphs visualize the relationship between the target variable 'Dado_de_baja' (which indicates whether a customer has cancelled their subscription) and other variables in the dataset such as 'Sexo' (gender), 'Tipo_Contrato' (type of contract), 'Meses_adeudo' (months in debt), 'Numero_quejas' (number of complaints), and 'Debito_autom' (automatic debit). The purpose of the graphs is to explore the data and find any interesting patterns or relationships between the variables and the target variable.

The code produces pie charts for the target variable 'Dado_de_baja' and bar charts for each of the variables mentioned above. It also calculates the proportion of users who have cancelled their subscription, the proportion of women and men who have cancelled their subscription, and the percentage of customers who have cancelled their subscription for each level of the categorical variables. Based on these calculations and visualizations, the code provides some insights into which variables are likely to have an impact on customer churn.

After cleaning, preparing, and performing exploratory data analysis, we proceeded to perform a Cross-Validation K-fold model estimation with Boosting. These are commonly used techniques in supervised machine learning for classification models. The combination of both techniques is used to improve the model's accuracy and avoid overfitting.

Then, plotted the variables and their importance as predictors of our target variable. The result is that the variable that correlates the most with customer churn is 'Var_cuota_ult_ano' (variation of the last year's fee), followed by 'Ingreso' (income). The variables that turned out to be less predictive are 'Sexo' (gender), followed by 'Recibio_oferta' (received offer).

Finally, the Cross-Validation K-fold model provides us with the prediction results. Therefore, we must choose the model that maximizes our gain from all the models and select its parameters. Then, we set the model's cutoff and run the model for a database that does not contain our target variable to test the model we just trained. 

