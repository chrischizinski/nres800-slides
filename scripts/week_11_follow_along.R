# NRES 800: Student Follow-Along Script
# Week 11: Dates and Time-Series Data
# Name: [Your Name]

# ---- 1. Setup ----
# Task: Load tidyverse, lubridate, and here.



# ---- 2. Live Coding Demo ----
# Follow along with the instructor.

# Step 1: Load and inspect
# Load the stream_discharge.csv dataset using here().


# Use glimpse() to inspect the data. What class is date_recorded?


# STOP AND THINK: Why did R read date_recorded as character instead of Date?

# Step 2: Inspect raw date strings across sites
# Use select() + slice() to look at date_recorded for rows from different sites.


# What three date formats do you see?
# Format 1:
# Format 2:
# Format 3:

# Step 3: Parse mixed formats using parse_date_time()
# Use mutate() to create a new column date_parsed.
# Hint: parse_date_time(col, orders = c("ymd", "mdy", "BdY"))


# Check for parse failures using summarise() and sum(is.na(date_parsed)).


# Step 4: Extract date components
# Create columns for year, month (as labeled factor), and day-of-year.
# Hint: year(), month(label = TRUE, abbr = TRUE), yday()


# What class is the 'mo' column? Run class() to check.


# Step 5: Floor dates for monthly aggregation
# Create a new column month_floor using floor_date(date_parsed, unit = "month").


# Verify by selecting date_parsed and month_floor for the first 5 rows.


# Step 6: Monthly mean discharge per site
# Filter out rows where discharge_cfs is NA.
# Group by site_id and month_floor.
# Summarise to get mean_discharge, sd_discharge, and n_obs.


# Step 7: Plot the time series
# Build a line + point plot of mean_discharge over month_floor, colored by site_id.
# Add scale_x_datetime() with date_breaks = "2 months" and date_labels = "%b %Y".
# Add informative labs() and theme_minimal().


# Step 8: Seasonal summary
# Group the original data by month (mo and mo_num), calculate mean discharge,
# and arrange by mo_num.


# Build a bar chart (geom_col) of mean_discharge by mo.



# ---- 3. Weekly Challenge ----
# Problem: Does discharge peak in spring across all Platte River monitoring sites,
# and which site has the most variable flow?
#
# Steps:
# 1. Parse all dates (you should already have date_parsed from Step 3 above).
# 2. Extract month number and labeled month from date_parsed.
# 3. Group by site_id and month, then calculate mean_q, sd_q, and coefficient
#    of variation (cv_q = sd_q / mean_q).
# 4. Identify which site has the highest overall CV.
# 5. Plot mean monthly discharge by site using geom_line + geom_point,
#    faceted or colored by site_id.

# TODO: Your code goes below.



# ---- 4. Verification ----
# Before you commit and push:
# - Did parse_date_time() produce zero NAs in date_parsed?
# - Does your line plot have readable x-axis labels (month names)?
# - Can you identify the month of peak discharge for each site by looking at the plot?
# - Can you explain in one sentence why floor_date is useful for monthly summaries?
