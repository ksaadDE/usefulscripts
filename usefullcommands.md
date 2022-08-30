#### exports git commit list (all) into a csv format
- `git log --pretty=format:'"%h","%an","%ad","%s"' --date-order --date=format:'%d.%m.%Y %H:%M:%S' > allCommits.csv`

#### Flatten PDFs
- `convert -density 300 "in.pdf" "out.pdf"`
