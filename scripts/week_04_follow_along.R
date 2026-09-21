# NRES 800: Student Follow-Along Script
# Module 04: Visualization Foundations
# Name: [Your Name]

# ---- 1. Setup ----
# Load the packages the instructor names.



# ---- 2. Live Coding Demo ----
# We are learning how to choose the right visual encoding.

# Mapping vs setting:
# - Map a variable to color.
# - Set a fixed color outside aes().


# Choosing geoms:
# - Use a histogram for one continuous variable.
# - Use a boxplot for a categorical vs continuous comparison.


# Faceting:
# - Split the plot by island.
# - Ask: when is faceting clearer than color?



# ---- 2b. Quarto Introduction ----
# Open first_report.qmd in this project folder (not this script).
# Fill in from the demo:
# - What goes in the YAML header? (three things)
# - Where does prose go?
# - How does a code chunk start and end?
# - What does #| fig-cap do?
# - What does Render produce, and where does the file appear?
#
# Break it, then fix it: put ___ in the chunk, render, write down the error
# and the line number here:
#



# ---- 3. Weekly Challenge ----
# Problem:
# Use prairie_data.csv to show how richness changes with age_years and soil_type.
#
# Base goal:
# - Scatterplot of richness vs age_years
# - Color points by soil_type
# - Add labels and a readable theme
#
# Extension idea:
# - Add facet_wrap(~soil_type)
# - Add a trend line
# - Use a color-blind-safe palette



# ---- 4. Verification ----
# Before you commit and push:
# - Does the plot render in the Quarto document?
# - Are the labels readable and informative?
# - Can you explain the difference between mapping and setting?
# - Can you explain when to use a facet instead of color?
#
# Assignment 04 (Classroom 50, "Assignment 04 - The Visualization Brief"):
# - First Quarto submission: assignment.qmd, same prairie data
# - Written answers go in the PROSE sections, not as # comments in a chunk
# - Push assignment.qmd AND assignment.html, plus the edited README
# - Push from home. Due Sun, Oct 11, 11:59 PM.
