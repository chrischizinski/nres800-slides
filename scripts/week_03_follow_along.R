# NRES 800: Student Follow-Along Script
# Week 03: Importing Data and Project Paths
# Name: [Your Name]

# ---- 1. Setup ----
# Load the packages the instructor names.



# ---- 2. Live Coding Demo ----
# We are learning how to find files the same way on every machine.

# Check the project root.
# What does here() show you?


# Import the weather file the instructor uses.
# What does read_csv() guess about the columns?


# Import the messy stream gauge file.
# What does skip = 5 do here?


# Rename the discharge column so it is easier to work with.
# What changed: the data or the label?



# ---- 3. Weekly Challenge ----
# Problem:
# Import stream_gauge_messy.csv from the data folder.
# Skip the metadata rows and verify the column names.
#
# Base goal:
# - Use here() for the file path
# - Use read_csv() with skip = 5
# - Rename discharge_cfs to something easier to read
#
# Extension idea:
# - Check for a suspicious or impossible value
# - Compare two different skip values and explain which one is correct



# ---- 4. Verification ----
# Before you commit and push:
# - Does the script work after restarting R?
# - Are you using here() instead of setwd()?
# - Did you check the column names and a summary of the discharge column?
