# NRES 800: Student Follow-Along Script
# Week 16: Capstone Showcase
# Name: [Your Name]

# ---- 1. Pre-Submission Final Checklist ----
# Work through this checklist before your final push on Dec 14.
# Mark each item [X] when it passes. Leave [ ] if you still need to fix it.

# REPRODUCIBILITY
# [ ] I can clone my own repo to a new folder and render without modifying any file.
# [ ] All file paths use here::here() — no absolute paths (e.g., no /Users/myname/...).
# [ ] All raw data files are present in the repo (check: git status shows them tracked).
# [ ] The .Rproj file is at the project root and opens the project correctly.
# [ ] renv.lock is present (if using renv) OR all packages are listed at the top of the .qmd.

# DATA MANAGEMENT
# [ ] Raw data is in a dedicated folder (e.g., data/raw/) and has not been manually edited.
# [ ] Cleaned/derived data is in a separate folder (e.g., data/processed/) if applicable.
# [ ] I have a comment or prose section explaining how I handled NA values.
# [ ] Variable names are consistent throughout (no mixing of snake_case and CamelCase).
# [ ] The dataset source (where I got the data) is documented in the README or report.

# VISUALIZATION
# [ ] Every figure has a fig-cap in the Quarto chunk options.
#     Example: #| fig-cap: "Mean body mass by species and sex (Palmer penguins, n = 333)."
# [ ] Figure captions describe the pattern in the data, not just the variables plotted.
# [ ] Each visualization uses a colorblind-friendly palette (viridis or RColorBrewer).
# [ ] Axis labels include units where applicable (e.g., "Body mass (g)", not just "mass").
# [ ] No overlapping text or cut-off axis labels.

# SCIENTIFIC COMMUNICATION
# [ ] The report has clear section headers: Introduction, Methods, Results, Interpretation.
# [ ] My interpretation is consistent with what my figures actually show.
# [ ] I do not claim causation from observational data.
# [ ] Conclusions are hedged appropriately ("suggests," "is associated with," not "proves").
# [ ] If I used AI assistance, there is a short AI methods note at the end of the report.

# CODE QUALITY
# [ ] All code chunks are labeled (e.g., #| label: fig-richness-by-site).
# [ ] Comments explain why decisions were made, not just what the code does.
# [ ] There is no dead code (commented-out experiments) left in the final document.
# [ ] Libraries are loaded once, at the top of the document.
# [ ] No warning: and message: output appears in the rendered HTML.
#     (Use #| warning: false and #| message: false in chunk options.)

# README
# [ ] The README explains what the project is about (1-2 sentences).
# [ ] The README lists the dataset used and where it came from.
# [ ] The README explains how to reproduce the analysis (which file to render).
# [ ] The README is written for someone who has never seen this project before.

# ---- 2. Peer Reproducibility Check ----
# During class, a peer will attempt to clone and render your repo.
# Use this space to record what they found and how you fixed it.

# Peer who tested my repo: [Name]
# Date tested: Dec 07, 2026

# Issues found during peer check:
# 1.
# 2.
# 3.

# Fixes applied before final submission:
# 1.
# 2.
# 3.

# ---- 3. Self-Reflection ----
# Answer these questions as comments. Be honest — this is for your own growth.

# Q1: What is one thing this project does well?
#


# Q2: What is the single most important thing you would improve with more time?
#


# Q3: Which week's skill ended up being most useful for YOUR specific project?
#


# Q4: What question does your data raise that you could not answer with this semester's tools?
#


# Q5: If you used AI assistance, what did it help with most — and where did it fall short?
#


# ---- 4. Verification Before Final Push ----
# Run these lines interactively to do a final environment check.
# (These are checks, not submission code — adapt the file names to your project.)

# Check that here() resolves to the project root:
# library(here)
# here()  # Should return your project root, not a subfolder.

# List all tracked files to confirm data is present:
# system("git status")

# Render the report one final time from a clean session:
# (Session -> Restart R, then:)
# quarto::quarto_render("your_report.qmd")

# Confirm the rendered HTML opens and all figures appear:
# browseURL("your_report.html")
