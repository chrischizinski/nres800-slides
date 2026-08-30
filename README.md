# NRES 800 course slides

> This is a generated public release. The parent NRES 800 course workspace is
> the only editable source of truth for weekly slide decks, shared styling, and
> released assets. Use `python3 scripts/sync_course_slides.py --publish` from
> that workspace; do not edit `slides/`, `styles/`, `assets/`, or `index.qmd`
> here.

This repository hosts the public HTML lecture slides for **NRES 800: Data
Management and Visualization**. Canvas remains the primary learning-management
system for course schedules, assignments, quizzes, grades, announcements,
deadlines, and submissions.

The website is intentionally small: it is a stable home for released lecture
slides. Do not add student information, grades, answer keys, private Canvas
material, restricted assessments, unpublished sensitive data, or copyrighted
material that cannot be publicly redistributed.

## Publication workflow

Edit and preview a deck in the parent course workspace. Its inclusion in
`course-design/course-slides.toml` is the explicit public-release gate. Then
run:

```bash
python3 scripts/sync_course_slides.py --publish
```

The command synchronizes only allowlisted public files, verifies a Quarto
render, commits the generated changes, and pushes them to `main`. The GitHub
Action then publishes the site.

## GitHub Pages

Once GitHub Pages has been initialized, each push to `main` triggers the
**Quarto Publish** workflow. For a repository named `nres800-slides` owned by
`USERNAME`, the site URL is approximately:

```text
https://USERNAME.github.io/nres800-slides/
```

Keep a slide filename unchanged after linking it from Canvas: revising its
contents preserves the stable URL, while renaming it does not.
