#!/bin/bash

stat ${1} 2>/dev/null | grep Access | head -1 | awk -F '(' '{print $2}' | awk -F '/' '{print $1}'
