# Useful Scripts & Notes
This repository contains some funny scripts. I write them all the time, they make my daily tasks very easy. Further I am taking some notes on things that I came across. Despite I use some scripts only once, you may have a good day when you can use a out of the box solution ;)

### Github Repo Downloader
Download all your repos from Github, while maintaining the original datetimes (upload, edit etc).

Be careful: It places them inside a json in your repo root, with a side note in README.md. 
Therefore it creates or writes to the README.md, so it is possible that you might experience a few side effects 

I wrote it in June 2021. I had issues with the already existing solutions. :-) 

### FindFile 
It is a very nice Tool to find text in files non-recursively without the need to open VS Code or smth. like that.
I wrote it because I had +2000 Files in a Dir (btw PHP Scripts) and I needed to find out one little var and I wanted to know in what files the var is included.
Worked successfully ;p

### DoInstall 
This uses docker-compose to setup a Env for the Mondial Database. If you're studying informatics you will probably need it.
It makes a lot of fun to write such shell scripts and even docker-compose configs :-)

### GetIP
The fast way to find out your external IP. Obviously needs an inet connection. I wrote it just 4fun and maybe for future use in some Hacking Labs.
Sadly, in most labs it will not work there. Most vuln machines in the Labs do not have open inet connectivity, due to obvious reasons :-D

### FileListing_Comapre
Two directories A and B. Changed files in both directories. To compare a filelist of A with the current directory B. The script goes over the filelist and uses bash's -f checks see if the *file or directory* **exists**. There is **NO hash comparison** to check if both files are identical.

### Wekan Snap Writeup
I just came across interesting claims in the issues Tab of Wekan Snap and tried to fix the TLS config, showing people how it works. 
- [wekan_snap_writeup.md](wekan_snap_writeup.md)

### CleanLogs.py
- Truncats the log files in `/var/log`, `/var/lib/docker/containers` and `/tmp`
- Returns a metric message

### Adding Abbreviation Detector for SpacyNLP from SciSpacy
During some NLP information extraction I wanted to get rid of the abbreviations. I came across Scispacy but the installation fails.. https://github.com/allenai/scispacy/issues/504 - Surrender? Nah, no problem for me, I just had to rip that Abbreviation piece out and use it in my project.
- [adding_abbreviation_detection_to_your_spacy_nlp_project.md](adding_abbreviation_detection_to_your_spacy_nlp_project.md)

### Download Cloudflare Stream Video 
Works when the video is embedded with iframe!

1. Get the video's m3u8 and open it in a text editor, copy the fname located in there, depending on th resolution you need
```
https://customer-<CustomerID>.cloudflarestream.com/<VideoId>/manifest/video.m3u8
```
2. Put the copied fname in at the `<fname>` location and save it to `live.mp4` via `ffmpeg`
```
ffmpeg -i "https://customer-<CustomerID>.cloudflarestream.com/<VideoId>/manifest/<fname>.m3u8?useMezzanine=true" -c copy -bsf:a aac_adtstoasc live.mp4
```

### authentik + nextcloud
How to configure Authentik and Nextcloud to work with each other and allow user authentication and authorization?
https://github.com/goauthentik/authentik/discussions/9737#discussioncomment-12419903


