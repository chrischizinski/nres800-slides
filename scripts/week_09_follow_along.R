# NRES 800: Student Follow-Along Script
# Week 09: Integrated Challenge I — From Raw Data to Plot
# Name: [Your Name]

# ---- 1. Setup ----
# Task: Load tidyverse, here, and lubridate.


# ---- 2. Step 1: Import & Inspect ----
# Task: Read macroinvertebrate_raw.csv using read_csv() and here().
# Hint: The file is in materials/week_09/data/

# TODO: Read the file and assign it to raw.


# Task: Inspect the data. Use nrow(), names(), head(), and str().
# How many rows are there? What are the column names?
# What problems do you see in SiteID and order_name?

# TODO: Inspect here.


# ---- 3. Step 2: Standardize SiteID and order_name ----
# Task: Use mutate() with str_to_upper(), str_remove_all(), str_trim(), and str_to_lower()
# to standardize SiteID (uppercase, no dashes) and order_name (lowercase, trimmed).
# Assign the result to cleaned.

# TODO: Your mutate() pipeline goes below.


# Task: Verify — how many unique SiteID values remain? How many unique order_name values?
# Use count() to check.

# TODO: Verify SiteID.


# TODO: Verify order_name.


# Row count check: how many rows in cleaned?

# TODO:


# ---- 4. Step 3: Filter Zeros and NAs ----
# Task: Remove rows where count is NA or count == 0.
# Assign the result to filtered.

# TODO: Your filter() pipeline goes below.


# How many rows were removed?

# TODO:


# ---- 5. Step 4: Summarize EPT Richness by Site ----
# Task: Filter to EPT orders only (ephemeroptera, plecoptera, trichoptera).
# Then group by SiteID and summarize:
#   - ept_richness: number of distinct EPT orders present (use n_distinct())
#   - ept_abundance: total count of EPT individuals (use sum())
#   - n_samples: number of records (use n())
#   - stream_order: keep the first value (use first())
# Assign the result to ept_summary.

# TODO: Your filter() |> group_by() |> summarize() pipeline goes below.


# Which site has the highest EPT richness?

# TODO:


# ---- 6. Step 5: Join to Site Lookup ----
# Task: Create a site_lookup tibble with SiteID and watershed columns.
# SiteIDs: NE01-NE10
# Watersheds (in order): Platte, Platte, Loup, Loup, Elkhorn, Elkhorn, Platte, Loup, Elkhorn, Platte
# Then left_join ept_summary to site_lookup by SiteID.
# Assign the result to ept_joined.

# TODO: Build site_lookup tibble here.


# TODO: Perform the left_join here.


# Check: did every site match? Are there any NAs in the watershed column?

# TODO:


# ---- 7. Step 6: Visualize EPT Richness by Stream Order ----
# Task: Create a point plot of ept_richness (y) vs stream_order (x).
# Treat stream_order as a factor (use factor()).
# Color points by watershed.
# Add informative labels (title, subtitle, x, y, color).
# Use theme_minimal().

# TODO: Your ggplot code goes below.


# ---- 8. Verification ----
# Before you commit and push:
# - Did you lose the expected number of rows when filtering?
# - Do all 10 SiteIDs appear in ept_summary?
# - Did the join produce any NAs in the watershed column?
# - Does the plot show a trend between stream order and EPT richness?
# - Are your labels informative (include units where applicable)?
