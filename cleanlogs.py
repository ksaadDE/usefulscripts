#!/bin/python3
# created_at: 03.11.2023
# Truncates Log Files to size 0 in /var/log, /tmp and /var/lib/docker/containers
# returns metric message

import logging
import sys
from operator import add

logging.basicConfig(stream=sys.stdout, level=logging.ERROR)

from pathlib import Path

dockerContainerPath="/var/lib/docker/containers"
sysLogPath="/var/log"
tmpLogPath="/tmp"

def cleanLogsInPath(p):
    amount=0
    cleanedAmount=0
    failedAmount=0
    for path in Path(p).rglob('*.log'):
        amount+=1
        try:
            fpath=path.resolve()
            with open(fpath, 'r+') as f:
            f.truncate(0)
            logging.info("[+] truncated logfile '{}'".format(fpath))
            cleanedAmount+=1
        except Exception as e:
            logging.exception(e)
            print("[-] ERROR".format(e))
            failedAmount+=1
    return [amount, cleanedAmount, failedAmount]

def calcSums (ar=[]):
    previous=[]
    for i in range(0, len(ar)):
        if i == 0:
            previous=ar[i]
        else:
            previous=list( map(add, previous, ar[i]) )
    return previous


amount1 = cleanLogsInPath (dockerContainerPath)
amount2 = cleanLogsInPath (sysLogPath)
amount3 = cleanLogsInPath (tmpLogPath)

sums = calcSums([amount1, amount2, amount3])

totalFiles=sums[0]
totalCleaned=sums[1]
totalFailed=sums[2]

percentageSuccess = round((totalCleaned/totalFiles), 2)*100

print("[+] Truncated Log Files. [total: {}, success: {}, failed: {}, percent:{:.2f}]".format(totalFiles, totalCleaned, totalFailed, percentageSuccess))
