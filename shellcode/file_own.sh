#!/bin/bash
#ls -l ${1} 2>/dev/null | awk '{print $3}'
stat ${1} 2>/dev/null | grep Uid | awk -F 'Uid' '{print $2}' | awk -F 'Gid' '{print $1}' | awk -F ')' '{print $1}' | awk -F '/' '{print $2}' | tr -d ' '





