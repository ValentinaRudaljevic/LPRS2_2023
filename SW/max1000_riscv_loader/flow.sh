#!/bin/bash

exit 0

./waf configure
./waf build
./waf run
#TODO instead of ./waf run
./build/max1000_riscv_loader ../../FW/Scripts/output.hex
