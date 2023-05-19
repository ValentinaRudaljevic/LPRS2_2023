`timescale 1 ns / 1 ps

/*sdram_pll pll1(
		.areset		(i_rst),
		.inclk0		(i_clk),
		.c0			(s_sys_clk),
		.c1			(s_sdram_clk),
		.locked		(n_rst)
	);*/

module pll_sym (

	input 		i_clk,
	input 		in_rst,
	output 		c0,
	output reg 	c1,
	output 		on_rst
	);
	
	assign on_rst = in_rst;
	assign c0 = i_clk;

	parameter 	FREQ = 50000000;	// in Hz
	parameter 	PHASE = 270;
	parameter 	DUTY = 50;

	real		clk_pd = (1.0 / FREQ) * 1e9; // in ns
	real 		clk_on = (DUTY / 100.0) * ((1.0 / FREQ) * 1e9);	//(DUTY / 100.0) * clk_pd
	real		clk_off = ((100.0 - DUTY) / 100.0) * ((1.0 / FREQ) * 1e9); //((100.0 - DUTY) / 100.0) * clk_pd
	real 		quarter = ((1.0 / FREQ) * 1e9) / 4;	// clk_pd / 4
	real 		start_dly = (((1.0 / FREQ) * 1e9) / 4) * (PHASE / 90); // quarter * (PHASE / 90)


	reg start_clk;

	initial begin
		c1 <= 0;
		start_clk <= 0;
	end


	always @(posedge i_clk) begin
		#(start_dly) start_clk = 1;
	end

	always @(posedge start_clk) begin
		if (start_clk) begin
			c1 = 1;

			while(start_clk) begin
				#(clk_on) c1 = 0;
				#(clk_off) c1 = 1;
			end

			c1 = 0;
		end
	end
endmodule

	
	
		


