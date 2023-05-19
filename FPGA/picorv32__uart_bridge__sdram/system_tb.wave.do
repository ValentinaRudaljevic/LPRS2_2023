onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TB
add wave -noupdate /system_tb/i_clk
add wave -noupdate /system_tb/sys/s_sys_clk
add wave -noupdate /system_tb/i_rstn
add wave -noupdate /system_tb/serial_rx
add wave -noupdate /system_tb/serial_tx
add wave -noupdate /system_tb/sys/s_data_byte_write
add wave -noupdate /system_tb/o_led
add wave -noupdate -divider System
add wave -noupdate -label n_rst /system_tb/sys/n_rst
add wave -noupdate -label pll_clk -radix unsigned /system_tb/sys/pll_clk
add wave -noupdate -label uart/i_clk /system_tb/sys/uart/i_clk
add wave -noupdate -label i_rst /system_tb/sys/i_rst
add wave -noupdate -label uart/i_serial_rx /system_tb/sys/uart/i_serial_rx
add wave -noupdate -label uart/uart_rx_i/i_RX_Serial /system_tb/sys/uart/uart_rx_i/i_RX_Serial
add wave -noupdate -label uart/uart_rx_i/r_RX_Data_R /system_tb/sys/uart/uart_rx_i/r_RX_Data_R
add wave -noupdate -label uart/uart_rx_i/r_RX_Data /system_tb/sys/uart/uart_rx_i/r_RX_Data
add wave -noupdate -label uart/uart_rx_i/r_SM_Main /system_tb/sys/uart/uart_rx_i/r_SM_Main
add wave -noupdate -label uart/uart_rx_i/r_RX_Byte /system_tb/sys/uart/uart_rx_i/r_RX_Byte
add wave -noupdate -label uart/uart_rx_i/o_RX_Byte /system_tb/sys/uart/uart_rx_i/o_RX_Byte
add wave -noupdate -label uart/o_serial_tx /system_tb/sys/uart/o_serial_tx
add wave -noupdate -label uart/i_byte_tx_data /system_tb/sys/uart/i_byte_tx_data
add wave -noupdate -label uart/i_byte_tx_valid /system_tb/sys/uart/i_byte_tx_valid
add wave -noupdate -label uart/o_byte_tx_busy /system_tb/sys/uart/o_byte_tx_busy
add wave -noupdate -label uart/o_byte_rx_data /system_tb/sys/uart/o_byte_rx_data
add wave -noupdate -label uart/o_byte_rx_valid /system_tb/sys/uart/o_byte_rx_valid
add wave -noupdate -label uart/dv /system_tb/sys/uart/dv
add wave -noupdate -label uart/b /system_tb/sys/uart/b
add wave -noupdate -label sys/o_dma_byte_read /system_tb/sys/o_dma_byte_read
add wave -noupdate -label sys/o_dma_data_valid /system_tb/sys/o_dma_data_valid
add wave -noupdate -label s_tx_active /system_tb/sys/s_tx_active
add wave -noupdate -label s_data_byte_write /system_tb/sys/s_data_byte_write
add wave -noupdate -label data_valid_w /system_tb/sys/data_valid_w
add wave -noupdate -label dma/s_state /system_tb/sys/dma/s_state
add wave -noupdate -label dma/o_Byte /system_tb/sys/dma/o_Byte
add wave -noupdate -label dma/o_Data /system_tb/sys/dma/o_Data
add wave -noupdate -label dma/o_Data_Valid /system_tb/sys/dma/o_Data_Valid
add wave -noupdate -label dma/o_Address /system_tb/sys/dma/o_Address
add wave -noupdate -divider {PCPI MUL}
add wave -noupdate -label pcpi_mul/clk /system_tb/sys/pcpi_mul/clk
add wave -noupdate -label pcpi_mul/resetn /system_tb/sys/pcpi_mul/resetn
add wave -noupdate -label pcpi_mul/pcpi_valid /system_tb/sys/pcpi_mul/pcpi_valid
add wave -noupdate -label pcpi_mul/pcpi_insn /system_tb/sys/pcpi_mul/pcpi_insn
add wave -noupdate -label pcpi_mul/pcpi_rs1 /system_tb/sys/pcpi_mul/pcpi_rs1
add wave -noupdate -label pcpi_mul/pcpi_rs2 /system_tb/sys/pcpi_mul/pcpi_rs2
add wave -noupdate -label pcpi_mul/pcpi_wr /system_tb/sys/pcpi_mul/pcpi_wr
add wave -noupdate -label pcpi_mul/pcpi_rd /system_tb/sys/pcpi_mul/pcpi_rd
add wave -noupdate -label pcpi_mul/pcpi_wait /system_tb/sys/pcpi_mul/pcpi_wait
add wave -noupdate -label pcpi_mul/pcpi_ready /system_tb/sys/pcpi_mul/pcpi_ready
add wave -noupdate -label pcpi_mul/instr_mul /system_tb/sys/pcpi_mul/instr_mul
add wave -noupdate -label pcpi_mul/instr_mulh /system_tb/sys/pcpi_mul/instr_mulh
add wave -noupdate -label pcpi_mul/instr_mulhsu /system_tb/sys/pcpi_mul/instr_mulhsu
add wave -noupdate -label pcpi_mul/instr_mulhu /system_tb/sys/pcpi_mul/instr_mulhu
add wave -noupdate -label pcpi_mul/instr_any_mul /system_tb/sys/pcpi_mul/instr_any_mul
add wave -noupdate -label pcpi_mul/instr_any_mulh /system_tb/sys/pcpi_mul/instr_any_mulh
add wave -noupdate -label pcpi_mul/instr_rs1_signed /system_tb/sys/pcpi_mul/instr_rs1_signed
add wave -noupdate -label pcpi_mul/instr_rs2_signed /system_tb/sys/pcpi_mul/instr_rs2_signed
add wave -noupdate -label pcpi_mul/pcpi_wait_q /system_tb/sys/pcpi_mul/pcpi_wait_q
add wave -noupdate -label pcpi_mul/mul_start /system_tb/sys/pcpi_mul/mul_start
add wave -noupdate -label pcpi_mul/rs1 /system_tb/sys/pcpi_mul/rs1
add wave -noupdate -label pcpi_mul/rs2 /system_tb/sys/pcpi_mul/rs2
add wave -noupdate -label pcpi_mul/rd /system_tb/sys/pcpi_mul/rd
add wave -noupdate -label pcpi_mul/rdx /system_tb/sys/pcpi_mul/rdx
add wave -noupdate -label pcpi_mul/next_rs1 /system_tb/sys/pcpi_mul/next_rs1
add wave -noupdate -label pcpi_mul/next_rs2 /system_tb/sys/pcpi_mul/next_rs2
add wave -noupdate -label pcpi_mul/this_rs2 /system_tb/sys/pcpi_mul/this_rs2
add wave -noupdate -label pcpi_mul/next_rd /system_tb/sys/pcpi_mul/next_rd
add wave -noupdate -label pcpi_mul/next_rdx /system_tb/sys/pcpi_mul/next_rdx
add wave -noupdate -label pcpi_mul/next_rdt /system_tb/sys/pcpi_mul/next_rdt
add wave -noupdate -label pcpi_mul/mul_counter /system_tb/sys/pcpi_mul/mul_counter
add wave -noupdate -label pcpi_mul/mul_waiting /system_tb/sys/pcpi_mul/mul_waiting
add wave -noupdate -label pcpi_mul/mul_finish /system_tb/sys/pcpi_mul/mul_finish
add wave -noupdate -label pcpi_mul/i /system_tb/sys/pcpi_mul/i
add wave -noupdate -label pcpi_mul/j /system_tb/sys/pcpi_mul/j
add wave -noupdate -divider RISCV
add wave -noupdate -label core/pcpi_valid /system_tb/sys/picorv32/picorv32_core/pcpi_valid
add wave -noupdate -label core/pcpi_insn /system_tb/sys/picorv32/picorv32_core/pcpi_insn
add wave -noupdate -label core/pcpi_rs1 /system_tb/sys/picorv32/picorv32_core/pcpi_rs1
add wave -noupdate -label core/pcpi_rs2 /system_tb/sys/picorv32/picorv32_core/pcpi_rs2
add wave -noupdate -label core/pcpi_wr /system_tb/sys/picorv32/picorv32_core/pcpi_wr
add wave -noupdate -label core/pcpi_rd /system_tb/sys/picorv32/picorv32_core/pcpi_rd
add wave -noupdate -label core/pcpi_wait /system_tb/sys/picorv32/picorv32_core/pcpi_wait
add wave -noupdate -label core/pcpi_ready /system_tb/sys/picorv32/picorv32_core/pcpi_ready
add wave -noupdate -label picorv32/wb_rst_i /system_tb/sys/picorv32/wb_rst_i
add wave -noupdate -label picorv32/wb_clk_i /system_tb/sys/picorv32/wb_clk_i
add wave -noupdate -color Magenta -label riscv_pc /system_tb/sys/picorv32/picorv32_core/reg_pc
add wave -noupdate -label picorv32/wbm_adr_o /system_tb/sys/picorv32/wbm_adr_o
add wave -noupdate -label picorv32/wbm_dat_i /system_tb/sys/picorv32/wbm_dat_i
add wave -noupdate -label picorv32/wbm_dat_o /system_tb/sys/picorv32/wbm_dat_o
add wave -noupdate -label picorv32/wbm_we_o /system_tb/sys/picorv32/wbm_we_o
add wave -noupdate -label wbm_sel_o /system_tb/sys/picorv32/wbm_sel_o
add wave -noupdate -label picorv32/wbm_stb_o /system_tb/sys/picorv32/wbm_stb_o
add wave -noupdate -label picorv32/wbm_ack_i /system_tb/sys/picorv32/wbm_ack_i
add wave -noupdate -label picorv32/wbm_cyc_o /system_tb/sys/picorv32/wbm_cyc_o
add wave -noupdate -label decoder_trigger /system_tb/sys/picorv32/picorv32_core/decoder_trigger
add wave -noupdate -label decoder_trigger_q /system_tb/sys/picorv32/picorv32_core/decoder_trigger_q
add wave -noupdate -label cached_insn_opcode /system_tb/sys/picorv32/picorv32_core/cached_insn_opcode
add wave -noupdate -label q_insn_opcode /system_tb/sys/picorv32/picorv32_core/q_insn_opcode
add wave -noupdate -label next_inst_opcode /system_tb/sys/picorv32/picorv32_core/next_insn_opcode
add wave -noupdate -label dbg_insn_opcode /system_tb/sys/picorv32/picorv32_core/dbg_insn_opcode
add wave -noupdate -label dbg_insn_addr /system_tb/sys/picorv32/picorv32_core/dbg_insn_addr
add wave -noupdate -label dbg_mem_valid /system_tb/sys/picorv32/picorv32_core/dbg_mem_valid
add wave -noupdate -label dbg_mem_instr /system_tb/sys/picorv32/picorv32_core/dbg_mem_instr
add wave -noupdate -label dbg_mem_ready /system_tb/sys/picorv32/picorv32_core/dbg_mem_ready
add wave -noupdate -label dbg_mem_addr /system_tb/sys/picorv32/picorv32_core/dbg_mem_addr
add wave -noupdate -label dbg_mem_wdata /system_tb/sys/picorv32/picorv32_core/dbg_mem_wdata
add wave -noupdate -label picorv32/reg_op2 /system_tb/sys/picorv32/picorv32_core/reg_op2
add wave -noupdate -label mem_la_wdata /system_tb/sys/picorv32/picorv32_core/mem_la_wdata
add wave -noupdate -label dbg_mem_wstrb /system_tb/sys/picorv32/picorv32_core/dbg_mem_wstrb
add wave -noupdate -label dbg_mem_rdata /system_tb/sys/picorv32/picorv32_core/dbg_mem_rdata
add wave -noupdate -label next_pc /system_tb/sys/picorv32/picorv32_core/reg_next_pc
add wave -noupdate -label decoded_rs1 /system_tb/sys/picorv32/picorv32_core/decoded_rs1
add wave -noupdate -label decoded_rs2 /system_tb/sys/picorv32/picorv32_core/decoded_rs2
add wave -noupdate -label cpuregs -expand -subitemconfig {{/system_tb/sys/picorv32/picorv32_core/cpuregs[1]} {-color Gold -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[2]} {-color Cyan -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[8]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[9]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[18]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[19]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[20]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[21]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[22]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[23]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[24]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[25]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[26]} {-color Pink -height 16} {/system_tb/sys/picorv32/picorv32_core/cpuregs[27]} {-color Pink -height 16}} /system_tb/sys/picorv32/picorv32_core/cpuregs
add wave -noupdate -label cpuregs_rs1 /system_tb/sys/picorv32/picorv32_core/cpuregs_rs1
add wave -noupdate -label cpuregs_rs2 /system_tb/sys/picorv32/picorv32_core/cpuregs_rs2
add wave -noupdate -divider {SDRAM - CTRL}
add wave -noupdate -label state -radix unsigned -childformat {{{/system_tb/sys/sdram_ctrl/state[3]} -radix decimal} {{/system_tb/sys/sdram_ctrl/state[2]} -radix decimal} {{/system_tb/sys/sdram_ctrl/state[1]} -radix decimal} {{/system_tb/sys/sdram_ctrl/state[0]} -radix decimal}} -subitemconfig {{/system_tb/sys/sdram_ctrl/state[3]} {-height 16 -radix decimal} {/system_tb/sys/sdram_ctrl/state[2]} {-height 16 -radix decimal} {/system_tb/sys/sdram_ctrl/state[1]} {-height 16 -radix decimal} {/system_tb/sys/sdram_ctrl/state[0]} {-height 16 -radix decimal}} /system_tb/sys/sdram_ctrl/state
add wave -noupdate -label i_clk /system_tb/sys/sdram_ctrl/i_clk
add wave -noupdate -color Cyan -label i_wb_cyc /system_tb/sys/sdram_ctrl/i_wb_cyc
add wave -noupdate -label i_wb_stb /system_tb/sys/sdram_ctrl/i_wb_stb
add wave -noupdate -label i_wb_we /system_tb/sys/sdram_ctrl/i_wb_we
add wave -noupdate -label i_wb_addr /system_tb/sys/sdram_ctrl/i_wb_addr
add wave -noupdate -label i_wb_data /system_tb/sys/sdram_ctrl/i_wb_data
add wave -noupdate -label i_wb_sel /system_tb/sys/sdram_ctrl/i_wb_sel
add wave -noupdate -label o_wb_stall /system_tb/sys/sdram_ctrl/o_wb_stall
add wave -noupdate -label o_wb_ack /system_tb/sys/sdram_ctrl/o_wb_ack
add wave -noupdate -label o_wb_data /system_tb/sys/sdram_ctrl/o_wb_data
add wave -noupdate -label o_ram_cs_n /system_tb/sys/sdram_ctrl/o_ram_cs_n
add wave -noupdate -label o_ram_cke /system_tb/sys/sdram_ctrl/o_ram_cke
add wave -noupdate -label o_ram_ras_n /system_tb/sys/sdram_ctrl/o_ram_ras_n
add wave -noupdate -label o_ram_cas_n /system_tb/sys/sdram_ctrl/o_ram_cas_n
add wave -noupdate -label o_ram_we_n /system_tb/sys/sdram_ctrl/o_ram_we_n
add wave -noupdate -label o_ram_bs /system_tb/sys/sdram_ctrl/o_ram_bs
add wave -noupdate -label o_ram_addr /system_tb/sys/sdram_ctrl/o_ram_addr
add wave -noupdate -label o_ram_dmod /system_tb/sys/sdram_ctrl/o_ram_dmod
add wave -noupdate -label i_ram_data /system_tb/sys/sdram_ctrl/i_ram_data
add wave -noupdate -label o_ram_data /system_tb/sys/sdram_ctrl/o_ram_data
add wave -noupdate -label o_ram_dqm /system_tb/sys/sdram_ctrl/o_ram_dqm
add wave -noupdate -label o_debug /system_tb/sys/sdram_ctrl/o_debug
add wave -noupdate -color Cyan -label need_refresh /system_tb/sys/sdram_ctrl/need_refresh
add wave -noupdate -label refresh_clk -radix unsigned /system_tb/sys/sdram_ctrl/refresh_clk
add wave -noupdate -label refresh_cmd /system_tb/sys/sdram_ctrl/refresh_cmd
add wave -noupdate -label in_refresh /system_tb/sys/sdram_ctrl/in_refresh
add wave -noupdate -label in_refresh_clk /system_tb/sys/sdram_ctrl/in_refresh_clk
add wave -noupdate -label bank_active -expand /system_tb/sys/sdram_ctrl/bank_active
add wave -noupdate -color Gold -label r_barrell_ack -subitemconfig {{/system_tb/sys/sdram_ctrl/r_barrell_ack[5]} {-color Gold} {/system_tb/sys/sdram_ctrl/r_barrell_ack[4]} {-color Gold} {/system_tb/sys/sdram_ctrl/r_barrell_ack[3]} {-color Gold} {/system_tb/sys/sdram_ctrl/r_barrell_ack[2]} {-color Gold} {/system_tb/sys/sdram_ctrl/r_barrell_ack[1]} {-color Gold} {/system_tb/sys/sdram_ctrl/r_barrell_ack[0]} {-color Gold}} /system_tb/sys/sdram_ctrl/r_barrell_ack
add wave -noupdate -label r_pending /system_tb/sys/sdram_ctrl/r_pending
add wave -noupdate -color Magenta -label r_we /system_tb/sys/sdram_ctrl/r_we
add wave -noupdate -label r_addr /system_tb/sys/sdram_ctrl/r_addr
add wave -noupdate -label r_data /system_tb/sys/sdram_ctrl/r_data
add wave -noupdate -label r_sel /system_tb/sys/sdram_ctrl/r_sel
add wave -noupdate -label bank_row /system_tb/sys/sdram_ctrl/bank_row
add wave -noupdate -color Magenta -label clocks_til_idle /system_tb/sys/sdram_ctrl/clocks_til_idle
add wave -noupdate -label m_state /system_tb/sys/sdram_ctrl/m_state
add wave -noupdate -label bus_cyc /system_tb/sys/sdram_ctrl/bus_cyc
add wave -noupdate -label nxt_dmod /system_tb/sys/sdram_ctrl/nxt_dmod
add wave -noupdate -color Magenta -label pending /system_tb/sys/sdram_ctrl/pending
add wave -noupdate -label fwd_addr /system_tb/sys/sdram_ctrl/fwd_addr
add wave -noupdate -label wb_bs /system_tb/sys/sdram_ctrl/wb_bs
add wave -noupdate -label r_bs /system_tb/sys/sdram_ctrl/r_bs
add wave -noupdate -label fwd_bs /system_tb/sys/sdram_ctrl/fwd_bs
add wave -noupdate -label wb_row /system_tb/sys/sdram_ctrl/wb_row
add wave -noupdate -label r_row /system_tb/sys/sdram_ctrl/r_row
add wave -noupdate -label fwd_row /system_tb/sys/sdram_ctrl/fwd_row
add wave -noupdate -color Magenta -label r_bank_valid /system_tb/sys/sdram_ctrl/r_bank_valid
add wave -noupdate -label fwd_bank_valid /system_tb/sys/sdram_ctrl/fwd_bank_valid
add wave -noupdate -label maintenance_mode /system_tb/sys/sdram_ctrl/maintenance_mode
add wave -noupdate -label m_ram_cs_n /system_tb/sys/sdram_ctrl/m_ram_cs_n
add wave -noupdate -label startup_hold /system_tb/sys/sdram_ctrl/startup_hold
add wave -noupdate -label startup_idle /system_tb/sys/sdram_ctrl/startup_idle
add wave -noupdate -label maintenance_clocks /system_tb/sys/sdram_ctrl/maintenance_clocks
add wave -noupdate -label maintenance_clocks_zero /system_tb/sys/sdram_ctrl/maintenance_clocks_zero
add wave -noupdate -label last_ram_data -expand /system_tb/sys/sdram_ctrl/last_ram_data
add wave -noupdate -label word_sel /system_tb/sys/sdram_ctrl/word_sel
add wave -noupdate -label trigger /system_tb/sys/sdram_ctrl/trigger
add wave -noupdate -divider SDRAM
add wave -noupdate /system_tb/sdram/Clk
add wave -noupdate /system_tb/sdram/Cke
add wave -noupdate /system_tb/sdram/Cs_n
add wave -noupdate /system_tb/sdram/Ras_n
add wave -noupdate /system_tb/sdram/Cas_n
add wave -noupdate /system_tb/sdram/We_n
add wave -noupdate /system_tb/sdram/Addr
add wave -noupdate /system_tb/sdram/Ba
add wave -noupdate /system_tb/sdram/Dq
add wave -noupdate /system_tb/sdram/Dqm
add wave -noupdate /system_tb/sdram/Aref_enable
add wave -noupdate -radix unsigned /system_tb/sdram/RFC_chk
add wave -noupdate /system_tb/sdram/tRFC
add wave -noupdate /system_tb/sdram/Row
add wave -noupdate /system_tb/sdram/Col
add wave -noupdate -divider BRAM
add wave -noupdate -label bram/mem_rdata /system_tb/sys/bram/mem_rdata
add wave -noupdate -label bram/mem_la_write /system_tb/sys/bram/mem_la_write
add wave -noupdate -label bram/mem_la_addr -radix hexadecimal /system_tb/sys/bram/mem_la_addr
add wave -noupdate -label bram/mem_la_wdata /system_tb/sys/bram/mem_la_wdata
add wave -noupdate -label bram/mem_la_wstrb /system_tb/sys/bram/mem_la_wstrb
add wave -noupdate -label bram/i_wb_cyc /system_tb/sys/bram/i_wb_cyc
add wave -noupdate -label bram/i_wb_stb /system_tb/sys/bram/i_wb_stb
add wave -noupdate -label bram/i_wb_we /system_tb/sys/bram/i_wb_we
add wave -noupdate -label bram/i_wb_addr /system_tb/sys/bram/i_wb_addr
add wave -noupdate -label bram/i_wb_data /system_tb/sys/bram/i_wb_data
add wave -noupdate -label bram/i_wb_sel /system_tb/sys/bram/i_wb_sel
add wave -noupdate -label bram/o_wb_stall /system_tb/sys/bram/o_wb_stall
add wave -noupdate -label bram/o_wb_ack /system_tb/sys/bram/o_wb_ack
add wave -noupdate -label bram/o_wb_data /system_tb/sys/bram/o_wb_data
add wave -noupdate -label bram/memory3 /system_tb/sys/bram/memory3
add wave -noupdate -label bram/memory2 /system_tb/sys/bram/memory2
add wave -noupdate -label bram/memory1 /system_tb/sys/bram/memory1
add wave -noupdate -label bram/memory0 /system_tb/sys/bram/memory0
add wave -noupdate -label bram/addr_a /system_tb/sys/bram/addr_a
add wave -noupdate -label bram/addr_b -radix unsigned /system_tb/sys/bram/addr_b
add wave -noupdate -label bram/we_b /system_tb/sys/bram/we_b
add wave -noupdate -divider DMA
add wave -noupdate -label dma/i_Data_Valid /system_tb/sys/dma/i_Data_Valid
add wave -noupdate -label dma/i_UART_Data /system_tb/sys/dma/i_UART_Data
add wave -noupdate -label dma/i_Mem_Data /system_tb/sys/dma/i_Mem_Data
add wave -noupdate -label dma/i_TX_Active /system_tb/sys/dma/i_TX_Active
add wave -noupdate -label dma/o_Data /system_tb/sys/dma/o_Data
add wave -noupdate -label dma/o_Byte /system_tb/sys/dma/o_Byte
add wave -noupdate -label dma/o_Data_Valid /system_tb/sys/dma/o_Data_Valid
add wave -noupdate -label dma/o_Address /system_tb/sys/dma/o_Address
add wave -noupdate -label dma/o_WE /system_tb/sys/dma/o_WE
add wave -noupdate -label dma/s_state /system_tb/sys/dma/s_state
add wave -noupdate -label dma/s_next_state /system_tb/sys/dma/s_next_state
add wave -noupdate -label dma/s_address /system_tb/sys/dma/s_address
add wave -noupdate -label dma/s_data /system_tb/sys/dma/s_data
add wave -noupdate -label dma/s_cmd /system_tb/sys/dma/s_cmd
add wave -noupdate -label dma/s_remaining_data /system_tb/sys/dma/s_remaining_data
add wave -noupdate -label dma/s_cnt_data_size /system_tb/sys/dma/s_cnt_data_size
add wave -noupdate -label dma/s_cnt_start_addr /system_tb/sys/dma/s_cnt_start_addr
add wave -noupdate -label dma/s_counter_r /system_tb/sys/dma/s_counter_r
add wave -noupdate -label dma/s_counter_w /system_tb/sys/dma/s_counter_w
add wave -noupdate -label dma/s_decrease_size /system_tb/sys/dma/s_decrease_size
add wave -noupdate -label dma/s_decrease_size_prev /system_tb/sys/dma/s_decrease_size_prev
add wave -noupdate -label dma/s_increase_address /system_tb/sys/dma/s_increase_address
add wave -noupdate -label dma/s_increase_address_prev /system_tb/sys/dma/s_increase_address_prev
add wave -noupdate -label dma/s_tx_active /system_tb/sys/dma/s_tx_active
add wave -noupdate -label dma/s_tx_active_prev /system_tb/sys/dma/s_tx_active_prev
add wave -noupdate -label dma/s_read_en /system_tb/sys/dma/s_read_en
add wave -noupdate -label dma/s_dec_size_en /system_tb/sys/dma/s_dec_size_en
add wave -noupdate -label dma/s_inc_addr_en /system_tb/sys/dma/s_inc_addr_en
add wave -noupdate -divider Agent
add wave -noupdate /system_tb/agent/first_send
add wave -noupdate /system_tb/agent/hack_cnt
add wave -noupdate /system_tb/agent/i_serial_tx
add wave -noupdate /system_tb/agent/o_serial_rx
add wave -noupdate /system_tb/agent/s_rx_byte
add wave -noupdate /system_tb/agent/s_rx_busy
add wave -noupdate /system_tb/agent/s_rx_dv
add wave -noupdate /system_tb/agent/s_tx_byte
add wave -noupdate /system_tb/agent/s_tx_dv
add wave -noupdate -divider Agent_uart_bridge
add wave -noupdate /system_tb/agent/uart/i_serial_rx
add wave -noupdate /system_tb/agent/uart/o_serial_tx
add wave -noupdate /system_tb/agent/uart/i_byte_tx_data
add wave -noupdate /system_tb/agent/uart/i_byte_tx_valid
add wave -noupdate /system_tb/agent/uart/o_byte_tx_busy
add wave -noupdate /system_tb/agent/uart/o_byte_rx_data
add wave -noupdate /system_tb/agent/uart/o_byte_rx_valid
add wave -noupdate /system_tb/agent/uart/dv
add wave -noupdate -divider uart_tx
add wave -noupdate /system_tb/agent/uart/uart_tx_i/i_TX_DV
add wave -noupdate /system_tb/agent/uart/uart_tx_i/i_TX_Byte
add wave -noupdate /system_tb/agent/uart/uart_tx_i/o_TX_Active
add wave -noupdate /system_tb/agent/uart/uart_tx_i/o_TX_Serial
add wave -noupdate /system_tb/agent/uart/uart_tx_i/o_TX_Done
add wave -noupdate /system_tb/agent/uart/uart_tx_i/r_TX_Data
add wave -noupdate -divider MMREG
add wave -noupdate /system_tb/sys/mmreg/i_Rstn
add wave -noupdate /system_tb/sys/mmreg/i_wb_cyc
add wave -noupdate /system_tb/sys/mmreg/i_wb_stb
add wave -noupdate /system_tb/sys/mmreg/i_wb_we
add wave -noupdate /system_tb/sys/mmreg/i_wb_addr
add wave -noupdate /system_tb/sys/mmreg/i_wb_data
add wave -noupdate /system_tb/sys/mmreg/i_wb_sel
add wave -noupdate /system_tb/sys/mmreg/o_wb_stall
add wave -noupdate /system_tb/sys/mmreg/o_wb_ack
add wave -noupdate /system_tb/sys/mmreg/o_wb_data
add wave -noupdate /system_tb/sys/mmreg/s_data
add wave -noupdate /system_tb/sys/mmreg/s_wb_ack
add wave -noupdate -divider {RST REG}
add wave -noupdate /system_tb/sys/rstreg/i_Rstn
add wave -noupdate /system_tb/sys/rstreg/i_WE
add wave -noupdate /system_tb/sys/rstreg/i_Address
add wave -noupdate /system_tb/sys/rstreg/i_Data
add wave -noupdate /system_tb/sys/rstreg/o_Data
add wave -noupdate /system_tb/sys/rstreg/s_data
add wave -noupdate -divider Arbiter
add wave -noupdate -label arbiter/i_wb_cyc /system_tb/sys/arbiter/i_wb_cyc
add wave -noupdate -label arbiter/i_wb_stb /system_tb/sys/arbiter/i_wb_stb
add wave -noupdate -label arbiter/i_wb_we /system_tb/sys/arbiter/i_wb_we
add wave -noupdate -label arbiter/i_wb_addr /system_tb/sys/arbiter/i_wb_addr
add wave -noupdate -label arbiter/i_wb_data /system_tb/sys/arbiter/i_wb_data
add wave -noupdate -label arbiter/i_wb_sel /system_tb/sys/arbiter/i_wb_sel
add wave -noupdate -label arbiter/o_wb_stall /system_tb/sys/arbiter/o_wb_stall
add wave -noupdate -label arbiter/o_wb_ack /system_tb/sys/arbiter/o_wb_ack
add wave -noupdate -label arbiter/o_wb_data /system_tb/sys/arbiter/o_wb_data
add wave -noupdate -label arbiter/o_wb_bram_cyc /system_tb/sys/arbiter/o_wb_bram_cyc
add wave -noupdate -label arbiter/o_wb_bram_stb /system_tb/sys/arbiter/o_wb_bram_stb
add wave -noupdate -label arbiter/o_wb_bram_we /system_tb/sys/arbiter/o_wb_bram_we
add wave -noupdate -label arbiter/o_wb_bram_addr /system_tb/sys/arbiter/o_wb_bram_addr
add wave -noupdate -label arbiter/o_wb_bram_data /system_tb/sys/arbiter/o_wb_bram_data
add wave -noupdate -label arbiter/o_wb_bram_sel /system_tb/sys/arbiter/o_wb_bram_sel
add wave -noupdate -label arbiter/i_wb_bram_stall /system_tb/sys/arbiter/i_wb_bram_stall
add wave -noupdate -label arbiter/i_wb_bram_ack /system_tb/sys/arbiter/i_wb_bram_ack
add wave -noupdate -label arbiter/i_wb_bram_data /system_tb/sys/arbiter/i_wb_bram_data
add wave -noupdate -label arbiter/o_wb_sdram_cyc /system_tb/sys/arbiter/o_wb_sdram_cyc
add wave -noupdate -label arbiter/o_wb_sdram_stb /system_tb/sys/arbiter/o_wb_sdram_stb
add wave -noupdate -label arbiter/o_wb_sdram_we /system_tb/sys/arbiter/o_wb_sdram_we
add wave -noupdate -label arbiter/o_wb_sdram_addr /system_tb/sys/arbiter/o_wb_sdram_addr
add wave -noupdate -label o_wb_sdram_data /system_tb/sys/arbiter/o_wb_sdram_data
add wave -noupdate -label arbiter/o_wb_sdram_sel /system_tb/sys/arbiter/o_wb_sdram_sel
add wave -noupdate -label arbiter/i_wb_sdram_stall /system_tb/sys/arbiter/i_wb_sdram_stall
add wave -noupdate -label arbiter/i_wb_sdram_ack /system_tb/sys/arbiter/i_wb_sdram_ack
add wave -noupdate -label arbiter/i_wb_sdram_data /system_tb/sys/arbiter/i_wb_sdram_data
add wave -noupdate -label arbiter/o_wb_mmreg_cyc /system_tb/sys/arbiter/o_wb_mmreg_cyc
add wave -noupdate -label arbiter/o_wb_mmreg_stb /system_tb/sys/arbiter/o_wb_mmreg_stb
add wave -noupdate -label arbiter/o_wb_mmreg_we /system_tb/sys/arbiter/o_wb_mmreg_we
add wave -noupdate -label arbiter/o_wb_mmreg_addr /system_tb/sys/arbiter/o_wb_mmreg_addr
add wave -noupdate -label arbiter/o_wb_mmreg_data /system_tb/sys/arbiter/o_wb_mmreg_data
add wave -noupdate -label arbiter/o_wb_mmreg_sel /system_tb/sys/arbiter/o_wb_mmreg_sel
add wave -noupdate -label arbiter/i_wb_mmreg_stall /system_tb/sys/arbiter/i_wb_mmreg_stall
add wave -noupdate -label arbiter/i_wb_mmreg_ack /system_tb/sys/arbiter/i_wb_mmreg_ack
add wave -noupdate -label arbiter/i_wb_mmreg_data /system_tb/sys/arbiter/i_wb_mmreg_data
add wave -noupdate -label arbiter/s_select_output /system_tb/sys/arbiter/s_select_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 11} {1185630380000 ps} 0} {{Cursor 2} {116540 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 111
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1185630027104 ps} {1185630652896 ps}
