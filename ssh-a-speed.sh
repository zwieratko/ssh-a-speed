#!/usr/bin/env bash

for j in 16 32 64 100 200; do
    echo -n "-a $j takes on average: ";
    for i in {1..5}; do
        ssh-keygen -qa $j -t ed25519 -f test -N test;
        time ssh-keygen -qa $j -N tost -pP test -f test;
        rm test{.pub,};
    done |& grep real | awk -F m '{print $2}' | tr -d s | awk '{sum+=$1} END{print sum/NR}';
done
