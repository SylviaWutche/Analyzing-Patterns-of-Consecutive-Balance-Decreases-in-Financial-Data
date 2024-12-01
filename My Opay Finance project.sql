--  Identify consecutive days with decreasing balances for more than 4 days
 

 --Step 1: First find the last transaction for each day
WITH last_trans AS (
    SELECT
        id,
        TransDate,
        Balance,
        ROW_NUMBER() OVER (PARTITION BY TransDate ORDER BY TransDate, id DESC) AS rnk
    FROM opay_Transactions
),
-- Step 2: Calculate the previous day's balance using LAG function
previous_day_balance AS (
    SELECT 
        TransDate,
        Balance, 
        rnk,
        LAG(Balance, 1) OVER (ORDER BY TransDate, id DESC) AS prev_balance -- finding previous day's balance
    FROM last_trans 
    WHERE rnk = 1 -- Get only the last transaction for each day
    ORDER BY TransDate
),
-- Step 3: Flag where the current balance is greater than or less than the previous day's balance
flag AS (
    SELECT 
        TransDate,
        prev_balance,
        Balance, 
        CASE 
            WHEN Balance < prev_balance THEN 0  -- Flag 0 if balance decreased
            ELSE 1  -- Flag 1 if balance increased
        END AS flag 
    FROM previous_day_balance
),
-- Step 4: Create a sequence ID by summing the flags, identifying consecutive periods of balance decrease
seq AS (
    SELECT 
        TransDate,
        Balance,
        prev_balance,
        flag,
        SUM(flag) OVER (ORDER BY TransDate) AS seq -- Cumulative sum of flags to group consecutive periods
    FROM flag
),
-- Step 5: Identify consecutive days with decreasing balances
consecutive_days AS (
    SELECT 
        seq,
        COUNT(*) AS ConsecutiveDays,
        MIN(TransDate) AS StartDate,
        MAX(TransDate) AS EndDate
    FROM seq
    WHERE Balance < prev_balance  
    GROUP BY seq
)
--Final: Select periods where the balance decreased for more than 4 days
SELECT 
    StartDate,
    EndDate,
    ConsecutiveDays
FROM consecutive_days
WHERE ConsecutiveDays > 4  -- Filter to show decreasing periods longer than 4 days
ORDER BY StartDate;
    






































WITH last_trans AS (
    SELECT 
	id,
        TransDate,
        Balance,
        ROW_NUMBER() OVER (PARTITION BY TransDate ORDER BY TransDate, id DESC) AS rnk
    FROM opay_Transactions
),
previous_day_balance AS (
    SELECT 
        TransDate,
        Balance, rnk,
        LAG(Balance, 1) OVER (ORDER BY TransDate, id DESC) AS prev_balance -- Correct previous day's balance
    FROM last_trans 
    WHERE rnk = 1)
SELECT * FROM previous_day_balance

),
flag AS (
    SELECT TransDate, prev_balance,
        Balance, 
        CASE WHEN Balance < prev_balance THEN 0 ELSE 1 END AS flag 
    FROM previous_day_balance
),
seq AS (
    SELECT TransDate, Balance, prev_balance, flag,
        SUM(flag) OVER (ORDER BY TransDate) AS seq
    FROM flag
),
consecutive_days AS (
    SELECT 
        seq, COUNT(*) AS ConsecutiveDays,
        MIN(TransDate) AS StartDate,
        MAX(TransDate) AS EndDate
    FROM seq
    WHERE Balance < prev_balance
    GROUP BY seq
)
SELECT 
    StartDate,
    EndDate,
    ConsecutiveDays
FROM consecutive_days
WHERE ConsecutiveDays > 4  -- Filter to show only decreasing periods longer than 4 days
ORDER BY StartDate;



