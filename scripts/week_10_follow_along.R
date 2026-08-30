# NRES 800: Student Follow-Along Script
# Week 10: Strings and Categorical Cleanup
# Name: [Your Name]

# ---- 1. Setup ----
# Task: Load tidyverse, janitor, forcats, and here.



# ---- 2. Live Coding Demo ----
# Follow along with the instructor.

# Step 1: Import and clean column names.
# Use read_csv() to load "data/crop_survey_messy.csv", then pipe into clean_names().



# Inspect: use glimpse() and count() to see how many distinct values are in
# 'state', 'crop_type', and 'farm_size_category'.



# Step 2: Standardize text columns.
# Inside mutate(), apply str_trim() and str_to_lower() to state, crop_type,
# and farm_size_category. Chain with |>.
# Store the result back in crop_clean (or a new object).



# Verify: run count() again on the cleaned columns. How did the counts change?



# Step 3: Standardize state codes.
# Use str_replace() inside mutate() to collapse "nebraska" into "ne".



# Verify: count(crop_clean, state) should now show only "ne".



# Step 4: Standardize crop_type.
# Use str_replace() to recode "soy" -> "soybean" and "soybeans" -> "soybean".
# Hint: anchor the "soy" pattern with ^ and $ so it only matches the full word.



# Verify: count(crop_clean, crop_type) should show only "corn" and "soybean".



# Step 5: Use str_detect() inside filter().
# Filter to rows where notes contains the word "irrigat" (partial match).
# Select county, crop_type, and notes to inspect the results.



# Step 6: Factor reordering with forcats.
# Summarize mean yield by crop_type and farm_size_category.
# Then use fct_relevel() to set the order: "small", "medium", "large".



# Build a grouped bar chart (geom_col with position = "dodge") of mean yield
# by farm_size_category, filled by crop_type. Apply theme_minimal().



# ---- 3. Weekly Challenge ----
# Problem: Use crop_survey_messy.csv.
# Question: Which crop type has the highest average yield in Nebraska,
# and does farm size matter?
#
# Required steps:
# 1. Import and clean names with janitor.
# 2. Standardize state, crop_type, and farm_size_category with str_trim, str_to_lower, str_replace.
# 3. Filter to state == "ne" and remove rows with missing reported_yield_bu_ac.
# 4. Use fct_relevel() to order farm_size_category as small -> medium -> large.
# 5. Summarize mean yield by crop_type and farm_size_category.
# 6. Build a boxplot faceted by crop_type with professional labels and theme_minimal().

# TODO: Your code goes below.



# ---- 4. Verification ----
# Before you commit and push:
# - Does count(crop_clean, state) show exactly ONE distinct value ("ne")?
# - Does count(crop_clean, crop_type) show exactly TWO values ("corn", "soybean")?
# - Does count(crop_clean, farm_size_category) show exactly THREE values ("small", "medium", "large")?
# - Are the x-axis categories in your plot ordered small -> medium -> large?
# - Can you explain why str_trim() should run BEFORE str_to_lower()?
