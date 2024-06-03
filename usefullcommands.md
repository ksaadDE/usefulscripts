## mess up mp4 exif
```bash
exiftool -ALL= /path/to/input.mp4
ffmpeg -i /path/to/input.mp4 -map 0 -map_metadata -1 -c copy /path/to/export.mp4
```
## split mp4 in kb defined parts
`mp4box -splits 2000000 filename.mp4`
e.g. ~2 GB parts

## exports git commit list (all) into a csv format
- `git log --pretty=format:'"%h","%an","%ad","%s"' --date-order --date=format:'%d.%m.%Y %H:%M:%S' > allCommits.csv`

## Flatten PDFs
- `convert -density 300 "in.pdf" "out.pdf"`
- `convert -density 120x120 -quality 20 -compress jpeg <in> <out>`
- `gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=output.pdf input.pdf`

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

[taken from maketecheasier.com](https://www.maketecheasier.com/find-large-files-linux)

### remove old snaps
```
#!/bin/bash
# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu

LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
```

[taken from linuxuprising.com](https://www.linuxuprising.com/2019/04/how-to-remove-old-snap-versions-to-free.html)


## GIT Commands
### Show Last modified files (only names)
`git show --pretty="" --name-only`
### Show Last modified files (names + content)
`git show`
### Show git history
`git log`

## 7z
### Max compression
`7z a archive.7z *.jpg -mx9`

### Unzip
`7z x archive.7z`

## Alpine
### Reinstall all apks
`apk info | xargs sudo apk fix`
source: https://unix.stackexchange.com/a/619479

### List installedp acks
`apk info`

### List available packs
`apk list`
