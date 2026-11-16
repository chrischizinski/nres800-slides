# NRES 800: Student Follow-Along Script
# Project Workshop: a first look at purrr
# Name: [Your Name]
# Date: 2026-11-23
#
# This file lives in class/. It is never checked or graded.
# Commit and push it before you leave class (participation evidence).
#
# HOW THIS FILE GOT HERE
# Your instructor added this file to your Module 05 repo on GitHub. You
# brought it down with a PULL, the same way you got the Module 09 file.
# class/data/fishing.csv is already in your repo from Module 05.
#
# TODAY, IN ORDER
#   1. Self-check and fresh-clone test of your PROJECT repo (first!)
#   2. This file: 20 minutes of purrr
#   3. Work time on your draft (due Sun Nov 29)
# If your report.qmd does not render from a fresh clone, skip this file and
# keep fixing. Everything here is also in the course book.
#
# The idea: when you copy a block and change one word (a lake, a site, a
# file name), write the block once and let map() run it for each value.
#   things -> map(things, \(x) do something with x) -> a list
#
# How each step works (same as Modules 08 and 09):
#   GOAL    what we are making
#   PATTERN the shape of the code
#   Worked example: run it and read the output.
#   Your turn: fill in each blank (___).
#   CHECK   the number you should get. If you match, move on.


# ---- 0. Setup (given) ----
library(tidyverse)
library(janitor)
library(here)

fishing <- read_csv(here("class", "data", "fishing.csv")) |>
  clean_names()

# The whole-lake table from Module 08 (given complete).
lake_totals <- c(
  "U.S. Total", "U.S. Total (MI)", "U.S. Total (NY)",
  "Canada (ONT)", "Total Canada (ONT)"
)

lake_catch <- fishing |>
  mutate(region = str_trim(region)) |>
  filter(region %in% lake_totals) |>
  group_by(lake, year, species) |>
  summarize(catch = sum(values, na.rm = TRUE), .groups = "drop")

trout <- lake_catch |>
  filter(species == "Lake Trout")

nrow(trout)
# CHECK: 606


# ---- 1. map() on tiny data ----
# PATTERN: map(THINGS, \(x) WHAT TO DO WITH x)
# \(x) means "for each x, do this".
#
# Worked example: run it. How many elements come back? What kind of object?
map(c(2, 5, 10), \(x) x * 100)

map_dbl(c(2, 5, 10), \(x) x * 100)
# What is the difference between the two outputs?
#   Answer:


# ---- 2. One figure per lake ----
# GOAL: five separate lake trout figures, one per lake, without copying
# the plot code five times.
#
# Here is the block for ONE lake:
trout |>
  filter(lake == "Erie") |>
  ggplot(aes(x = year, y = catch)) +
  geom_line() +
  labs(title = "Erie", x = NULL, y = "Catch (thousand lb)")

# Your turn: the same block inside map(). Replace "Erie" with the name you
# give each lake (one_lake) in BOTH places it appears.
lakes <- sort(unique(trout$lake))

trout_plots <- map(lakes, \(one_lake) {
  trout |>
    filter(lake == ___) |>
    ggplot(aes(x = year, y = catch)) +
    geom_line() +
    labs(title = ___, x = NULL, y = "Catch (thousand lb)")
})

length(trout_plots)
# CHECK: 5

# Name the list, then pull out one plot by name.
names(trout_plots) <- ___
trout_plots$Michigan
# CHECK: the title says Michigan; catch drops to 0 by 1955.

# facet_wrap() (Module 08) also makes one panel per lake. When would you
# want separate figures instead of one faceted figure?
#   Answer:


# ---- 3. Many files into one table ----
# GOAL: read a folder of CSV files (one per lake) into ONE table.
#
# Setup (given): write lake_catch out as one CSV per lake into a temporary
# folder, so there is a folder of files to read back. Just run it.
lake_folder <- file.path(tempdir(), "lake_files")
dir.create(lake_folder, showWarnings = FALSE)
lake_catch |>
  group_by(lake) |>
  group_walk(\(rows, key) {
    write_csv(rows, file.path(lake_folder, paste0(key$lake, ".csv")))
  })

files <- list.files(lake_folder, full.names = TRUE)
length(files)
# CHECK: 6

# Your turn: read every file with map(), then stack them with list_rbind().
# set_names(basename) and names_to = "file" record which file each row
# came from.
all_lakes <- files |>
  set_names(basename) |>
  map(\(f) ___(f, show_col_types = FALSE)) |>
  ___(names_to = "file")

nrow(all_lakes)
# CHECK: 12047, the same as nrow(lake_catch)

count(all_lakes, ___)
# CHECK: 6 rows, one per file; Superior.csv has 1581


# ---- 4. Your project ----
# Does your report repeat a block for each site, species, year, or file?
# Write the block once, find the word that changes, and map() over it.
# It counts toward Beyond-the-course (add a "What I explored" note).
#   Where in my report could I use map()?
#   Answer:


# ---- 5. Before you leave ----
# [ ] Fresh-clone test done on your project repo; first error fixed
# [ ] Commit and push class/ in your Module 05 repo (Source Control in
#     Positron, or GitHub Desktop: write a summary, Commit to main, Push)
# [ ] Commit and push your project repo
# [ ] Draft due Sun Nov 29, 11:59 PM: push report.qmd, then submit its
#     address on the Canvas assignment Project Draft
