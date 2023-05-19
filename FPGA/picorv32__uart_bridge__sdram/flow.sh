#!/bin/bash

exit 0

# T1
# Simulation.
/opt/Mentor/questa_sim/10.4d/questasim/linux_x86_64/vsim -do system_tb__questa.run.do &
# /dev/ttyUART1 will be opened in VPI and sim will stop at 0 ns.
# In other console run ./build/Echo_UART 0 and it will open /dev/ttyUART0.
# Run sim for all and two UARTs will comunicate.

# Kill if hang.
kill -9 $!


