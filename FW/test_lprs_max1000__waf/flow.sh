#!/bin/bash

exit 0

# PC
./waf configure --compiler=pc
./waf build
./waf run --app=test_leds


# RISC-V
./waf configure --compiler=riscv --cross-compile=/home/student/.arduino15/packages/max1000/tools/riscv32-unknown-elf-gcc/8.2.0-im/bin/riscv32-unknown-elf-
./waf build
