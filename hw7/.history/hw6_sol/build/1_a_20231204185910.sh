#!/bin/bash

SCRIPT_INTRO="0:R:1:6,0:R:1:7,0:R:1:8,0:R:1:9,0:R:1:10,0:R:1:11,0:R:1:12,0:R:1:13,0:R:1:14,0.5:R:1:15,"
SCRIPT_MID="0:r:1:0,0:r:1:1,0:r:1:2,0:r:1:3,0:r:1:4,0:r:1:5,0:r:1:6,0:r:1:7,0:r:1:8,0:r:1:9,\ 0:b:1:0,0:b:1:1,0:b:1:2,0:b:1:3,0:b:1:4,0:b:1:5,0:b:1:6,0:b:1:7,0:b:1:8,0:b:1:9,\ 0:s:1:0,0:s:1:1,0:s:1:2,0:s:1:3,0:s:1:4,0:s:1:5,0:s:1:6,0:s:1:7,0:s:1:8,0:s:1:9,\ 0:v:1:0,0:v:1:1,0:v:1:2,0:v:1:3,0:v:1:4,0:v:1:5,0:v:1:6,0:v:1:7,0:v:1:8,0:v:1:9,\ 0:h:1:0,0:h:1:1,0:h:1:2,0:h:1:3,0:h:1:4,0:h:1:5,0:h:1:6,0:h:1:7,0:h:1:8,0:h:1:9,\ 0:r:1:0,0:r:1:1,0:r:1:2,0:r:1:3,0:r:1:4,0:r:1:5,0:r:1:6,0:r:1:7,0:r:1:8,0:r:1:9,\ 0:b:1:0,0:b:1:1,0:b:1:2,0:b:1:3,0:b:1:4,0:b:1:5,0:b:1:6,0:b:1:7,0:b:1:8,0:b:1:9,\ 0:s:1:0,0:s:1:1,0:s:1:2,0:s:1:3,0:s:1:4,0:s:1:5,0:s:1:6,0:s:1:7,0:s:1:8,0:s:1:9,\ 0:v:1:0,0:v:1:1,0:v:1:2,0:v:1:3,0:v:1:4,0:v:1:5,0:v:1:6,0:v:1:7,0:v:1:8,0:v:1:9,\ 0:h:1:0,0:h:1:1,0:h:1:2,0:h:1:3,0:h:1:4,0:h:1:5,0:h:1:6,0:h:1:7,0:h:1:8,0:h:1:9,"
SCRIPT_OUTRO="0:T:1:0,0:T:1:1,0:T:1:2,0:T:1:3,0:T:1:4,0:T:1:5,0:T:1:6,0:T:1:7,0:T:1:8,0:R:1:9"


for ((i = 1; i <= 10; i++)); do
    # Concatenate Intro, Mid repetitions, and Outro
    SCRIPT="${SCRIPT_INTRO}"
    for ((j = 1; j <= i; j++)); do
        SCRIPT="${SCRIPT}${SCRIPT_MID}"
    done
    SCRIPT="${SCRIPT}${SCRIPT_OUTRO}"

    # Run the server with time command
    /usr/bin/time -v ./server_mimg -q 1500 -w 10 -p FIFO 2222 > /dev/null & ./client 2222 -I ./images/ -L "${SCRIPT}" > /dev/null 
  
done
