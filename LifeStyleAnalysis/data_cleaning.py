"""
Data Cleaning Script for Lifestyle Analysis Project
---------------------------------------------------
- Loads and inspects two CSV datasets 
- Normalizes column names
- Checks and reports missing values
- Changes column names for consistency
- Removes duplicates
- Rounds age column to nearest integer
- Saves cleaned data to new CSV files
"""

import pandas as pd

# Error handling for file loading
try:
    df1 = pd.read_csv("Data/Final_data.csv")
    df2 = pd.read_csv("Data/meal_metadata.csv")
except FileNotFoundError as e:
    print("File is not found:", e)

# Load the datasets, checking their structure and contents(what columns they have, how many rows, etc.)
df1 = pd.read_csv("Data/Final_data.csv")
df2 = pd.read_csv("Data/meal_metadata.csv")

print(df1.info())
print(df1.head())
print(df2.info())
print(df2.head())

# Check for null values in both datasets
print(df1.isnull().sum())
print(df2.isnull().sum())

# Cheking columns in both datasets
df1.columns = df1.columns.str.strip().str.lower().str.replace(" ", "_")
df2.columns = df2.columns.str.strip().str.lower().str.replace(" ", "_")
print(df1.columns)
print(df2.columns)

# Change column name for consistency
df1.rename(columns={"session_duration_(hours)": "session_duration_hours"}, inplace=True)
df2.rename(columns={"session_duration_(hours)": "session_duration_hours"}, inplace=True)

# Search for missing values in both datasets
missing_df1 = df1.isnull().sum()
missing_df2 = df2.isnull().sum()
print("Missing values in df1:\n", missing_df1[missing_df1 > 0])
print("Missing values in df2:\n", missing_df2[missing_df2 > 0])

# Rounding age column in df1 to nearest integer
df1["age"] = df1["age"].round().astype(int)
df2["age"] = df2["age"].round().astype(int)


print(df1["age"].head())
print(df2["age"].head())

# Remove duplicate rows in both datasets
df1 = df1.drop_duplicates()
df2 = df2.drop_duplicates()
print("Duplicates removed from df1, new shape:", df1.shape)
print("Duplicates removed from df2, new shape:", df2.shape)

# Save cleaned datasets to new csv files
df1.to_csv("final_data_clean.csv", index=False)
df2.to_csv("meal_metadata_clean.csv", index=False)
