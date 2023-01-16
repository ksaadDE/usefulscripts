# usefullshellscripts
This Repo contains funny Bash Scripts. I write them all the time to make my daily tasks very easy. 

Despite I use some scripts only once, you may have a good day when you can use a out of the box solution ;)

### Github Repo Downloader
Download all your repos from Github, while maintaining the original datetimes (upload, edit etc).

Becaerful: It places them inside a json in your repo root, with a side note in README.md. 
Therefore it creates or writes to the README.md (therefore it's possible that you experience a few side effects) 

I wrote it in June 2021, because I had issues with the already given solutions. :-) 

### FindFile 
It's a very nice Tool to find text in files non-recursively without the need to open VS Code or smth. like that.
I wrote it because I had +2000 Files in a Dir (PHP Scripts btw) and I needed to find out one little var and I wanted to know in what files the var is included.
Successfully worked ;p

### DoInstall 
Uses docker-compose to setup a Env for the Mondial Database (if you're studying informatics it could be you need it)
It makes a lot of fun to write such shell scripts and even docker-compose :-)

### GetIP
The fast way to find out your external IP. (Needs inet connection)
I wrote it just 4 fun and maybe for future use in hacking labs
But mostly it wont work there, because the most vuln machines in the Labs don't have open inet connectivity due to obvious reasons :-D

### FileListing_Comapre
Two directories A and B. Changed files in both directories. To compare a filelist of A with the current directory B. The script goes over the filelist and uses bash's -f checks see if the file **exists**. There is **NO hash comparison** to check if both files are identical.
