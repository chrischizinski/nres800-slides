# NRES 800: Student Follow-Along Script
# Week 02: R Objects, Data Frames, and Debugging
# Name: [Your Name]

# ---- 1. Setup ----
# Load the packages used in today's code-along and challenge.
library(tidyverse)
library(here)

# ---- 2. Live Coding Demo ----
# We are learning how R stores objects and how to read errors.

# Create a numeric vector and a character vector.
site_counts <- c(10, 15, 8, 22)
site_names <- c("Site A", "Site B", "Site C", "Site D")

# Combine them into a data frame.
sites_df <- data.frame(name = site_names, count = site_counts)

# Inspect the object structure.
str(sites_df)
glimpse(sites_df)
class(sites_df$count)
sites_df$name

# What happens when a number is stored as text?
mixed_values <- c(10, 20, "thirty", 40)
class(mixed_values)

# ---- 3. Weekly Challenge ----
# 1. Open the Week 02 Debugging Clinic repository from the link in the slides.
# 2. Open debug_this.R. It contains three intentional bugs.
# 3. For each fix, add a short comment that explains the cause of the error.
# 4. Run the script from top to bottom after each change.
#
# The three bugs are:
# - an object name typo
# - pH stored as text when the script tries to do arithmetic
# - a plot object created but not displayed
#
# Extension:
# - Convert sample_date to a Date object.
# - Create pass_fail: TRUE when pH is between 6.0 and 7.5, otherwise FALSE.

# ---- 4. Verification ----
# Before you leave class:
# - Does debug_this.R run from top to bottom?
# - Does the Environment pane show soil_samples, ph_plot, and pass_fail?
# - Can you explain each error and its fix in plain language?
# - Did you replace the README paragraph with 2-3 sentences of your own?
# - We upload together at the start of class (last time!). Due Tue, Sep 22.
# - Assignment 03 is open in Classroom 50: do it at home, push from home,
#   due Sun, Sep 27, 11:59 PM. Written answers go as # comments in the script.
