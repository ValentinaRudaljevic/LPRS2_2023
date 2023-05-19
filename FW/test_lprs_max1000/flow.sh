#!/bin/bash

exit 0

# PC
./waf configure --compiler=pc
./waf build
./waf run --app=test_leds


# RISC-V
./waf configure --compiler=riscv
./waf build
