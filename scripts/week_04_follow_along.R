# NRES 800: Student Follow-Along Script
# Module 04: Clean and Shape Columns
# Name: [Your Name]
# Date: 2026-09-28
#
# This file lives in class/. It is never checked or graded.
# Commit and push it before you leave class (participation evidence).
#
# Data: Great Lakes Fish Stocking Database (Great Lakes Fishery Commission),
# via TidyTuesday 2021-06-08. 56,232 stocking events, used as released.
#
# Today's workflow:
#   messy file -> import -> clean_names() -> check types -> fix types
#     -> select() -> filter() (count rows) -> arrange() -> mutate() -> answer
#
# Blanks look like ___ . Type the code as we build it; do not copy/paste.


# ---- 0. Recap: Module 03 ----
# Answer in a comment BEFORE we discuss.
# 1. weather_raw.csv had two lines above the header. What argument fixed it?
#    Answer:
# 2. What did clean_names() turn "Age (Years)" into?
#    Answer:
# 3. Do filter(!is.na(x)) and drop_na(x) give the same result?
#    Answer:

library(tidyverse)
library(janitor)
library(here)

# Check the project root. It should print your repo folder.
here()


# ---- 1. Trustworthy columns ----

# 1.1 Import the stocking file (it is in class/data/).
# Read the message R prints. Do not skip it.
stocked_raw <- read_csv(here(___, ___, ___))

# What did R warn you about?
#   Answer:

# Where are the details? Run the function R suggests:


# 1.2 How many rows and columns? What are the columns called?


# 1.3 Clean the names and SAVE the result as stocked.
stocked <- ___ |>
  ___()

# 1.4 Check the types with glimpse().

# Which columns look like numbers but are stored as <chr>?
#   Answer:
# How can you tell?
#   Answer:

# 1.5 Why is mark_eff text? Count its values.


# 1.6 Fix option A: convert with as.numeric() and save as mark_eff_num.
# What warning appears? How many values became NA because of it?


# 1.7 Fix option B: re-import, telling read_csv() which values mean missing.
# Hint: na = c(___, ___, ___)


# Run problems() again. How many problems now, and in which columns?
#   Answer:

# Look only at the problems in column 23. What is in that cell?
#   Answer:
# Why is this problem more dangerous than a <chr> column?
#   Answer:

# 1.8 Use summary() on length and on day.
# Which values are impossible, and what might they be?
#   Answer:

# Show the rows where length is 999.99 or day is 0.


# 1.9 Fix option C: declare a column type at import with col_types.
# Read WEIGHT as text.



# ---- Challenge 1: Type detective (15 min) ----
# The WEIGHT column broke R's guess in 22 rows.
# Base goal:
# - Import with WEIGHT read as text (and your missing codes), clean names
# - Find the weight values that are not plain numbers (count them)
# - Convert weight to a number with the readr function that drops commas
#   and trailing text
# - Prove it worked: glimpse() and an NA count
#
# Extension:
# - What does ".9 /K" become? Is that correct? What would you ask the
#   people who collected the data?

# Your code:




# ---- 2. The rows and columns you need ----

# 2.1 select(): try each form and look at the result.
# By name (year, lake, species, no_stocked):

# A range (year through lake):

# Drop tag_no, tag_ret, ls_mgmt:

# Columns starting with "tag":

# Columns containing "stock":

# Build stocking_core together: the columns a manager needs.
stocking_core <- stocked |>
  select(___)

# 2.2 filter(). Count rows before and after EVERY filter with nrow().
# Total rows:

# Lake Superior only (lake code "SU"). Save as superior.

# Try filter(lake = "SU"). Read the error. What is R asking?
#   Answer:

# Lake Superior AND lake trout ("LAT"). Save as superior_lat.

# Lake Erie OR Lake Ontario ("ER", "ON"), two ways: | and %in%.

# Stocked in 2010 or later:

# Stocked in the 1990s (use between()):

# Rows with a recorded month:

# Count rows with length > 100 and rows with !(length > 100).
# Do they add up to the total? Where did the rest go?
#   Answer:

# 2.3 arrange(): sort superior_lat three ways
# smallest no_stocked first, largest first, by year then largest first.



# ---- Challenge 2: Three manager questions (15 min) ----
# One pipeline per question. Report nrow() for each answer.
#
# Q1: Lake trout (LAT) stocked in Lake Superior (SU) by Wisconsin (WI) since
#     2000, largest events first. Which site and year is at the top?
#
# Q2: Chinook or coho salmon (CHS, COS) stocked in Lake Michigan (MI) in the
#     1990s.
#
# Q3: Walleye (WAE) events in Lake Erie (ER) with no recorded month.
#
# Extension: write a question whose answer has 0 rows. Does 0 rows mean it
# never happened? Explain in a comment.

# Q1:

# Q2:

# Q3:

# Extension:



# ---- Break ----


# ---- 3. New variables and the whole pipeline ----

# 3.1 mutate(): add fish_thousands (no_stocked / 1000, rounded to 1 decimal)
# and decade. Hint for decade: %/% is integer division; 1987 %/% 10 is 198.
# Did stocking_core change? Check names(). Then reassign so it does.


# Move decade next to year with relocate().


# 3.2 The whole pipeline in one piece: raw file -> clean names -> select
# -> filter to walleye (WAE) in Lake Huron (HU) in the 2010s.
# Save as huron_walleye. How many rows?


# 3.3 Save stocking_core to class/data/processed/stocking_core.csv.
# Never overwrite the raw file.



# ---- Integrated challenge ----
# Lake Huron walleye, 2010s: after dropping events with no recorded length,
# which event stocked the largest fish? How many events did you drop?
#
# Base goal:
# - Count rows before, drop missing length, count rows after
# - Sort so the largest fish are first
# - Answer both questions in a comment
#
# Extension:
# - count(stage) on the full data. How many codes do you see, and how many
#   real stages? Make the codes consistent (hint: stringr, str_to_lower()).
# - 39 of 109 events had no length. Is the "largest fish" answer
#   trustworthy? Explain.

# Your code:



# Answers:
#   Largest fish:
#   Events dropped:


# ---- 4. Quarto intro ----
# Open class/first_report.qmd and follow along.
# Where do written answers go in a Quarto document?
#   Answer:


# ---- 5. Before you leave ----
# [ ] Script runs from top to bottom after restarting R
# [ ] Commit and push class/ (Source Control in Positron)
# [ ] Check the push shows on GitHub
#
# Assignment 04 - Wildlife Strikes Cleanup (due Sun Oct 4, 11:59 PM)
# - Open assignment/assignment.qmd (not this file)
# - Graded: assignment/ and README.md only
