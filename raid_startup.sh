#!/bin/bash
# runs on startup after reboot 
# -> restarts the raid /dev/mdX (inactive)
# --> decrypts the RAID to /dev/mapper/mdX
# ---> mounts it to /mnt/mdX 
# ----> using LUKS key /root/luks.key

raidName="mdX"                     # mdX
keyfile="/root/luks.key"           # /root/luks.key
devPath="/dev/$raidName"           # /dev/mdX
mapperPath="/dev/mapper/$raidName" # /dev/mapper/mdX
mntPath="/mnt/$raidName"           # /mnt/mdX

# reassemble mdadm array 
while [ ! -b /dev/md0 ]; do /sbin/mdadm --assemble --scan --verbose &> /dev/kmsg; sleep 30; done

# luksOpen (decrypt) using /root/luks.key from /dev/mdX (mdadm raid) to /dev/mapper/mdX (decrypted lukspart)
cryptsetup luksOpen "$devPath" --key-file "$keyfile" "$deviceName" &> /dev/kmsg

# creating /mnt/mdX if not existing
if [ ! -d "$mntPath" ]; then
	mkdir "$mntPath"
fi

# mount /dev/mapper/mdX (decrypted LUKS) ->  /mnt/mdX
mount -t btrfs "$mapperPath" "$mntPath" &> /dev/kmsg
