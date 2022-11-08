#!/bin/bash
#특정 프로세스 검색 후 검색되는 개수 반환
echo `ps aux | grep ${1} | grep -v grep | grep -v bash | wc -l`
