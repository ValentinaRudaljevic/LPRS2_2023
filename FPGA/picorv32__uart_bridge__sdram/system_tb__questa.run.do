if [file exists "work"] {vdel -all}
vlib work

vlog memory.v
vlog picorv32.v
vlog sdr.v
vlog sdr_module.v
vlog system.v
vlog wbsdram.v
vlog pll_sym.v


vcom MM_Reg.vhd
vcom uart_rx.vhd
vcom uart_tx.vhd
vcom uart_bridge.vhd
vcom WB_slave_arbiter.vhd
vcom DMA_FSM.vhd
vcom RST_Reg.vhd


vlog uart_bridge_agent.v
vlog system_tb.v

#vsim -novopt system_tb 
vsim -c system_tb -pli build/libuart_portal.so



restart -force
delete wave *

set wf system_tb.wave.do

if {[file exists wave.do]} {
	file delete $wf
	file copy wave.do $wf
	file delete wave.do
}

do $wf

echo "Loading finished..."

#run 10 us
#run 450 us
#run -all
