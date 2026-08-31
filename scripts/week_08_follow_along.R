# NRES 800: Student Follow-Along Script
# Week 08: Joining Tables
# Name: [Your Name]

# ---- 1. Setup ----
# Task: Load tidyverse and here.



# ---- 2. Live Coding Demo ----
# Follow along with the instructor.

# Load both datasets and inspect their dimensions:
# bird_observations.csv  (in materials/week_08/data/)
# site_metadata.csv      (in materials/week_08/data/)



# Check how many rows each table has using nrow().



# Look at the unique site_ids in each table using distinct() and arrange().
# Which site_ids appear in observations but NOT in site_metadata?



# left_join: join obs to sites, keeping ALL observation rows.
# Which join argument tells R which column to match on?



# After your left_join, check nrow(). Did the row count change?
# Use filter(is.na(habitat_type)) to find rows with no matching site.



# inner_join: join obs to sites, keeping ONLY matched rows.
# Compare nrow() between your left_join result and your inner_join result.



# anti_join: find observation rows with NO match in site_metadata.
# Print the obs_id, site_id, species, and date of unmatched records.



# Row count verification — fill in the cat() statements:
cat("Original observations:          ", ___, "\n")
cat("After left_join (with sites):   ", ___, "\n")
cat("After inner_join (only matched):", ___, "\n")
cat("Unmatched observations:         ", ___, "\n")



# ---- 3. Weekly Challenge ----
# Problem: Which habitat types support the highest species richness,
#   and are there any observation sites missing from our site registry?
#
# Steps:
#   1. Use anti_join to identify and print unmatched site_ids.
#   2. Use left_join to combine obs with site metadata.
#      Then filter out rows where habitat_type is NA (the unregistered sites).
#   3. Use group_by(site_id, habitat_type) and summarize() to calculate
#      species_richness (n_distinct(species)) and total_count (sum) per site.
#   4. Use group_by(habitat_type) and summarize() to get mean richness per habitat.
#   5. Create a boxplot or bar plot of species richness by habitat type.
#      Use scale_fill_viridis_d() and theme_minimal().

# TODO: Your code goes below.



# ---- 4. Verification ----
# Before you commit and push:
# - Does your left_join result have the same number of rows as the original obs table?
# - Did anti_join reveal any unmatched sites? What are their site_ids?
# - Does your final plot have informative axis labels and a title?
# - Can you explain in one sentence why left_join is safer than inner_join
#   when you want to audit your data first?
