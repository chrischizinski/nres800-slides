# NRES 800: Student Follow-Along Script
# Week 05: Rows, Columns, and New Variables
# Name: [Your Name]

# ---- 1. Setup ----
# Task: Load tidyverse and here. Then load ne_deer_harvest.csv using here().



# After loading: run glimpse() and summary() on the dataset.
# Where do NA values appear?



# ---- 2. Live Coding Demo ----
# Follow along with the instructor.

# filter() — Single condition (rifle season only):


# filter() — Multiple conditions (rifle season AND Buck):


# filter() — Numeric comparison (years after 2018):


# filter() — Remove rows where harvest_count is NA:


# How many rows did we lose? Use nrow() on both versions.



# select() — Keep only county, year, sex, harvest_count:


# select() with rename — rename harvest_count to "harvest" and hunter_days to "days":


# arrange() — Sort by harvest_count ascending, then descending:



# mutate() — Calculate harvest per hunter day (cpue = harvest_count / hunter_days):
# Remember: filter out NAs from both columns first.


# mutate() with case_when() — Classify cpue as "High", "Moderate", or "Low":
# High: cpue >= 0.20
# Moderate: cpue >= 0.12
# Low: cpue < 0.12



# ---- 3. Weekly Challenge ----
# Problem: Which NE county had the largest increase in doe harvest from 2020 to 2022?
# Use ne_deer_harvest.csv (already loaded above).
#
# Steps:
# 1. filter() to Doe, rifle season, Adult age class. Remove NAs.
# 2. select() only the columns you need (county, year, harvest_count).
# 3. filter() to years 2020 and 2022 only.
# 4. Use pivot_wider() to put each year's harvest in its own column.
# 5. mutate() to calculate the change (2022 - 2020) and percent change.
# 6. arrange() by the change column to find the largest increase.

# TODO: Your code goes below.



# ---- 4. Verification ----
# Before you commit and push:
# - Does your filter() reduce the dataset to only the rows you intended? Check with nrow().
# - Did you remove NA values before calculating cpue?
# - Does your final challenge table show county names and a numeric change column?
# - Can you explain the difference between filter() (rows) and select() (columns)?
