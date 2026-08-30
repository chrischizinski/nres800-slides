# NRES 800: Student Follow-Along Script
# Week 14: Reproducible Reporting with Quarto
# Name: [Your Name]

# ---- 1. Setup ----
# Task: Load tidyverse, here, and knitr.
# Note: Most of today's live coding happens inside a .qmd file.
# Use this script to run data checks and test code before pasting into your document.



# ---- 2. Load the Data ----
# Task: Read ne_deer_harvest.csv using here().
# Path: here("data", "ne_deer_harvest.csv")
# After loading, run glimpse() to confirm the column names.



# ---- 3. YAML Options — Document-Level Polish ----
# Open your .qmd file. In the YAML front matter, add the following options one
# at a time and re-render after each to see the effect.
#
# format:
#   html:
#     toc: true              # Adds a table of contents
#     toc-depth: 3           # Controls how many heading levels appear
#     number-sections: true  # Auto-numbers your sections
#     fig-width: 7           # Default figure width (inches)
#     fig-height: 4.5        # Default figure height (inches)
#     embed-resources: true  # Bundles CSS/JS into one portable file
# execute:
#   echo: false              # Hides code in the rendered output
#   warning: false           # Suppresses warnings
#   message: false           # Suppresses package startup messages
#
# Question: What happens to the rendered document when you toggle echo: false
# vs echo: true at the document level?


# ---- 4. Figure Captions and Cross-References ----
# Task: Build an annual harvest trend plot, then paste the code into a .qmd chunk.
# In the chunk, add these options:
#   #| label: fig-harvest-trend
#   #| fig-cap: "Write your own informative caption here."
#   #| fig-alt: "Write a brief alt text description here."
#
# Then reference the figure in prose using @fig-harvest-trend.

# Build the plot here first (data must already be loaded above):



# ---- 5. Formatted Tables with knitr::kable() ----
# Task: Create a summary table of total harvest by county and season.
# In your .qmd chunk, add:
#   #| label: tbl-top-counties
#   #| tbl-cap: "Write your own caption here."
#
# Then reference it in prose using @tbl-top-counties.

# Build and inspect the table here first:



# Pass it to knitr::kable() to see the formatted version:



# ---- 6. Inline R Expressions ----
# Task: In your .qmd prose, insert inline R to report:
#   - The number of unique counties: `r n_distinct(deer$county)`
#   - The total harvest: `r format(sum(deer$harvest_count, na.rm = TRUE), big.mark = ",")`
#
# Test the expressions here first so you know what they produce:



# ---- 7. Parameterized Reports ----
# Task: Add a params: block to your .qmd YAML:
#
# params:
#   county: "Lancaster"
#   season: "archery"
#
# Then filter the data inside a chunk using params$county and params$season.
# Test the filter logic here first:



# ---- 8. Weekly Challenge ----
# Problem: Turn your deer harvest draft into a reader-facing report section.
# Requirements:
#   - At least one figure with fig-cap and @fig- cross-reference in prose.
#   - At least one table using knitr::kable() with @tbl- cross-reference in prose.
#   - At least two inline R expressions reporting data summaries.
#   - A params: block with at least one parameter (e.g., county or season).
#
# Test your computations in this script, then move them to your .qmd.

# TODO: Your code goes below.



# ---- 9. Verification ----
# Before you commit and push:
# - Does the document render cleanly from a fresh session (Session > Restart R)?
# - Do all @fig- and @tbl- cross-references resolve (no "?fig-" in the output)?
# - Do your inline R expressions produce the correct numbers?
# - Is the params: block tested with at least two different values?
# - Are warning: false and message: false set so the output is clean?
