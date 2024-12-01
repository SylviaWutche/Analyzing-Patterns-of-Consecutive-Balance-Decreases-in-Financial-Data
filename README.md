# Analyzing-Patterns-of-Consecutive-Balance-Decreases-in-Financial-Data


Problem Statement
The objective was to analyze financial data to identify periods where account balances decreased for more than 4 consecutive days. This helps monitor financial health, detect risks, and improve decision-making for budgeting and cash flow management.

Steps Taken
Data Preparation:

The dataset, spanning June 4 to November 23, 2024, was provided as a PDF file containing transaction records.
Using Power Query, the dataset was cleaned and structured:
1. Extracted tables from the PDF
2. Addressed errors, blank rows, and inconsistencies
3. Ensured key fields like transaction dates and balances were properly formatted
4. The cleaned dataset was then uploaded into a PostgreSQL database for analysis

Analysis:

A SQL query was developed to:
1. Extract the last recorded balance for each day.
2. Use previous day balances to identify consecutive decreases.
3. Group consecutive days with balance declines into distinct periods.
4. Filter periods where balances dropped for more than 4 consecutive days.

Results

The analysis identified five periods of concern during the dataset timeframe:

![Result](https://github.com/SylviaWutche/Analyzing-Patterns-of-Consecutive-Balance-Decreases-in-Financial-Data/blob/main/result2.jpg)

**Visualization**

The following bar chart visualizes the periods of consecutive balance decreases:

![Visual](https://github.com/SylviaWutche/Analyzing-Patterns-of-Consecutive-Balance-Decreases-in-Financial-Data/blob/main/Periods%20of%20Balance%20Decrease%20with%20Start%20and%20End%20Dates.jpeg)

X-Axis: Periods (start and end dates) of balance decreases
Y-Axis: Number of consecutive days the balance decreased

*The longest streak was 10 days, from August 23 to September 1, 2024*

## Key Insight
The analysis highlighted five distinct periods where account balances dropped for more than 4 consecutive days. The longest period lasted 10 days, signaling potential financial instability, overspending, or other inefficiencies.

How This Can Help?

**Financial Monitoring:**
Set alerts for prolonged balance declines to take corrective action early

**Budget Planning:**
Use these insights to identify and reduce expenses during high-risk periods

**Risk Management:**
Mitigate risks by ensuring sufficient reserves or adjusting cash flow during declining periods

**Operational Improvements:**
Understand spending patterns and link declines to specific events or activities for better operational decisions

**Proactive Decision-Making:**
Financial stakeholders can use this data to optimize resource allocation and maintain financial stability.

Conclusion
This project utilized financial transaction data from June 4 to November 23, 2024, to identify significant periods of consecutive balance decreases
By leveraging tools like Power Query and PostgreSQL, I gained actionable insights that support effective financial planning, risk mitigation, and improved stability
