# NRES 800: Student Follow-Along Script
# Module 05: Summaries and Decisions
# Name: [Your Name]
# Date: 2026-10-05
#
# This file lives in class/. It is never checked or graded.
# Commit and push it before you leave class (participation evidence).
#
# Data: Great Lakes commercial fish production (Great Lakes Fishery
# Commission), via TidyTuesday 2021-06-08. 65,706 rows, used as released.
# `values` is catch in THOUSANDS OF POUNDS.
#
# Today's workflow:
#   clean data -> decide which rows count -> decide categories
#     -> group_by() -> summarize() -> check against a known total
#
# Blanks look like ___ . Type the code as we build it; do not copy/paste.


# ---- 0. Recap: Module 04 ----
# Answer in a comment BEFORE we discuss.
# 1. After read_csv(), what is the first function you run on real data, and
#    why?
#    Answer:
# 2. A filter dropped 39 of 109 rows. What must you report alongside the
#    answer you built on the other 70?
#    Answer:
# 3. What does 1987 %/% 10 * 10 give?
#    Answer:

library(tidyverse)
library(janitor)
library(here)

# Check the project root. It should print your repo folder.
here()


# ---- 1. One row per group ----

# 1.1 Import fishing.csv (in class/data/), check problems(), clean the
# names, and save the result as fishing.
fishing_raw <- read_csv(here(___, ___, ___))


fishing <- ___

# Did clean_names() change anything? (Hint: identical(names(...), names(...)))
#   Answer:

# glimpse() and summary(). Which column has missing values, and how many?
# What is strange about the minimum of values?
#   Answer:


# Show the rows where values is below zero.


# 1.2 count(): how many rows per lake? Per lake AND species?


# 1.3 summarize() the whole table: total of values.
fishing |>
  summarize(total = ___(values))

# Why is the answer NA?
#   Answer:

# Fix it, and report rows, number missing, total, and mean in ONE summarize().
fishing |>
  summarize(
    rows = ___,
    n_missing = ___,
    total = ___,
    mean = ___
  )


# 1.4 The same summary, one row per lake (group_by() first). Sort by total.


# 1.5 group_by(lake, species), then summarize the total.
# Read the message. What is the result still grouped by?
#   Answer:
# Make the message go away with .groups = "drop".


# 1.6 Total of values for lake whitefish ("Lake Whitefish") in Lake Michigan
# ("Michigan") in 2000. Write the number down.
#   Answer:


# ---- Challenge 1: Catch audit (15 min) ----
# Is your 1.6 number the U.S. commercial lake whitefish catch from Lake
# Michigan in 2000?
# Base goal:
# - Show the individual rows behind your total (keep region and values)
# - Compare your total with the "U.S. Total" row. How many times too big?
# - Use distinct(lake, region) to explain what the region column mixes
#
# Extension:
# - For every lake, compare the sum of all rows with the sum of its U.S.
#   total rows. Which lake is furthest off, and why is that ratio not only
#   double counting?

# Your code:



# Answer:
#   My total vs U.S. Total:
#   Why they differ:


# ---- 2. Categories you decide ----

# 2.1 if_else(): label each row "missing" or "recorded", then count().
# Then count by lake as well. Which lake has the most missing?
#   Answer:


# 2.2 case_when(): make a column region_level with four categories.
# Fill in the region names that belong in each vector (use distinct() above).
us_totals <- c(___)
canada_totals <- c(___)
state_totals <- c(___)

fishing <- fishing |>
  mutate(
    region_level = case_when(
      region %in% us_totals ~ "US total",
      ___ ~ "Canada total",
      ___ ~ "state total",
      .default = ___
    )
  )

# Check that every region landed where you meant:
fishing |>
  count(region_level, region)


# 2.3 The correct total per lake: U.S. total rows only, one row per lake,
# with rows, n_missing, and total. Save as us_by_lake and sort.
# Which lake's total would you trust least, and why?
#   Answer:


# 2.4 case_when() with years: make an era column with four periods
# (before 1900, 1900-1949, 1950-1999, 2000-2015) and count() it.
# Then move the year < 2000 line to the top. What happens, and why?
#   Answer:


# ---- Challenge 2: Clean the species list (15 min) ----
# Base goal:
# - count(species). Find labels that are the same fish spelled differently.
# - Recode them with case_when() inside mutate(); keep everything else with
#   .default = species. Reassign to fishing.
# - Count again. How many species labels remain?
#
# Extension:
# - How many lakes report each species in the 2000s (U.S. totals, known
#   values)? Hint: n_distinct().
# - Are "Drum" and "Freshwater Drum" the same fish? What would you check
#   before merging them?

# Your code:



# Answer:
#   Labels before:       after:


# ---- Break ----


# ---- Integrated challenge (30 min) ----
# Lake whitefish, Lake Michigan, U.S. catch: total catch by decade, with the
# number of years and missing years beside each total. Which decade peaked?
#
# Base goal:
# - One pipeline: filter (lake, species, region level) -> decade with mutate()
#   -> group_by() -> summarize() years, n_missing, catch -> sort
# - Answer in a comment: peak decade and its catch (in pounds, not
#   thousands)
#
# Extension:
# - The 2010s total looks low. Compute catch per recorded year. Does the
#   story change? Which decade "wins" now, and should you trust it?
# - Repeat for another lake. Read the comments for that species first.

# Your code:



# Answers:
#   Peak decade and catch:
#   Per-year view changes the story because:


# ---- 4. Before you leave ----
# [ ] Script runs from top to bottom after restarting R
# [ ] Commit and push class/ (Source Control in Positron, or GitHub Desktop:
#     write a summary, Commit to main, then Push origin)
# [ ] Check the push shows on GitHub
#
# Assignment 05 - Park Species Decisions (due Sun Oct 11, 11:59 PM)
# - Open assignment/assignment.qmd (not this file)
# - Graded: assignment/ and README.md only
