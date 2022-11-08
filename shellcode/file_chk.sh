#!/bin/bash
#특정 경로의 파일 유효성 검사

ls -l ${1} 2>/dev/null | wc -l
