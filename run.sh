#!/bin/bash

RPC_HOST="${RPC_HOST:-192.168.10.44}"
RPC_PORT="${RPC_PORT:-8548}"
RPC_USER="${RPC_USER:-}"
RPC_PASS="${RPC_PASS:-}"

CFG_FILE=/home/blockbook/build/blockchaincfg.json

sed -i 's/\"rpc_url\":.*/\"rpc_url\": \"ws:\/\/'${RPC_HOST}':'${RPC_PORT}'\",/g' $CFG_FILE

exec ./blockbook -sync -blockchaincfg=/home/blockbook/build/blockchaincfg.json -workers=${WORKERS:-1} -public=:${BLOCKBOOK_PORT:-9170} -debug=true -logtostderr -resyncindexperiod=60000 -resyncmempoolperiod=50213
