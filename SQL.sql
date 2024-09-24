CREATE DATABASE credit_card_classification;

SELECT * FROM credit_card_classification.credit_card_data;

# Use the alter table command to drop the column q4_balance from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.

ALTER TABLE credit_card_classification.credit_card_data
DROP COLUMN Q4_Balance;

SELECT * FROM credit_card_classification.credit_card_data
LIMIT 10;

# Use sql query to find how many rows of data you have.

SELECT COUNT(*) AS total_rows
FROM credit_card_classification.credit_card_data;

SELECT DISTINCT Offer_accepted
FROM credit_card_classification.credit_card_data;

SELECT DISTINCT Reward
FROM credit_card_classification.credit_card_data;

SELECT DISTINCT Mailer_type
FROM credit_card_classification.credit_card_data;  

SELECT DISTINCT Credit_cards_held
FROM credit_card_classification.credit_card_data;

SELECT DISTINCT Household_size
FROM credit_card_classification.credit_card_data;  

# Arrange the data in a decreasing order by the average_balance of the customer. Return only the customer_number of the top 10 customers with the highest average_balances in your data.

SELECT ï»¿Customer_Number
FROM credit_card_classification.credit_card_data
ORDER BY average_balance DESC
LIMIT 10;

# What is the average balance of all the customers in your data?

SELECT AVG(average_balance) AS average_balance
FROM credit_card_classification.credit_card_data;

# What is the average balance of the customers grouped by Income Level?

SELECT income_level, AVG(average_balance) AS average_balance
FROM credit_card_classification.credit_card_data
GROUP BY income_level;

# What is the average balance of the customers grouped by number_of_bank_accounts_open?

SELECT bank_accounts_open, AVG(average_balance) AS average_balance
FROM credit_card_classification.credit_card_data
GROUP BY bank_accounts_open;

# What is the average number of credit cards held by customers for each of the credit card ratings? 

SELECT credit_rating, AVG(credit_cards_held) AS average_credit_cards
FROM credit_card_classification.credit_card_data
GROUP BY credit_rating;

# Is there any correlation between the columns credit_cards_held and number_of_bank_accounts_open?

SELECT bank_accounts_open, AVG(credit_cards_held) AS average_credit_cards
FROM credit_card_classification.credit_card_data
GROUP BY bank_accounts_open
ORDER BY bank_accounts_open;

# Your managers are only interested in the customers with the following properties:
#Credit rating medium or high
#Credit cards held 2 or less
#Owns their own home
#Household size 3 or more
# Write a simple query to find what are the options available for them? Can you filter the customers who accepted the offers here?

SELECT *
FROM credit_card_classification.credit_card_data
WHERE credit_rating IN ('medium', 'high')                  
  AND credit_cards_held <= 2                              
  AND homes_owned = 'Yes'                                   
  AND household_size >= 3                                
  AND offer_accepted = 'Yes';    
  
  # Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database. 
  
  SELECT *
FROM credit_card_classification.credit_card_data
WHERE average_balance < (
    SELECT AVG(average_balance)
    FROM credit_card_classification.credit_card_data
);


# Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database. Write a query to show them the list of such customers. You might need to use a subquery for this problem. Since this is something that the senior management is regularly interested in, create a view of the same query.

DROP VIEW IF EXISTS Customers_Below_Average_Balance;
CREATE VIEW Customers_Below_Average_Balance AS
SELECT *
FROM credit_card_classification.credit_card_data
WHERE average_balance < (SELECT AVG(average_balance) FROM credit_card_classification.credit_card_data);

# What is the number of people who accepted the offer vs number of people who did not?

SELECT offer_accepted, COUNT(*) AS number_of_people
FROM credit_card_classification.credit_card_data
GROUP BY offer_accepted;

# Your managers are more interested in customers with a credit rating of high or medium. What is the difference in average balances of the customers with high credit card rating and low credit card rating?

SELECT 
    (SELECT AVG(average_balance) 
     FROM credit_card_classification.credit_card_data 
     WHERE credit_rating = 'high') AS high_rating_avg_balance,
     
    (SELECT AVG(average_balance) 
     FROM credit_card_classification.credit_card_data 
     WHERE credit_rating = 'low') AS low_rating_avg_balance,
     
    ((SELECT AVG(average_balance) 
      FROM credit_card_classification.credit_card_data 
      WHERE credit_rating = 'high') 
    -
    (SELECT AVG(average_balance) 
     FROM credit_card_classification.credit_card_data 
     WHERE credit_rating = 'low')) AS balance_difference;
     
	
# In the database, which all types of communication (mailer_type) were used and with how many customers?

SELECT mailer_type, COUNT(*) AS number_of_customers
FROM credit_card_classification.credit_card_data
GROUP BY mailer_type;

# Provide the details of the customer that is the 11th least Q1_balance in your database.

SELECT ï»¿Customer_Number, q1_balance
FROM credit_card_classification.credit_card_data
ORDER BY q1_balance
LIMIT 10, 1;