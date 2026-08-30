# NRES 800: Student Follow-Along Script
# Week 13: Functions for Repeated Work
# Name: [Your Name]

# ---- 1. Setup ----
# Task: Load tidyverse and here. Then load the FeederWatch data from Week 06.


# Load data: here("data", "feeder_watch_raw.csv")


# ---- 2. Live Coding Demo: Anatomy of a Function ----
# Follow along with the instructor.

# 2a. The simplest possible function — fill in the body:
# add_two <- function(x) {
#
# }

# Call your function on a few test values:


# 2b. What happens when you pass the wrong type? Try it:


# ---- 3. Writing summarize_species() ----
# Build a function that:
#   - Takes: a data frame, a state abbreviation string, and n_top (default 5)
#   - Filters to the given state, removes NA and zero counts
#   - Groups by species_code, summarizes total_obs, n_sites, mean_count
#   - Returns the top n_top rows sorted by total_obs

# TODO: Write the function here.
# summarize_species <- function(data, state_filter, n_top = 5) {
#
# }

# Test on NE:


# Test on IA:


# Test with a custom n_top (e.g., 3):


# ---- 4. Input Validation with stopifnot() ----
# Add at least one stopifnot() check to your summarize_species() function above.
# Then deliberately break it — call the function with a bad argument and read the error.

# Try passing a number instead of a string for state_filter:


# Try passing a vector of two states:


# ---- 5. Using the Function Inside map() ----
# Create a list of state abbreviations: NE, IA, KS
states_of_interest <- list("NE", "IA", "KS")

# Use map() to apply summarize_species() to each state.
# Hint: map(states_of_interest, \(s) your_function(fw, s))


# Bind the list of tibbles into a single data frame using list_rbind():


# ---- 6. Using a Helper Function Inside mutate() ----
# Write a classify_abundance() function that returns "High" (>= 500),
# "Medium" (>= 100), or "Low" for a given total_obs value.

# classify_abundance <- function(total) {
#
# }

# Apply it inside mutate() using map_chr():


# ---- 7. Weekly Challenge ----
# Problem: Write a top_n_species() function that takes:
#   - data       : the feeder watch data frame
#   - state_filter: a single state abbreviation string
#   - n           : number of top species to return (default 5)
# The function must:
#   - Include at least one input validation (stopifnot or if/stop)
#   - Return a ranked summary with total_obs, n_sites, mean_count, and rank columns
# After writing it:
#   1. Test it on NE.
#   2. Test it on IA.
#   3. Apply it via map() to c("NE", "IA", "KS") and bind the results.

# TODO: Write top_n_species() here.


# Test on NE:


# Test on IA:


# Apply via map() and bind:


# ---- 8. Verification ----
# Before you commit and push:
# - Does your function return the correct number of rows when n = 5? n = 3?
# - Does it stop with a clear error message if you pass 42 as state_filter?
# - Can you explain in one sentence what return() does inside a function body?
# - Can you explain why using a function is better than copy-pasting the pipeline?
