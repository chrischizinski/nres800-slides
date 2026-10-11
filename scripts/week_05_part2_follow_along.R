# NRES 800: Student Follow-Along Script
# Module 05, Part 2: Summaries and Decisions (continued)
# Name: [Your Name]
# Date: 2026-10-12
#
# This file lives in class/. It is never checked or graded.
# Commit and push it before you leave class (participation evidence).
#
# HOW THIS FILE GOT HERE
# Your instructor added this file to your repo on GitHub. You brought it to
# your computer with a PULL: pull = copy new changes from GitHub down to your
# computer (push is the other direction). Pulling added this one new file.
# Your Part 1 file, week_05_follow_along.R, was not changed.
#
# Today's workflow (same as Part 1; we pick up at "decide categories"):
#   clean data -> decide which rows count -> decide categories
#     -> group_by() -> summarize() -> check against a known total
#
# How each step works:
#   GOAL    what we are making
#   WHY     what goes wrong without it
#   PATTERN the shape of the code
#   Worked example: run it and read the output. It uses tiny made-up data.
#   Your turn: the same pattern on the real data. Blanks look like ___ .
#   CHECK   the number you should get. If you match, move on.
#           If you do not, compare your code with the worked example.
#
# Challenges have two steps:
#   Step 1  everyone does this. Stop when you match the CHECK.
#   Step 2  if Step 1 matches, keep going here.
#   Stuck? Hints for both steps are in the book, Chapter 5, "Try It".


# ---- 0. Checkpoint: everyone starts from the same place ----
# GOAL: rebuild the Part 1 objects so all of us have the same `fishing`.
# WHY:  if your Part 1 code had a typo, it stops here instead of breaking
#       everything below.
# Do this: Session > Restart R, then run this whole block.
# It is Part 1 code you already wrote, so it is complete.

library(tidyverse)
library(janitor)
library(here)

fishing <- read_csv(here("class", "data", "fishing.csv")) |>
  clean_names()

us_totals <- c("U.S. Total", "U.S. Total (MI)", "U.S. Total (NY)")

nrow(fishing)
# CHECK: 65706

# Recap from Part 1, answer in a comment:
# The Lake Michigan lake whitefish total for 2000 summed to 14,381 when the
# U.S. Total row says 4,794. Why?
#   Answer:


# ---- 2. Categories you decide ----

# 2.1 if_else(): two categories
# GOAL:    label every row "missing" or "recorded".
# WHY:     a third of `values` is NA. Before we trust any total, we need to
#          know where the missing rows are.
# PATTERN: if_else(condition, value if TRUE, value if FALSE)
#          Both values must be the same type (here, two strings).
#
# Worked example:
tibble(catch = c(12, NA, 30)) |>
  mutate(status = if_else(is.na(catch), "missing", "recorded"))

# Your turn: label fishing, then count the labels.
fishing |>
  mutate(recorded = if_else(___, "missing", "recorded")) |>
  count(___)
# CHECK: missing 21916, recorded 43790

# Now count by lake AND recorded. Which lake has the most missing?
#   Answer:


# 2.2 case_when(): more than two categories
# GOAL:    a column region_level that says what kind of row each one is:
#          "US total", "Canada total", "state total", or "area".
# WHY:     the region column mixes detail rows with total rows. Summing all
#          of them counted the same fish three times (Challenge 1).
# PATTERN: case_when(
#            condition ~ label,
#            condition ~ label,
#            .default = label for every row no line matched
#          )
#          Lines are checked top to bottom. The first TRUE line wins.
#
# Worked example:
tibble(length_mm = c(80, 250, 600)) |>
  mutate(
    size = case_when(
      length_mm < 100 ~ "small",
      length_mm < 400 ~ "medium",
      .default = "large"
    )
  )

# Your turn. First list the region names you can choose from:
fishing |>
  distinct(region) |>
  arrange(region)

# us_totals is already made (checkpoint). Fill in the other two vectors.
canada_totals <- c(___, ___)
state_totals <- c(___, ___)

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
  count(region_level)
# CHECK: area 39480, Canada total 9924, state total 4252, US total 12050

fishing |>
  count(region_level, region)
# Read every line. Is any region in the wrong level?


# 2.3 The correct total per lake
# GOAL:    one row per lake: rows, n_missing, and total, U.S. totals only.
# WHY:     filtering to one level is how we stop counting the same fish
#          twice. n_missing tells the reader what the total is built on.
# PATTERN: filter() -> group_by() -> summarize() -> arrange()
#          (the same shape as Part 1, section 1.4)

us_by_lake <- fishing |>
  filter(___ == ___) |>
  group_by(___) |>
  summarize(
    rows = n(),
    n_missing = ___,
    total = ___,
    .groups = "drop"
  ) |>
  arrange(desc(total))

us_by_lake
# CHECK: Michigan first, total 3072965

# Which lake's total would you trust least, and why? (look at n_missing)
#   Answer:


# 2.4 Order matters in case_when()
# GOAL:    an era column with four periods, then see what breaks it.
# WHY:     the first TRUE line wins. A line in the wrong place silently
#          puts rows in the wrong group, and R gives no error.
# PATTERN: same as 2.2, with year conditions.
#
# Worked example: put the widest condition first and watch it swallow
# everything.
tibble(length_mm = c(80, 250, 600)) |>
  mutate(
    size = case_when(
      length_mm < 400 ~ "medium",   # 80 is also < 400, so it lands here
      length_mm < 100 ~ "small",    # never reached
      .default = "large"
    )
  )

# Your turn: periods before 1900, 1900-1949, 1950-1999, 2000-2015.
fishing |>
  mutate(
    era = case_when(
      year < ___ ~ "1867-1899",
      year < ___ ~ "1900-1949",
      year < ___ ~ "1950-1999",
      .default = ___
    )
  ) |>
  count(era)
# CHECK: 6477, 22469, 27487, 9273

# Now move the year < 2000 line to the top and run it again.
# What happens, and why?
#   Answer:


# ---- Challenge 2: Clean the species list (20 min) ----
# QUESTION: how many different fish are really in this file?
# WHY:      "White bass" and "White Bass" are one fish to you and two
#           groups to group_by(). Every species total would be split.
#
# Step 1 (everyone):
# Fix these four misspellings. The first is done for you.
#   "Amercian Eel"    -> "American Eel"
#   "Pacific salmon"  -> "Pacific Salmon"
#   "Channel catfish" -> "Channel Catfish"
#   "White bass"      -> "White Bass"

fishing |>
  count(species)
# 51 labels before you start

fishing <- fishing |>
  mutate(
    species = case_when(
      species == "Amercian Eel" ~ "American Eel",
      species == ___ ~ ___,
      species == ___ ~ ___,
      species == ___ ~ ___,
      .default = ___
    )
  )

fishing |>
  count(species) |>
  nrow()
# CHECK: 47
# Why .default = species and not .default = "Other"?
#   Answer:

# Step 2 (Step 1 matches 47):
# - Find the other labels that are the same fish written differently
#   (look for plurals, and for capital letters). Recode them too.
#   How many labels remain?
# - How many lakes report each species in the 2000s (U.S. totals, known
#   values only)? Hint: n_distinct().
# - Are "Drum" and "Freshwater Drum" the same fish? What would you check
#   before merging them?

# Your code:

# Answer:
#   Labels after Step 2:
#   Drum:


# ---- Break (10 min) ----


# ---- Integrated challenge (30 min) ----
# QUESTION: Lake Michigan lake whitefish, U.S. catch. Which decade had the
#           biggest catch?
# WHY:      this is the real question a manager asks. It uses everything
#           from today: which rows count, a new category, one row per group,
#           and saying what the number is built on.
#
# Step 1 (everyone): fill in the pipeline.
whitefish_decades <- fishing |>
  filter(
    lake == ___,
    species == ___,
    region_level == ___
  ) |>
  mutate(decade = ___) |>          # Part 1 recap: 1987 -> 1980
  group_by(___) |>
  summarize(
    years = n(),
    n_missing = ___,
    catch = ___,
    .groups = "drop"
  ) |>
  arrange(desc(catch))

whitefish_decades
# CHECK: top row 1990, catch 69967

# catch is in THOUSANDS of pounds. Write the peak in pounds.
#   Peak decade and catch (pounds):

# Step 2 (Step 1 matches):
# - The 2010s look low. How many years of data does the 2010s have?
# - Compute catch per RECORDED year (years minus n_missing). Which decade
#   "wins" now, and would you trust it? Why or why not?
# - Repeat for another lake. Read the comments column for that species
#   first.

# Your code:

# Answers:
#   Per-year view changes the story because:


# ---- 3. Assignment workshop (35 min) ----
# Close this file. Open assignment/assignment.qmd.
# Goal for today: Tasks 1 and 2 done, rendered, committed, and pushed.
# Same skills, new data: Task 2 is "decide which records count", the same
# move as region_level today.
# Due Sun Oct 18, 11:59 PM. Graded: assignment/ and README.md only.


# ---- 4. Before you leave ----
# [ ] This file runs from top to bottom after restarting R
# [ ] Commit and push class/ (Source Control in Positron, or GitHub Desktop:
#     write a summary, Commit to main, then Push origin)
# [ ] Commit and push your assignment work too
# [ ] Check both pushes show on GitHub
