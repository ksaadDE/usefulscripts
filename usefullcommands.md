## exports git commit list (all) into a csv format
- `git log --pretty=format:'"%h","%an","%ad","%s"' --date-order --date=format:'%d.%m.%Y %H:%M:%S' > allCommits.csv`

## Flatten PDFs
- `convert -density 300 "in.pdf" "out.pdf"`
- `convert -density 120x120 -quality 20 -compress jpeg <in> <out>`

## Docx -> PDF
- `soffice --headless --convert-to pdf docx/* pdf/`

## clean disk space

### if pacman and journalctl:
```
pacman -Sc
pacman -Qdt
pacman -Rns $(pacman -Qtdq)
journalctl --vacuum-size=50M
```

### if apt and jctl
```
apt-get clean
journalctl --vacuum-size=50M
```

### find large files
`find / -xdev -type f -size +100M`
taken from: https://www.maketecheasier.com/find-large-files-linux

*clean*
``
