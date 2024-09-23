# Laptop-Data-Cleaning-SQL

This repository contains SQL scripts and the dataset used for cleaning and optimizing a laptop dataset. The project demonstrates the use of SQL for data cleaning, transformations, and optimizing data types to make the dataset more efficient for analysis.

📁 Project Overview
The project focuses on:

- Cleaning the dataset: Handling missing values, irrelevant data types, and inconsistencies.
- Data type optimization: Reducing memory usage by optimizing columns like Price, Ram, etc.
- Data transformation: Splitting combined columns like ScreenResolution and Gpu into separate meaningful columns for better 
  understanding and analysis.
- Standardization: Cleaning OpSys to create standardized categories.

🧠 Concepts and Techniques Used ->

This project utilizes several advanced SQL concepts to clean and transform the dataset:

1. CTEs (Common Table Expressions): Used to create temporary result sets for complex queries and make the code more readable.

2. Temporary Tables: Employed to store intermediate results and improve query performance during the data transformation process.

3. String Functions: Used for cleaning and extracting data:
   -- REPLACE(): To remove unwanted characters from strings (e.g., removing 'GB', 'kg').
   -- SUBSTRING_INDEX(): To extract parts of strings, such as splitting the Gpu and ScreenResolution fields into more                meaningful columns.
4. Basic Functions: Applied functions like ROUND() to standardize numerical values, and CASE to create categorical variables      for the OpSys column.

These techniques helped efficiently clean and optimize the dataset for analysis and ensured that the data was structured in a meaningful way for better insights.
