#!/bin/bash

exit 0

./waf configure
./waf build
./waf run
#TODO instead of ./waf run
./build/max1000_riscv_loader ../../FW/test_lprs_max1000/build/test_leds.hex
