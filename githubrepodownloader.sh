#!/bin/bash
# Written by ksaadDE / 13 Jun 2021

# Adjust the GITUSER variable!!! Don't forget it (or create a .gituser file inside the username)
# Also set the token within the variable, as parameter (first one) or create a .token file, which is always loaded first!
# The token file gets automatically via chmod the permissions 0000 and then 0400, because others should not be able to read it. 

# Lets go :)
clear
LOGO="
IOKWhOKWhCDigKIg4paqICDiloTiloTiloTiloTiloQg4paEIC7iloTiloTigKIg4paE4paM4paE
4paE4paE4paEwrcgICAgIOKWhOKWhOKWhCAg4paE4paE4paEIC4g4paE4paE4paEwrcgICAgICAK
4paQ4paIIOKWgCDilqrilojilogg4oCi4paI4paIICDilojilojilqrilpDilojilojilqriloji
lojilozilpDilogg4paA4paI4paqICAgIOKWgOKWhCDilojCt+KWgOKWhC7iloDCt+KWkOKWiCDi
loTilojilqogICAgIAriloTilogg4paA4paI4paE4paQ4paIwrcg4paQ4paILuKWquKWiOKWiOKW
gOKWkOKWiOKWiOKWjOKWkOKWiOKWjOKWkOKWiOKWgOKWgOKWiOKWhCAgICDilpDiloDiloDiloQg
4paQ4paA4paA4paq4paEIOKWiOKWiOKWgMK3IOKWhOKWiOKWgOKWhCAK4paQ4paI4paE4paq4paQ
4paI4paQ4paI4paMIOKWkOKWiOKWjMK34paI4paI4paM4paQ4paA4paQ4paI4paE4paI4paM4paI
4paI4paE4paq4paQ4paIICAgIOKWkOKWiOKAouKWiOKWjOKWkOKWiOKWhOKWhOKWjOKWkOKWiOKW
qsK34oCi4paQ4paI4paMLuKWkOKWjArCt+KWgOKWgOKWgOKWgCDiloDiloDiloAg4paA4paA4paA
IOKWgOKWgOKWgCDCtyDiloDiloDiloAgwrfiloDiloDiloDiloAgICAgIC7iloAgIOKWgCDiloDi
loDiloAgLuKWgCAgICDiloDilojiloTiloDilqoKwrfiloTiloTiloTiloQgICAgICAgIOKWhOKW
hOKWjCDilpAg4paE4paMIOKWkCDiloQg4paE4paE4paMICAgICAgICAg4paE4paE4paEwrcgwrfi
loTiloTiloTiloQgIOKWhOKWhOKWhCAu4paE4paE4paEICAK4paI4paI4paqIOKWiOKWiCDilqog
ICAgIOKWiOKWiMK3IOKWiOKWjOKWkOKWiOKAouKWiOKWjOKWkOKWiOKWiOKWiOKAoiAg4paqICAg
ICDilpDilogg4paA4paIIOKWiOKWiOKWqiDilojilogg4paA4paELuKWgMK34paA4paEIOKWiMK3
CuKWkOKWiMK3IOKWkOKWiOKWjCDiloTilojiloDiloQg4paI4paI4paq4paQ4paI4paQ4paQ4paM
4paQ4paI4paQ4paQ4paM4paI4paI4paqICAg4paE4paI4paA4paEIOKWhOKWiOKWgOKWgOKWiCDi
lpDilojCtyDilpDilojilozilpDiloDiloDilqriloTilpDiloDiloDiloQgCuKWiOKWiC4g4paI
4paIIOKWkOKWiOKWjC7ilpDilozilpDilojilozilojilojilpDilojilozilojilojilpDiloji
lozilpDilojilozilpDilozilpDilojilowu4paQ4paM4paQ4paIIOKWquKWkOKWjOKWiOKWiC4g
4paI4paIIOKWkOKWiOKWhOKWhOKWjOKWkOKWiOKAouKWiOKWjAriloDiloDiloDiloDiloDigKIg
IOKWgOKWiOKWhOKWgOKWqiDiloDiloDiloDiloAg4paA4paq4paA4paAIOKWiOKWqi7iloDiloDi
loAgIOKWgOKWiOKWhOKWgOKWqiDiloAgIOKWgCDiloDiloDiloDiloDiloDigKIgIOKWgOKWgOKW
gCAu4paAICDiloAK
";
GITUSER="" # later loaded from the .gituser file!
CPAGE=0
ENTRIESPERPAGE=500
REPOSFOLDER="repos";
REPOSFILE="data.json"
REPOSTXT="gitreposlist.txt";
PRIVATEREPOS=true;

echo -e "\e[35m";
echo "$LOGO" | base64 -d;
echo -e "\e[0m";
echo " ";
echo " ";

function showHelp {
        echo -e "=== \e[5m \e[93m HELP \e[0m \e[91mGITHUB DOWNLOADER TOOL [by ksaadDE in Jun 2021] \e[0m ====";
	echo -e "\r$0 -h or --help\t\tshows this help\r";
        echo -e "\r$0 <Git AccessToken>\tfor downloading private repos";
	echo " ";
	echo -e "\e[97mIf you leave the first parameter(=token) out, it will download the pub repos ONLY!\nDon't forget to set the Username in the .gituser file!\n You can also set the Access Token in the .token file (it will be the first choice over parameter!)!\e[0m";
        return 1;
}

if [ ! -f ".gituser" ]; then
	echo "[i] .gituser File didn't exist, so I created it, please place your username in it! (before running the script)"; 
	echo "" > ".gituser";
	exit;
fi

GITUSER=$(cat ".gituser");

if [ -z "$GITUSER" ]; then
	echo "[i] .gituser File is empty or you didn't set the GITUSER variable correctly!"; 
	showHelp;
        exit;
fi



if [ "$1" == "--help" ]; then
        showHelp;
        exit;
fi

if [ "$1" == "-h" ]; then 
        showHelp;
        exit;
fi


tokenFromFile=false
if [ -f ".token" ]; then
        TOKEN=$(cat ".token");
	tokenFromFile=true
	# the token file gets protected by only allowing to read by the same user (it's also not really secure :-))
	chmod 0000 ".token";
	chmod 0400 ".token";
else
        TOKEN=$1
fi

if [ -z $TOKEN ]; then
        TOKEN="not provided";
        PRIVATEREPOS=false;
fi

# never showing the real token unless wished :-)
OUTPUTTOKEN=$(echo $TOKEN | sed "s/.*/************************/");

SETTINGS="\e[97m
\r\t==================== SETTINGS ===========================\e[0m\n
\n
\tGITUSER:\t\t\t$GITUSER\n
\tCurrent Page:\t\t\t$CPAGE\n
\tEntries Per Page:\t\t$ENTRIESPERPAGE\n
\tREPOSFILE:\t\t\t$REPOSFILE\n
\tREPOSTXT:\t\t\t$REPOSTXT\n
\tREPOSFOLDER:\t\t\t$REPOSFOLDER/\n
\tTOKEN:\t\t\t\t$OUTPUTTOKEN\n
\tPRIVATEREPOS:\t\t\t$PRIVATEREPOS\n
\n
\e[97m\r\t=========================================================\e[0m\n
";

echo -e $SETTINGS;

if [ "$tokenFromFile" == "true" ]; then
	echo "[i] Token FROM .token TOKEN FILE used!";
fi



if [ "$TOKEN" == "not provided" ]; then
	echo "[i] switching to only public availabe repos [mode] - token not provided (if .tokenneeded file exists it will purge the cache)";
	if [ -f ".tokenneeded" ]; then
		# cache was private, now it needs to be public (redownload)
		rm $REPOSFILE &> /dev/null;
		rm $REPOSTXT &> /dev/null;
		rm ".tokenneeded";
		echo "[i] DELETED CACHE [private->public] $REPOSFILE, $REPOSTXT and .tokenneeded";
	fi
else
        if [ ! -f ".tokenneeded" ]; then
                # cache was public, now it needs to be private (redownload)
                rm $REPOSFILE &> /dev/null;
                rm $REPOSTXT &> /dev/null;
                echo "[i] DELETED CACHE [public->private] $REPOSFILE, $REPOSTXT and .tokenneeded";
        fi

	# token provided -> set it private
	echo "true" > ".tokenneeded";
fi

if [ ! -f "$REPOSFILE" ]; then 
	echo "[+] Downloading REPOList of User $GITUSER to File $REPOSFILE";
	if [ "$PRIVATEREPOS" == "false" ]; then
		# public available repos, default (no access token needed)
		curl -s -o "$REPOSFILE" "https://api.github.com/users/$GITUSER/repos?page=$CPAGE&per_page=$ENTRIESPERPAGE"
	else
		# private repos of user, api access token needed(!)
		curl -s -o "$REPOSFILE" -H "Authorization: token $TOKEN" -L "https://api.github.com/user/repos"
	fi
	echo "[=] Completed";
else
	echo "[i] SKIPPING API CALL [fetching of REPOLIST] because $REPOSFILE already exist, delete it to refresh the Repolist";
fi


if [ ! -f "$REPOSTXT" ]; then 
	echo "[+] Extracting GIT Urls out of File $REPOSFILE to File $REPOSTXT";
	cat "$REPOSFILE"  | jq '[.[] | {url: .git_url} ]' | grep "url" | cut -d" " -f6  | cut -d'"' -f2  > "$REPOSTXT"
	k=$(cat "$REPOSTXT" | wc -l);
	echo "[=] Extracted $k Repositories (1 Repo = 1 URL = 1 Line)";
else
	echo "[i] SKIPPING EXTRACTION of GitUrls and Reponames, because $REPOSTXT already exists!";
	k=$(cat "$REPOSTXT" | wc -l);
	echo "[+] Loaded $k Repositories (1 Repo = 1 URL = 1 Line) [CACHED]";
fi

echo " ";
echo -e "\e[5m[WAIT]";
echo -e "\e[0m\e[31m I am allowed to download all repos in $REPOSFOLDER/ folder?\e[0m"
echo -e "\e[97mEnter \e[1m'yes'\e[0m\e[97m if so, if not enter anything else! \e[0m";
echo " ";

stty -echo
read shouldIContinue
stty echo

if [  "$shouldIContinue" == "yes" ]; then
	echo "[+] Starting Downloads";
	max=$(cat "$REPOSTXT" | wc -l);
	i=1;
	for x in $(cat "$REPOSTXT"); do
		name=$(echo "$x" | cut -d "." -f2 | cut -d "/" -f3);
		left=$(expr $max - $i);
		apiUrl="https://api.github.com/repos/$GITUSER/$name";
		cloneUrl="https://$TOKEN@github.com/$GITUSER/$name";
		jsonInfoFileName="downloaderInfo.json";
		jsonInfoFile="$REPOSFOLDER/$name/$jsonInfoFileName";
		readmeFile="$REPOSFOLDER/$name/README.md"; # it adds the timestamp json info link to the readme.md
		alternativeReadmeFile="REPOSFOLDER/$name/readme.md"
		jsonParmsForFile='{created_at: .created_at, pushed_at: .pushed_at, update_at: .updated_at}' # which elements (by keys) out of the json array should be taken? :-) (e.g. datetime like (.)created_at)
		oldInfoMessage="This repo was cloned and repushed, view original Repo Timestamps and other Infos by click here to $jsonInfoFileName]($jsonInfoFileName)"
		bothReadmesDoesnstExist=true
		
		echo -e "\e[5m \e[1m \e[10 \e[97m  $left Repos left \e[0m ";
		echo "[+] Starting download of Repository '$name'";
		git clone "$cloneUrl" "$REPOSFOLDER/$name";
		if [ "$PRIVATEREPOS" == "true" ]; then
			# When Token used, it could be a private repo, so always use the token here
			echo $(curl -s -H "Authorization: token $TOKEN" -L "$apiUrl" | jq "$jsonParmsForFile")  > "$jsonInfoFile";
			echo "[i] added $jsonInfoFile";
		else
			# If no token provided treat every repo as public repo :)
			echo $(curl -s "$apiUrl" | jq "$jsonParmsForFile")  > "$jsonInfoFile";
			echo "[i] added $jsonInfoFile";
		fi

		if [ -f "$readmeFile" ]; then
                	echo "$oldInfoMessage" >> "$readmeFile";
			echo "[i] Saved InfoMessage to $readmeFile";
			bothReadmesDoesnstExist=false;
               	else

	        	if [ -f "$alternativeReadmeFile" ]; then
                		echo "$oldInfoMessage" >> "$alternativeReadmeFile";
				echo "[i] Saved Info message to $alternativeReadmeFile";
				bothReadmesDoesnstExist=false;
                	fi
		fi

		if [ "$bothReadmesDoesnstExist" == "true" ]; then
			dtm=$(date "+%d.%m.%Y %H:%M:%S");
			dtm2=$(date "+%Y-%m-%d %H:%M:%S");
			echo "[i] creating $readmeFile";
			echo "#$name" > $readmeFile;
			echo " " > $readmeFile;
			echo "$oldInfoMessage" >> $readmeFile;
			echo " " >> $readmeFile;
			echo "[Created README.md by Tool -- German Format: $dtm | English Format: $dtm2]" >> $readmeFile;
		fi


		echo "[=] Completed '$name'";
		echo " ";
		i=$(expr $i + 1);
		#exit; - debug break
	done
	echo "[=] Completed";
else 
	echo "[i] Ok, I'm not allowed to download the repos ;)";
	exit;
fi
