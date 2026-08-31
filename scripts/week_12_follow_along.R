# NRES 800: Student Follow-Along Script
# Week 12: Messy Imports and Repeated Files
# Name: [Your Name]

# ---- 1. Setup ----
# Task: Load tidyverse, fs, readxl, and here.



# ---- 2. The Copy-Paste Problem ----
# Look at the anti-pattern the instructor shows. Answer in a comment:
# What breaks when someone adds a 4th year of data to the folder?

# YOUR ANSWER:


# ---- 3. Live Coding Demo ----

# Step 1: Use fs::dir_ls() to list all CSV files in the data directory.
# Store the result in an object called csv_files.



# Inspect it: what class() is csv_files? How many files?


# Step 2: Use map() + list_rbind() to read all files into a single data frame.
# Use the .id argument to record the source file name.
# Store the result in all_counts_raw.



# Use glimpse() to inspect the result.


# Step 3: Detect the column mismatch.
# Count how many NAs are in the 'notes' column per source file.
# What does this tell you about which files had the column and which did not?



# Step 4: Extract the year from source_file using str_extract() and mutate().
# Drop source_file and notes columns when you are done.
# Store the final result in all_counts.



# Step 5: Reading Excel (follow along with the instructor — no workbook file needed today).
# Write the code you would use to:
# (a) List the sheet names of a workbook called 'monitoring_workbook.xlsx'



# (b) Read only the sheet called "Raptor Survey" from that workbook.



# ---- 4. Weekly Challenge ----
# Problem: Use all_counts to answer the question:
# "How has total species count changed across sites from 2021 to 2023?"
#
# Steps:
# 1. Group by year and site_id.
# 2. Summarize total_count (sum of count) and n_species (n_distinct species).
# 3. Plot total_count over year, with lines colored by site_id.
# 4. Apply professional labels and theme_minimal().

# TODO: Your code goes below.




# ---- 5. Verification ----
# Before you commit and push:
# - Does your combined data frame have rows from all three years?
# - Did you confirm where the NA values in 'notes' came from?
# - Can you explain in one sentence why list_rbind() is better than rbind() here?
# - How many lines of code would change if a 2024 file appeared in the folder?
