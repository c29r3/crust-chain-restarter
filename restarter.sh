#!/bin/bash

GREEN="\e[92m"
RED="\e[91m"
NORMAL="\e[39m"
SLEEP_SEC=18
IP=$(curl -s 2ip.ru)
TG_TOKEN=$1
CHAT_ID=861331048
SUBJECT="CRUST"

while true
do
  CURRENT_BLOCK=$(curl -s 'http://localhost:56666/api/v1/block/header' | jq -r .number)
  echo -e ${GREEN}"[$($(which date))] Current block: ${CURRENT_BLOCK}"${NORMAL}
  sleep $SLEEP_SEC
  NEW_BLOCK=$(curl -s 'http://localhost:56666/api/v1/block/header' | jq -r .number)
  
  if [[ $CURRENT_BLOCK == $NEW_BLOCK ]]
  then
    MSG="[$($(which date))] ${HOSTNAME} ${IP} | The block has not changed for ${SLEEP_SEC} seconds. Current block = ${CURRENT_BLOCK}"
    echo -e ${RED}"${MSG}"${NORMAL}
    
    if [[ $TG_TOKEN != "" ]]
    then
      $(which curl) -s -H 'Content-Type: application/json' --request 'POST' -d "{\"chat_id\":\"${CHAT_ID}\",\"text\":\"${SUBJECT}\n${MSG}\"}" "https://api.telegram.org/bot${TG_TOKEN}/sendMessage"
    fi
    
    $(which docker) restart crust crust-api
    sleep 60
  fi
done
