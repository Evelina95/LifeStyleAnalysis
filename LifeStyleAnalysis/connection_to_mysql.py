"""This script connects to a MySQL database and loads cleaned datasets into it.
---------------------------------------------------"""

import pandas as pd
from sqlalchemy import create_engine

# create a connection to the MySQL database
engine = create_engine("mysql+pymysql://root:User95@localhost/lifestyle_analysis")

# load cleaned datasets
df1 = pd.read_csv("final_data_clean.csv")
df2 = pd.read_csv("meal_metadata_clean.csv")

# Save the cleaned data to MySQL database
df1.to_sql("final_data", con=engine, if_exists="replace", index=False)
df2.to_sql("meal_metadata", con=engine, if_exists="replace", index=False)

print("data loaded successfully!")

