# NRES 800: Student Follow-Along Script
# Module 06: Tidy Data (short module) + Your Project Repository
# Name: [Your Name]
# Date: 2026-10-26
#
# This file lives in class/. It is never checked or graded.
# Commit and push it before you leave class (participation evidence).
#
# HOW THIS FILE GOT HERE
# Your instructor added this file and class/data/drought.csv to your
# Module 05 repo on GitHub. You brought them down with a PULL, the same way
# you got the Part 2 file on Oct 12. Nothing you wrote was changed.
#
# Today's workflow:
#   read the wide table -> ask what each column MEANS
#     -> pivot_longer() to tidy -> summarize -> pivot_wider() to show
#
# How each step works (same as Module 05):
#   GOAL    what we are making
#   WHY     what goes wrong without it
#   PATTERN the shape of the code
#   Worked example: run it and read the output. It uses tiny made-up data.
#   Your turn: the same pattern on the real data. Blanks look like ___ .
#   CHECK   the number you should get. If you match, move on.
#
# Second half of class: you create your semester project repository.
# Instructions are in the book chapter "Your Project Repository".


# ---- 0. Setup ----
# Do this: Session > Restart R, then run this block.

library(tidyverse)
library(janitor)
library(here)

drought <- read_csv(here("class", "data", "drought.csv")) |>
  clean_names()

dim(drought)
# CHECK: 73344 14

# The data: share of each state's area in each dryness or wetness class,
# every month from 1895 to 2022, lower 48 states. Source: NOAA 9-month
# Standardized Precipitation Index (SPI), via drought.gov and TidyTuesday
# 2022-06-14.
#   d0 abnormally dry    d1 moderate drought   d2 severe drought
#   d3 extreme drought   d4 exceptional drought
#   w0-w4 the same five classes on the wet side
#   x0 and x9 came from columns named "0" and "-9" (clean_names() renamed
#   them). The source does not define them; the numbers suggest x0 is
#   "neither dry nor wet" and x9 is "no data". We do not use them today.
#
# Look at the column names. Which ones are really values of ONE variable
# ("dryness class") spread across several columns?
#   Answer:


# ---- 1. Read the wide table before you reshape it ----
# GOAL: understand what one row says.
# WHY:  if you reshape before you know what the numbers mean, you can
#       produce a tidy table that answers the wrong question.

# Your turn: Nebraska, August 2012.
drought |>
  filter(state == ___, date == ___)     # dates look like "d_20120801"

# What percent of Nebraska was in SEVERE drought (d2)?
#   Answer:

# Add d0 + d1 + d2 + d3 + d4 for that row (by hand, or type the five
# numbers into the console with + between them).
#   Sum:
# CHECK: 381.3
# A state cannot be 381% covered. What must each column mean?
# (Hint: compare d0 and d4. Which is always bigger?)
#   Answer:


# ---- 2. pivot_longer(): wide to tidy ----
# GOAL:    one row per state, month, and dryness class.
# WHY:     with the class as a column, group_by() and ggplot() can use it.
#          With five separate columns, every summary needs five lines.
# PATTERN: pivot_longer(columns to stack,
#                       names_to  = "new column for the old names",
#                       values_to = "new column for the numbers")
#
# Worked example:
plots <- tibble(
  plot  = c("A", "B"),
  y2024 = c(12, 7),
  y2025 = c(15, 9)
)
plots
plots |>
  pivot_longer(c(y2024, y2025), names_to = "year", values_to = "count")
# 2 rows x 2 year columns -> 4 rows.

# Your turn: keep state, date, and the five dry columns, then stack them.
# Name the new columns exactly "category" and "pct_area": the code below
# uses those names.
drought_long <- drought |>
  select(state, date, ___) |>
  pivot_longer(
    ___,
    names_to = ___,
    values_to = "pct_area"
  )

nrow(drought_long)
# CHECK: 366720
# Before you move on, explain the number: 366720 = 73344 x ___ . Why?
#   Answer:

# Make a year column. Dates are text like "d_20120801"; characters 3 to 6
# are the year. This line is complete (working with dates is a later topic).
drought_long <- drought_long |>
  mutate(year = as.numeric(str_sub(date, 3, 6)))


# ---- 3. Tidy, then summarize ----
# GOAL: Nebraska's worst drought years, by mean share in severe drought or
#       worse (d2).
# WHY:  "2012 was the worst" is a claim. The tidy table lets us check it.
# PATTERN (Module 05): filter -> group_by -> summarize -> arrange

nebraska_severe <- drought_long |>
  filter(state == ___, category == ___) |>
  group_by(___) |>
  summarize(mean_pct = ___, .groups = "drop") |>
  arrange(desc(mean_pct))

nebraska_severe
# CHECK: top row 1934, mean_pct 62.6
# Where does 2012 rank?
#   Answer:

# One plot, complete. It shows why the classes are "at least this dry":
# the lines never cross.
drought_long |>
  filter(state == "nebraska", year >= 2010) |>
  mutate(date = ymd(str_remove(date, "d_"))) |>
  ggplot(aes(x = date, y = pct_area, color = category)) +
  geom_line() +
  labs(
    x = NULL,
    y = "Percent of state area",
    color = "At least this dry",
    title = "Nebraska dryness, 9-month SPI"
  )

# Which line is always on top, and why?
#   Answer:


# ---- 4. pivot_wider(): tidy to a table people read ----
# GOAL:    a states-by-years table for a report.
# WHY:     tidy is for computing. Wide is often better for reading.
# PATTERN: pivot_wider(names_from = column that becomes new column names,
#                      values_from = column that fills them)
#
# Worked example: undo the plots example.
plots |>
  pivot_longer(c(y2024, y2025), names_to = "year", values_to = "count") |>
  pivot_wider(names_from = year, values_from = count)

# Your turn: mean severe-drought share, four Plains states, 2011-2013.
plains <- drought_long |>
  filter(
    state %in% c("nebraska", "kansas", "south-dakota", "iowa"),
    category == "d2",
    year %in% 2011:2013
  ) |>
  group_by(state, year) |>
  summarize(mean_d2 = mean(pct_area), .groups = "drop")

nrow(plains)
# CHECK: 12  (4 states x 3 years)

plains |>
  pivot_wider(names_from = ___, values_from = ___)
# CHECK: nebraska 2012 = 47.7
# Which state was already in drought in 2011, before 2012 hit?
#   Answer:


# ---- Challenge (10 min) ----
# Step 1 (everyone): Kansas, extreme drought (d3), years 2000 and later.
# Which year had the highest mean share? Reuse your Section 3 pipeline.

# Your code:

# CHECK: 2002, 20.1

# Step 2 (if Step 1 matches, or at home): the wet side.
# Tidy w0:w4 for Nebraska the same way. Since 1950, which year had the
# highest mean share in "moderately wet or wetter" (w1)? Does that match
# what you remember about Nebraska flooding?

# Your code:

#   Answer:


# ---- Break (10 min) ----


# ---- 5. Your project repository (45 min) ----
# Close this file for now. Open the book chapter "Your Project Repository"
# and follow it step by step. Leave class with:
# [ ] a private repo in YOUR GitHub account (usethis, or GitHub Desktop
#     if the token step stalls)
# [ ] the instructor and your assigned reviewer added as collaborators
# [ ] your reviewee's invite accepted
# [ ] the repo URL submitted on Canvas
#
# Mon Nov 2 there is no class meeting. You do the Data Audit in that same
# chapter. Proposal due Sun Nov 15, 11:59 PM.


# ---- 6. Before you leave ----
# [ ] This file runs from top to bottom after restarting R
# [ ] Commit and push class/ in your Module 05 repo (Source Control in
#     Positron, or GitHub Desktop: write a summary, Commit to main, Push)
# [ ] Your project repo shows on GitHub with at least one commit
