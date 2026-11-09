# NRES 800: Student Follow-Along Script
# Module 09 (short): Text, Categories, and Dates
# Name: [Your Name]
# Date: 2026-11-16
#
# This file lives in class/. It is never checked or graded.
# Commit and push it before you leave class (participation evidence).
#
# HOW THIS FILE GOT HERE
# Your instructor added this file and class/data/sf_trees.csv to your
# Module 05 repo on GitHub. You brought them down with a PULL, the same way
# you got the Module 08 file. Nothing you wrote was changed.
#
# Today's data: every street tree in San Francisco's public inventory
# (192,987 rows). Three kinds of column need a decision before you can
# count or plot them:
#   text      -> split, trim, turn placeholders into NA   (stringr)
#   category  -> choose and order the levels for a plot  (forcats)
#   date      -> pull out the part your question needs  (lubridate)
#
# How each step works (same as Module 08):
#   GOAL    what we are making
#   WHY     what goes wrong without it
#   PATTERN the shape of the code
#   Worked example: run it and read the output. It uses tiny made-up data.
#   Your turn: the same pattern on the real data. Fill in each blank.
#   CHECK   the number you should get. If you match, move on.
#
# There is no Assignment 09. The last part of class is time for your
# project draft (due Sun Nov 29).


# ---- 0. Setup ----
# Do this: Session > Restart R, then run this block.

library(tidyverse)
library(janitor)
library(here)

trees <- read_csv(here("class", "data", "sf_trees.csv")) |>
  clean_names()

dim(trees)
# CHECK: 192987 12
glimpse(trees)


# ---- 1. Text: one column, two facts ----
# GOAL    split species into a scientific name and a common name
# WHY     "Platanus x hispanica :: Sycamore: London Plane" cannot be
#         counted by common name until it is two columns
# PATTERN separate_wider_delim(col, delim = "::", names = c(...),
#           too_few = "align_start") |>
#           mutate(across(c(...), str_trim), across(c(...), \(x) na_if(x, "")))

# Worked example: run it and read the output.
tiny <- tibble(
  species = c("Acer rubrum :: Red Maple", "Tree(s) ::", "::",
              "Tristania conferta ::")
)
tiny |>
  separate_wider_delim(species, delim = "::",
                       names = c("scientific", "common"),
                       too_few = "align_start") |>
  mutate(across(c(scientific, common), str_trim),
         across(c(scientific, common), \(x) na_if(x, "")))

# Your turn. First, the most common "species":
trees |>
  count(___, sort = TRUE) |>
  head(3)
# Is the top one a species?
#   Answer:

trees_sp <- trees |>
  separate_wider_delim(___, delim = ___,
                       names = c("scientific", "common"),
                       too_few = "align_start") |>
  mutate(across(c(scientific, common), ___),
         across(c(scientific, common), \(x) na_if(x, ___)),
         scientific = na_if(scientific, ___))

trees_sp |>
  summarize(no_scientific = sum(is.na(scientific)),
            no_common = sum(is.na(common)))
# CHECK: no_scientific 13468, no_common 15086


# ---- 2. Text: same thing, different spelling ----
# GOAL    make plot_size values that mean the same thing match
# WHY     "3x3" and "3X3" count as two sizes until the case matches
# PATTERN mutate(col = str_to_lower(col))
#         str_detect(col, "^width") is TRUE when the text starts with "width"
#         str_extract(col, "[0-9.]+") pulls out the first number

trees |>
  count(plot_size, sort = TRUE) |>
  head(8)

n_distinct(trees$plot_size)
n_distinct(___(trees$plot_size))
# CHECK: 525, then 465

trees_sp <- trees_sp |>
  mutate(
    plot_size = ___(plot_size),
    width_ft = if_else(str_detect(plot_size, ___),
                       as.numeric(str_extract(plot_size, "[0-9.]+")), NA)
  )

trees_sp |>
  summarize(has_width = sum(!is.na(width_ft)),
            width_zero = sum(width_ft == 0, na.rm = TRUE))
# CHECK: has_width 85694, width_zero 17017
# What could "Width 0ft" mean for a tree?
#   Answer:


# ---- Challenge 1 ----
# Step 1: the five most common trees by common name, unknowns removed.
trees_sp |>
  filter(___) |>
  count(___, sort = TRUE) |>
  head(5)
# CHECK: London Plane 11557 first, Victorian Box 7122 fifth

# Step 2: how many trees have "Cherry" anywhere in the common name?
trees_sp |>
  filter(str_detect(___, ___)) |>
  nrow()
# CHECK: 14571


# ---- 3. Categories: which levels, in what order ----
# GOAL    a bar chart of the 10 most common trees, biggest bar on top
# WHY     550 names make 550 bars, sorted alphabetically
# PATTERN fct_lump_n(col, n = 10)    keep the 10 most common, rest = "Other"
#         fct_infreq(col)            order levels by count
#         fct_rev(col)               flip the order

trees_sp |>
  filter(!is.na(common)) |>
  mutate(common = fct_lump_n(___, n = ___)) |>
  count(common, sort = TRUE)
# CHECK: Other 106340 is the biggest "category"
# If a figure lumps levels into "Other", what must the caption say?
#   Answer:

top10 <- trees_sp |>
  filter(!is.na(common)) |>
  mutate(common = fct_lump_n(common, n = 10)) |>
  filter(common != ___)

ggplot(top10, aes(y = fct_rev(___(common)))) +
  geom_bar() +
  labs(x = "Number of street trees", y = NULL)


# ---- Challenge 2 ----
# Who looks after the trees? Lump caretaker to the top 3 plus Other, bars
# ordered by count, biggest on top.
trees |>
  mutate(caretaker = ___(caretaker, n = ___)) |>
  ggplot(aes(y = fct_rev(fct_infreq(___)))) +
  geom_bar() +
  labs(x = "Number of street trees", y = NULL)
# CHECK: Private, DPW, Other, SFUSD (Other is third)


# ---- 4. Dates: pull out the part you need ----
# GOAL    count plantings by year and by day of the week
# WHY     a full date is too fine to count; the question asks about a part
# PATTERN year(date), month(date, label = TRUE),
#         wday(date, label = TRUE, week_start = 1)   (Assignment 08 again)

sum(is.na(trees$date))
# CHECK: 124610
# What does that mean for a "trees planted per year" figure?
#   Answer:

planted <- trees |>
  filter(!is.na(___)) |>
  mutate(
    year = ___(date),
    weekday = wday(date, label = TRUE, week_start = ___)
  )

nrow(planted)
# CHECK: 68377

planted |>
  count(year) |>
  ggplot(aes(x = year, y = n)) +
  geom_line() +
  labs(x = NULL, y = "Trees with a recorded planting date")

planted |>
  count(___) |>
  mutate(pct = round(100 * n / sum(n), 1))
# CHECK: Sat 10.2, Sun 1.0

# Payoff: plantings by day of the week
planted |>
  ggplot(aes(x = ___)) +
  geom_bar() +
  labs(x = NULL, y = "Trees planted (dated records)")
# Why might Sunday be so low? What would you check before saying so in a
# report?
#   Answer:


# ---- 5. Your report: one gt table and one inline value ----
# Open your PROJECT repo (not this one) and report.qmd.
# If library(gt) fails: install.packages("gt")
#
# (a) A table chunk. Practice the pattern here first:
library(gt)

trees_sp |>
  filter(!is.na(common)) |>
  count(common, sort = TRUE) |>
  head(5) |>
  gt() |>
  cols_label(common = ___, n = ___) |>
  fmt_number(columns = n, decimals = ___) |>
  tab_header(title = ___)

# In report.qmd, give the table chunk:
#   #| label: tbl-something   (must start with tbl-)
#   #| tbl-cap: "What the table shows."
#
# (b) An inline value: in the TEXT of report.qmd (not in a chunk), type
#   My data have `r nrow(your_data)` rows.
# with your own object name. Render and check the number appears.
#
# Render, commit, push the project repo.


# ---- 6. Before you leave ----
# [ ] This file runs from top to bottom after restarting R
# [ ] Commit and push class/ in your Module 05 repo (Source Control in
#     Positron, or GitHub Desktop: write a summary, Commit to main, Push)
# [ ] One gt table and one inline value in your project report.qmd, pushed
# [ ] Assignment 08 due Sun Nov 22, 11:59 PM; project draft due Sun Nov 29
