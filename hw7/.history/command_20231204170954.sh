#!/bin/bash
Intro="0:R:1:6,0:R:1:7,0:R:1:8,0:R:1:9,0:R:1:10,0:R:1:11,0:R:1:12,0:R:1:13,0:R:1:14,0.5:R:1:15,"

# for part a and b
# Mid="0:r:1:0,0:b:1:0,0:s:1:0,0:v:1:0,0:h:1:0,0:r:1:0,0:b:1:0,0:s:1:0,0:v:1:0,0:h:1:0,\
# 0:r:1:1,0:b:1:1,0:s:1:1,0:v:1:1,0:h:1:1,0:r:1:1,0:b:1:1,0:s:1:1,0:v:1:1,0:h:1:1,\
# 0:r:1:2,0:b:1:2,0:s:1:2,0:v:1:2,0:h:1:2,0:r:1:2,0:b:1:2,0:s:1:2,0:v:1:2,0:h:1:2,\
# 0:r:1:3,0:b:1:3,0:s:1:3,0:v:1:3,0:h:1:3,0:r:1:3,0:b:1:3,0:s:1:3,0:v:1:3,0:h:1:3,\
# 0:r:1:4,0:b:1:4,0:s:1:4,0:v:1:4,0:h:1:4,0:r:1:4,0:b:1:4,0:s:1:4,0:v:1:4,0:h:1:4,\
# 0:r:1:5,0:b:1:5,0:s:1:5,0:v:1:5,0:h:1:5,0:r:1:5,0:b:1:5,0:s:1:5,0:v:1:5,0:h:1:5,\
# 0:r:1:6,0:b:1:6,0:s:1:6,0:v:1:6,0:h:1:6,0:r:1:6,0:b:1:6,0:s:1:6,0:v:1:6,0:h:1:6,\
# 0:r:1:7,0:b:1:7,0:s:1:7,0:v:1:7,0:h:1:7,0:r:1:7,0:b:1:7,0:s:1:7,0:v:1:7,0:h:1:7,\
# 0:r:1:8,0:b:1:8,0:s:1:8,0:v:1:8,0:h:1:8,0:r:1:8,0:b:1:8,0:s:1:8,0:v:1:8,0:h:1:8,\
# 0:r:1:9,0:b:1:9,0:s:1:9,0:v:1:9,0:h:1:9,0:r:1:9,0:b:1:9,0:s:1:9,0:v:1:9,0:h:1:9,"

# for part c
Mid="0:r:1:0,0:r:1:1,0:r:1:2,0:r:1:3,0:r:1:4,0:r:1:5,0:r:1:6,0:r:1:7,0:r:1:8,0:r:1:9,\
0:b:1:0,0:b:1:1,0:b:1:2,0:b:1:3,0:b:1:4,0:b:1:5,0:b:1:6,0:b:1:7,0:b:1:8,0:b:1:9,\
0:s:1:0,0:s:1:1,0:s:1:2,0:s:1:3,0:s:1:4,0:s:1:5,0:s:1:6,0:s:1:7,0:s:1:8,0:s:1:9,\
0:v:1:0,0:v:1:1,0:v:1:2,0:v:1:3,0:v:1:4,0:v:1:5,0:v:1:6,0:v:1:7,0:v:1:8,0:v:1:9,\
0:h:1:0,0:h:1:1,0:h:1:2,0:h:1:3,0:h:1:4,0:h:1:5,0:h:1:6,0:h:1:7,0:h:1:8,0:h:1:9,\
0:r:1:0,0:r:1:1,0:r:1:2,0:r:1:3,0:r:1:4,0:r:1:5,0:r:1:6,0:r:1:7,0:r:1:8,0:r:1:9,\
0:b:1:0,0:b:1:1,0:b:1:2,0:b:1:3,0:b:1:4,0:b:1:5,0:b:1:6,0:b:1:7,0:b:1:8,0:b:1:9,\
0:s:1:0,0:s:1:1,0:s:1:2,0:s:1:3,0:s:1:4,0:s:1:5,0:s:1:6,0:s:1:7,0:s:1:8,0:s:1:9,\
0:v:1:0,0:v:1:1,0:v:1:2,0:v:1:3,0:v:1:4,0:v:1:5,0:v:1:6,0:v:1:7,0:v:1:8,0:v:1:9,\
0:h:1:0,0:h:1:1,0:h:1:2,0:h:1:3,0:h:1:4,0:h:1:5,0:h:1:6,0:h:1:7,0:h:1:8,0:h:1:9,"

Outro="0:T:1:0,0:T:1:1,0:T:1:2,0:T:1:3,0:T:1:4,0:T:1:5,0:T:1:6,0:T:1:7,0:T:1:8,0:R:1:9"

for i in $(seq 1 10); do
    Script="${Intro}"

    for j in $(seq 1 $i); do
        Script="${Script}${Mid}" 
    done

    Script="${Script}${Outro}"
    /usr/bin/time -v ./hw6_sol/build/server_mimg > ./hw6_sol/build/data/s_c${i}.txt -q 1500 -w 10 -p FIFO 2000 & 
    SERVER_PID=$!
    ../hw7_client_and_images/client > ./hw6_sol/build/data/c_c${i}.txt 2000 -I ./hw7_client_and_images/images/ -L ${Script}
    kill $SERVER_PID
done
# for i in $(seq 3 3); do
#     Script="${Intro}"

#     for j in $(seq 1 $i); do
#         Script="${Script}${Mid}" 
#     done

#     Script="${Script}${Outro}"
#     LD_PRELOAD=./libcrash.so ./build/server_mimg -q 1500 -w 10 -p FIFO 2000 & 
#     # SERVER_PID=$!
#     ./client 2000 -I ./images/ -L ${Script}
#     # kill $SERVER_PID
# done

echo Done!