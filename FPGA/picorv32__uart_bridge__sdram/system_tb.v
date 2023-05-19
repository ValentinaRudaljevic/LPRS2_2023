
`timescale 1ns / 1ns

module system_tb;

	// General
	reg        	i_clk;                          // Clock
	reg			i_rstn;
	reg			i_rst_proc;
	wire [7:0]	o_led;

	// UART
	wire			serial_rx;
	wire			serial_tx;
	wire			n_serial_cts;
	wire			n_serial_dsr;
	
	// SDRAM
	wire			so_ram_clk;
	wire			so_ram_cs_n;
	wire			so_ram_cke;
	wire			so_ram_ras_n;
	wire			so_ram_cas_n;
	wire			so_ram_we_n;
	wire  [1:0]	so_ram_bs;		
	wire [11:0]	so_ram_addr;		
	wire [15:0]	sio_ram_data;			
	wire  [1:0] so_ram_dqm;

	//TODO REMOVE debug signals
	wire			locked;
	wire  [1:0] sstate;
	
	

initial begin
	i_clk = 1'b0;
end

// for 80 MHz, period should be 12.5ns
//localparam period = 6.25;
// for 50 MHz, period should be 20 ns
localparam period = 10;
//localparam period = 6;
//localparam reset_period = 1250;
localparam reset_period = 42000 * 10;
localparam sym_period = 125000;

// clock process
always 
begin
	i_clk = 1'b1; 
	#period; // high for 20 * timescale = 20 ns

	i_clk = 1'b0;
	#period; // low for 20 * timescale = 20 ns
end

system sys 	(i_clk, 
			i_rstn, 
			o_led, 
			serial_rx, 
			serial_tx, 
			n_serial_cts,
			n_serial_dsr,
			so_ram_clk,
			so_ram_cs_n,
			so_ram_cke,
			so_ram_ras_n,
			so_ram_cas_n,
			so_ram_we_n,
			so_ram_bs,
			so_ram_addr,
			sio_ram_data,
			so_ram_dqm,
			slocked,
			sstate);

//TODO sdr
sdr sdram  	(sio_ram_data, 
			so_ram_addr, 
			so_ram_bs, 
			so_ram_clk, 
			so_ram_cke, 
			so_ram_cs_n, 
			so_ram_ras_n, 
			so_ram_cas_n, 
			so_ram_we_n, 
			so_ram_dqm);
				
uart_bridge_agent agent	(i_clk,
						i_rstn,
						serial_rx,
						serial_tx,
						n_serial_cts,
						n_serial_dsr);

initial 
	begin
		i_rstn = 0;
		i_rst_proc = 1;
		#(reset_period);
		i_rstn = 1;
		i_rst_proc = 0;
//		#(sym_period);
	end
	
endmodule
