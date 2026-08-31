# NRES 800: Student Follow-Along Script
# Week 15: Professional Review and Revision
# Name: [Your Name]

# ---- 1. Overview ----
# This week there is no new R syntax to learn.
# Your task is to conduct a structured peer review of your assigned
# classmate's capstone repository using the GitHub Pull Request workflow.
#
# Use this script as a working notepad:
#   - Copy the checklist below into your review
#   - Draft your comments here before posting them on GitHub
#   - Record your own revision decisions as you respond to feedback


# ---- 2. Reproducibility Checklist ----
# Complete this checklist FIRST after cloning your partner's repo.
# Check each item by replacing [ ] with [x] in your notes.

reproducibility_checklist <- "
REPRODUCIBILITY CHECKLIST
Partner's repo: [paste GitHub URL here]
Reviewer name:  [Your Name]
Date reviewed:  [YYYY-MM-DD]

[ ] 1. I can clone the repo fresh (does not require any special permissions)
[ ] 2. The project uses an .Rproj file or renv.lock / similar environment record
[ ] 3. All file paths are project-relative (no setwd(), no absolute paths)
[ ] 4. The main analysis document (Quarto or R Markdown) renders without errors
       from a fresh clone
[ ] 5. All figures appear in the rendered output
[ ] 6. Missing data decisions are documented (when rows are removed, it is
       stated how many and why)
[ ] 7. Every figure has a caption that describes the trend, not just the variables
[ ] 8. Conclusions stated in the text are supported by visible output
       (numbers, table, or plot)
[ ] 9. The README explains what the project is and how to reproduce it
[ ] 10. Raw data files are present (or a download script is provided) and
        the original files have not been overwritten
"


# ---- 3. Peer Review Comment Drafts ----
# Use the LOCATION + OBSERVATION + CONCERN + SUGGESTION structure.
# Draft your three required substantive comments here before posting on GitHub.

# COMMENT 1 ---------------------------------------------------------------
# Location (file and line number):
comment_1_location <- "[filename, line XX]"

# Observation (what did you actually see?):
comment_1_observation <- "[Describe exactly what is in the code or output]"

# Concern (why does it matter for reproducibility, inference, or clarity?):
comment_1_concern <- "[Explain the problem in one or two sentences]"

# Suggestion (what specific change would fix it?):
comment_1_suggestion <- "
```r
# Paste a code suggestion here if applicable
```
"

# Final comment text (combine above into one block to paste into GitHub):
comment_1_final <- "
**[Location]**

[Observation]. [Concern].

Suggested revision:
```r
[code suggestion]
```
"


# COMMENT 2 ---------------------------------------------------------------
comment_2_location <- "[filename, line XX]"
comment_2_observation <- "[What did you see?]"
comment_2_concern <- "[Why does it matter?]"
comment_2_suggestion <- "[What should change?]"

comment_2_final <- "
**[Location]**

[Observation]. [Concern].

Suggested revision:
[text or code suggestion]
"


# COMMENT 3 ---------------------------------------------------------------
comment_3_location <- "[filename, line XX]"
comment_3_observation <- "[What did you see?]"
comment_3_concern <- "[Why does it matter?]"
comment_3_suggestion <- "[What should change?]"

comment_3_final <- "
**[Location]**

[Observation]. [Concern].

Suggested revision:
[text or code suggestion]
"


# ---- 4. GitHub Issue Draft ----
# Use an Issue when you have a methodological question that requires
# discussion before deciding whether anything needs to change.
# Your issue should be posted on your PARTNER's repo, not as a PR comment.

github_issue_draft <- "
**Title:** [State the decision or question clearly, e.g., 'Decision needed: should 2019 be excluded?']

**Context:**
[Describe where in the analysis the question arises — file name and lines if possible]

**Question:**
[What is the specific methodological decision that needs to be made?]

**Why it matters:**
[One or two sentences on how this decision could affect the conclusions]

**Suggested next steps:**
- [ ] Author responds with the current justification
- [ ] Both parties agree on the decision
- [ ] Author updates Methods section (and notes any changes in the PR if needed)

Relates to PR #[number].
"


# ---- 5. Responding to Received Feedback ----
# After your partner reviews YOUR capstone, record the changes you plan to make
# and use this as a checklist before your revision commits.

received_feedback_log <- "
FEEDBACK RECEIVED ON MY CAPSTONE
Reviewer: [Partner name]
PR link:  [paste URL]

Comment 1: [paste comment or summarize]
  My plan: [what you will change]
  Commit:  [paste commit hash after you push]

Comment 2: [paste comment or summarize]
  My plan: [what you will change]
  Commit:  [paste commit hash after you push]

Comment 3: [paste comment or summarize]
  My plan: [what you will change]
  Commit:  [paste commit hash after you push]
"


# ---- 6. Verification ----
# Before you submit:
# - Did you post 3+ substantive PR comments on your partner's repo?
# - Did you open at least 1 GitHub Issue for a methodological question?
# - Did you push at least 2 revision commits responding to feedback on YOUR repo?
# - Do your revision commit messages explain WHAT changed and WHY?
# - Did you @mention your reviewer after pushing revisions?
