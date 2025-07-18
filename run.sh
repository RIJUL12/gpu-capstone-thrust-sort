#!/bin/bash
make clean
make build
./thrustSort.exe 20 > output.log
cat output.log
