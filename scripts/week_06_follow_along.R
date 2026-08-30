# NRES 800: Student Follow-Along Script
# Week 06: Grouped Summaries
# Name: [Your Name]

# ---- 1. Setup ----
# Task: Load tidyverse and here.



# ---- 2. Load Data ----
# Task: Read in feeder_watch_raw.csv using read_csv() and here().
# Store the result as 'birds'. Then inspect it with glimpse() and summary().



# ---- 3. Live Coding Demo ----

# Global summary (no grouping):
# Use summarize() to calculate the total count (sum of how_many) and number of records (n()).
# Do NOT use group_by() yet. How many rows does the result have?



# Group by state:
# Add group_by(state) before your summarize(). How many rows now?



# Multiple summaries + n_distinct():
# In one summarize() call, calculate:
#   - total_obs   = total count of how_many (handle NA)
#   - n_records   = number of rows
#   - n_sites     = number of distinct site_id values
#   - mean_count  = average how_many (handle NA)



# NA demonstration:
# In a single summarize(), create two columns:
#   - sum_with_na    = sum(how_many)             [no na.rm]
#   - sum_without_na = sum(how_many, na.rm = TRUE)
# Group by state. Compare the two columns. What do you notice?



# Group by multiple columns:
# Group by both state and month, then summarize total_obs and n_sites.
# Add .groups = "drop" inside summarize().



# Arrange descending:
# Group by species_code, summarize total_obs and n_sites, then
# arrange the result from most to least total_obs.



# ---- 4. Weekly Challenge ----
# Problem: Identify the Top 5 most frequent species in Nebraska during January.
#
# Steps:
# 1. Filter to state == "NE" and month == 1.
# 2. Remove rows where how_many is NA or 0.
# 3. Group by species_code.
# 4. Summarize: total_obs = sum(how_many, na.rm = TRUE), n_sites = n_distinct(site_id).
# 5. Arrange descending by total_obs.
# 6. Keep only the top 5 rows using slice_head(n = 5).
#
# Constraint: use the native pipe |> at least once.

# TODO: Your code goes below.



# ---- 5. Verification ----
# Before you commit and push:
# - Does your top-5 table have exactly 5 rows?
# - Did you use summarize() to create at least two new columns?
# - Did you explain your NA decision in a comment?
# - Can you explain in one sentence what n_distinct() counts that n() does not?
