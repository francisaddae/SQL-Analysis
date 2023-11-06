/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021. */


-- Approach
-- Get the total transaction sale per each day
--- Since we can have multiple transactions per day, we need to calculate all the transactuons that took place within each day first before we calculate a 3 day rolling average
-- Then find the three day rolling averages up to that date. ie; 3 Days prior to that date
WITH daily_sales AS(
  SELECT
      TO_CHAR(transaction_time, 'YYYY-MM-DD') AS transaction_date,
      SUM(transaction_amount) AS total_transaction_ammount
  FROM transactions
  WHERE transaction_time::DATE BETWEEN '2021-01-01' AND '2021-01-31'
  GROUP BY transaction_date
)
SELECT
	transaction_date,
    total_transaction_ammount,
    TRUNC(AVG(total_transaction_ammount) OVER(ORDER BY transaction_date ROWS BETWEEN 3 PRECEDING AND CURRENT ROW)::DECIMAL, 2) AS three_daya_moving_averages
FROM daily_sales;
