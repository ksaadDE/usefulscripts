#### useful git command
git log --pretty=format:'"%h","%an","%ad","%s"' --date-order --date=format:'%d.%m.%Y %H:%M:%S' > allCommits.csv
exports git commit list (all) into a csv format
