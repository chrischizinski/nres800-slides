# NRES 800: Student Follow-Along Script
# Module 08: Visualizing Wrangled Data (+ a first look at joins)
# Name: [Your Name]
# Date: 2026-11-09
#
# This file lives in class/. It is never checked or graded.
# Commit and push it before you leave class (participation evidence).
#
# HOW THIS FILE GOT HERE
# Your instructor added this file and class/data/stocked.csv to your
# Module 05 repo on GitHub. You brought them down with a PULL, the same way
# you got the Module 06 file on Oct 26. fishing.csv is already in
# class/data/ from Module 05. Nothing you wrote was changed.
#
# Today's workflow:
#   a table you cleaned and checked -> ggplot(data, aes(...)) -> geom
#     -> facets, scales, labels with units, palette -> a caption that
#     states the pattern
#
# How each step works (same as Modules 05 and 06):
#   GOAL    what we are making
#   WHY     what goes wrong without it
#   PATTERN the shape of the code
#   Worked example: run it and read the output. It uses tiny made-up data.
#   Your turn: the same pattern on the real data. Blanks look like ___ .
#   CHECK   the number you should get. If you match, move on.
#
# Your project draft (due Sun Nov 29) needs 3 figures. Everything today is
# practice for those.


# ---- 0. Setup ----
# Do this: Session > Restart R, then run this block.

library(tidyverse)
library(janitor)
library(here)

fishing <- read_csv(here("class", "data", "fishing.csv")) |>
  clean_names()

stocked <- read_csv(
  here("class", "data", "stocked.csv"),
  col_types = cols(WEIGHT = col_character())
) |>
  clean_names()

dim(fishing)
# CHECK: 65706 7
dim(stocked)
# CHECK: 56232 31

# The data: Great Lakes Fishery Commission, via TidyTuesday 2021-06-08.
#   fishing  commercial catch, THOUSANDS OF POUNDS, 1867-2015 (Module 05)
#   stocked  one row per stocking event, number of fish, 1950-2018
#            (Module 04)
# Why col_types? Same fix as Module 04: the weight column has text in it.


# ---- 1. Recap: build the table we will plot ----
# GOAL: one row per lake, year, and species, with the whole-lake catch.
# WHY:  Module 05 trap. Total rows sit on top of area rows. Summing every
#       row counts the same fish two or three times.
# This vector of total-row names is complete (the names differ by lake).
lake_totals <- c(
  "U.S. Total", "U.S. Total (MI)", "U.S. Total (NY)",
  "Canada (ONT)", "Total Canada (ONT)"
)

# Your turn (Module 05 pattern): keep only total rows, then one row per
# lake, year, species. One region name has a trailing space; str_trim()
# fixes it.
lake_catch <- fishing |>
  mutate(region = str_trim(region)) |>
  filter(region %in% ___) |>
  group_by(___, ___, ___) |>
  summarize(catch = sum(___, na.rm = TRUE), .groups = "drop")

nrow(lake_catch)
# CHECK: 12047

trout <- lake_catch |>
  filter(species == ___)

nrow(trout)
# CHECK: 606


# ---- 2. The grammar of a plot ----
# GOAL:    a line plot of lake trout catch over time, one line per lake.
# WHY:     the same three parts build every ggplot. Learn them once.
# PATTERN: ggplot(DATA, aes(x = column, y = column, color = column)) +
#            geom_SHAPE()
#          Layers join with +, not |>.
#
# Worked example:
counts <- tibble(
  plot  = c("A", "A", "B", "B", "C", "C"),
  year  = c(2024, 2025, 2024, 2025, 2024, 2025),
  count = c(12, 15, 7, 9, 20, 11)
)
ggplot(counts, aes(x = year, y = count, color = plot)) +
  geom_line()

# Your turn: lake trout catch by year, one color per lake.
ggplot(trout, aes(x = ___, y = ___, color = ___)) +
  geom_line()

# What happened to lake trout around 1950? Which lake held on longest?
#   Answer:

# Aesthetic vs setting.
#   inside aes()  = MAPPED from a column (you get a legend)
#   outside aes() = one fixed value for everything
# Run both. Which one gives a steelblue line?
trout |>
  filter(lake == "Superior") |>
  ggplot(aes(x = year, y = catch)) +
  geom_line(color = "steelblue", linewidth = 1)

trout |>
  filter(lake == "Superior") |>
  ggplot(aes(x = year, y = catch, color = "steelblue")) +
  geom_line()

# Why is the second line not blue, and why does the legend say "steelblue"?
#   Answer:

# Labels with units. Fill in a y label WITH UNITS and a title that states
# the finding (not just "Lake trout by year").
ggplot(trout, aes(x = year, y = catch, color = lake)) +
  geom_line() +
  labs(
    x = NULL,
    y = ___,
    color = "Lake",
    title = ___
  )


# ---- Challenge 1 (15 min) ----
# Step 1 (everyone): lake whitefish ("Lake Whitefish") catch over time,
# one line per lake, with a y label that has units. Start from your trout
# plot: change the data you give ggplot().

# Your code:

# Which lake led whitefish catch in 2015? Read it off the plot, then check
# with filter() and arrange().
# CHECK: Huron, 3444

# Step 2 (if Step 1 matches): Lake Michigan whitefish only, one fixed line
# color of your choice, thicker line. Setting or aesthetic?

# Your code:


# ---- 3. Pick the geom by the data ----
# PATTERN (rule of thumb):
#   number over time            -> geom_line()
#   one number per category     -> geom_col()
#   distribution of one number  -> geom_histogram() or geom_boxplot()
#   two numbers                 -> geom_point()

# 3a. One number per category.
# GOAL: total lake trout catch by lake, 2000 to 2015, as bars.
trout_recent <- trout |>
  filter(year >= ___) |>
  group_by(___) |>
  summarize(total = sum(catch), .groups = "drop")

trout_recent
# CHECK: Huron 11639

ggplot(trout_recent, aes(x = lake, y = total)) +
  geom_col() +
  labs(x = NULL, y = "Lake trout catch, 2000-2015 (thousands of pounds)")

# Only four bars. Where is Lake Ontario, and what should a caption say?
#   Answer:

# 3b. Distribution + scales.
# GOAL: how many lake trout go into one stocking event?
stocked |>
  filter(species == "LAT") |>
  ggplot(aes(x = no_stocked)) +
  geom_histogram(bins = 40)

# Why is everything piled at the left?
#   Answer:

# A log scale spreads it out. log10 cannot show 0, so drop zeros first.
stocked |>
  filter(species == "LAT", no_stocked > ___) |>
  ggplot(aes(x = no_stocked)) +
  geom_histogram(bins = 40) +
  scale_x_log10(labels = scales::label_comma()) +
  labs(x = "Lake trout per stocking event (log scale)", y = "Events")

# How many zero events did you drop? (summarize(sum(no_stocked == 0)))
# CHECK: 1

# 3c. Facets: one panel per lake.
# WHY: with many groups, panels are easier to read than colors, and they do
#      not depend on telling colors apart.
ggplot(trout, aes(x = year, y = catch)) +
  geom_line() +
  facet_wrap(~ ___, scales = "free_y") +
  labs(x = NULL, y = "Commercial catch (thousands of pounds)")

# scales = "free_y" gives each panel its own y range. What could a reader
# get wrong if you do not say that in the caption?
#   Answer:

# 3d. Accessible palette.
# viridis is built into ggplot2 and is colorblind-safe. end = 0.85 drops
# the pale yellow that disappears on a white background.
ggplot(trout, aes(x = year, y = catch, color = lake)) +
  geom_line() +
  scale_color_viridis_d(end = 0.85) +
  labs(x = NULL, y = "Commercial catch (thousands of pounds)", color = "Lake") +
  theme_minimal()


# ---- Challenge 2 (15 min) ----
# Step 1 (everyone): a boxplot of lake trout per stocking event (species
# "LAT"), one box per lake, log scale on y, zeros removed. Which lake has
# the largest median event? Check with group_by() + summarize(median()).

# Your code:

# CHECK: MI, 50400

# Step 2 (if Step 1 matches, or at home): total lake trout stocked per
# year, in millions (divide by 1e6), as bars, one panel per lake. Which
# lake-year is the biggest?

# Your code:

#   Answer:


# ---- Break (10 min) ----


# ---- 4. Joins: two tables, one key ----
# GOAL:    put catch and stocking in one table, matched by lake and year.
# WHY:     "did catch come back as stocking went up?" needs both numbers in
#          the same row.
# PATTERN: left_table |> left_join(right_table, by = c("key1", "key2"))
#          left_join() keeps every row of the LEFT table.
#          anti_join() returns the rows that did NOT match: the audit.
#
# Worked example:
sites  <- tibble(site = c("A", "B", "C"), habitat = c("marsh", "prairie", "marsh"))
visits <- tibble(site = c("A", "A", "B", "D"), birds = c(4, 6, 2, 9))
visits |> left_join(sites, by = "site")
visits |> anti_join(sites, by = "site")
# Why is habitat NA for site D? Why does site C not appear?
#   Answer:

# The keys do not match: catch says "Michigan", stocking says "MI".
# A small lookup table fixes that (complete):
lake_key <- tibble(
  lake_code = c("ER", "HU", "MI", "ON", "SU"),
  lake      = c("Erie", "Huron", "Michigan", "Ontario", "Superior")
)

# Lake trout stocked per lake (code) and year. Complete:
stock_trout <- stocked |>
  filter(species == "LAT") |>
  group_by(lake_code = lake, year) |>
  summarize(fish_stocked = sum(no_stocked), .groups = "drop")

nrow(stock_trout)
# CHECK: 264

# Your turn: add the lake names. Count rows before and after.
stock_trout <- stock_trout |>
  left_join(___, by = ___)

nrow(stock_trout)
# CHECK: 264. Why should a lookup join never change the row count?
#   Answer:

# Your turn: join stocking onto catch by BOTH lake and year.
trout_both <- trout |>
  left_join(stock_trout, by = c(___, ___))

nrow(trout_both)
# CHECK: 606 (same as trout)

# Audit: which catch rows found no stocking record?
trout |>
  anti_join(stock_trout, by = c("lake", "year")) |>
  count(lake)
# CHECK: Huron 105
# Catch records start in 1867. Stocking records start 1950 or later. Is NA
# in fish_stocked "zero fish stocked" or "no record"?
#   Answer:

# The payoff plot (complete; it uses pivot_longer() from Module 06 so
# catch and stocking each get a row of panels):
trout_both |>
  filter(year >= 1950) |>
  mutate(fish_stocked = fish_stocked / 1e6) |>
  pivot_longer(
    c(catch, fish_stocked),
    names_to = "measure",
    values_to = "amount"
  ) |>
  mutate(measure = if_else(
    measure == "catch",
    "Catch (thousands of lb)",
    "Stocked (millions of fish)"
  )) |>
  ggplot(aes(x = year, y = amount)) +
  geom_line() +
  facet_grid(measure ~ lake, scales = "free_y") +
  labs(x = NULL, y = NULL)
# The warning "Removed ... rows containing missing values" is the years
# with no stocking record. Not an error.
# What do Superior and Huron show?
#   Answer:


# ---- 5. One figure in your project report ----
# Open your PROJECT repo (not this one) and report.qmd. Add one chunk with
# a figure of YOUR data. The book chapter "Visualizing Wrangled Data" has
# the template. The chunk needs:
#   #| label: fig-something   (must start with fig-)
#   #| fig-cap: "One sentence that states the pattern."
#   #| fig-alt: "What the figure shows, for a screen reader."
# Render, commit, push.


# ---- 6. Before you leave ----
# [ ] This file runs from top to bottom after restarting R
# [ ] Commit and push class/ in your Module 05 repo (Source Control in
#     Positron, or GitHub Desktop: write a summary, Commit to main, Push)
# [ ] One figure of your own data in your project report.qmd, pushed
# [ ] Proposal due Sun Nov 15, 11:59 PM
