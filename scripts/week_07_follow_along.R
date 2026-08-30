# NRES 800: Student Follow-Along Script
# Week 07: Tidying Wide Data
# Name: [Your Name]

# ---- 1. Setup ----
# Task: Load tidyverse and here.



# ---- 2. The "Why Tidy" Problem ----
# Load the water quality dataset.
# wq_wide <- read_csv(here("data", "water_quality_wide.csv"))

# Inspect the structure. How many rows? How many columns?


# THINK: If you wanted to plot nitrate on the y-axis and month on the x-axis,
# what column would you use for month? (There isn't one — that is the problem.)

# Try plotting just May nitrate values as a boxplot by watershed.
# What's missing? What would you have to do to include July and September?



# ---- 3. pivot_longer(): Wide to Long ----
# Use pivot_longer() to stack all measurement columns (nitrate_may through turbidity_sep).
# Arguments to fill in:
#   cols      = nitrate_may:turbidity_sep
#   names_to  = "measurement"
#   values_to = "value"

wq_long <- wq_wide |>
  pivot_longer(
    cols      = ___,
    names_to  = ___,
    values_to = ___
  )

# CHECKPOINT — Row count audit:
# Before pivot_longer: how many rows?
nrow(wq_wide)

# After pivot_longer: how many rows?
nrow(wq_long)

# Why that number? Write your explanation as a comment:
# [your answer here]

# Now use separate() to split "measurement" into "parameter" and "month".
# Hint: sep = "_"

wq_long <- wq_long |>
  separate(___, into = c("parameter", "month"), sep = ___)

# Inspect the result:
glimpse(wq_long)

# ---- 4. Plot from Long Data ----
# Filter to just nitrate, then build a boxplot:
#   x = month, y = value, fill = land_use
# Add informative labels and theme_minimal().

wq_long |>
  filter(parameter == ___) |>
  ggplot(aes(x = ___, y = ___, fill = ___)) +
  geom_boxplot() +
  labs(
    title = ___,
    x     = ___,
    y     = ___,
    fill  = ___
  ) +
  theme_minimal()

# ---- 5. pivot_wider(): Long to Wide ----
# First, create a summary table: mean value by land_use, parameter, and month.

wq_summary <- wq_long |>
  group_by(___, ___, ___) |>
  summarize(mean_value = mean(value, na.rm = TRUE), .groups = "drop")

# Now use pivot_wider() to make months into columns for easy comparison.
# Arguments:
#   names_from  = month
#   values_from = mean_value

wq_summary |>
  pivot_wider(
    names_from  = ___,
    values_from = ___
  )

# ---- 6. Weekly Challenge ----
# Problem: Do agricultural watersheds have higher nitrate than forested ones
# across all three sampling months?
#
# Steps:
# 1. Filter wq_long to parameter == "nitrate".
# 2. Group by land_use and month.
# 3. Summarize: calculate mean_nitrate and se (sd / sqrt(n())).
# 4. Order months as a factor: may, jul, sep.
# 5. Plot with geom_line() + geom_point() + geom_errorbar(), colored by land_use.

# TODO: Your code goes below.



# ---- 7. Verification ----
# Before you commit and push:
# - Does your long-format data have the correct number of rows? (25 * 9 = 225)
# - Did you remove NAs when summarizing? (na.rm = TRUE)
# - Does your plot show all three months on the x-axis in chronological order?
# - Can you explain in one sentence why pivot_longer() was necessary to make this plot?
