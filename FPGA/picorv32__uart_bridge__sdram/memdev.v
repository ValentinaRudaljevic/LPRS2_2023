////////////////////////////////////////////////////////////////////////////////
//
// Filename:	memdev.v
// {{{
// Project:	ArrowZip, a demonstration of the Arrow MAX1000 FPGA board
//
// Purpose:	This file is really simple: it creates an on-chip memory,
//		accessible via the wishbone bus, that can be used in this
//	project.  The memory has single cycle pipeline access, although the
//	memory pipeline here still costs a cycle and there may be other cycles
//	lost between the ZipCPU (or whatever is the master of the bus) and this,
//	thus costing more cycles in access.  Either way, operations can be
//	pipelined for single cycle access on subsequent transactions.
//
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
// }}}
// Copyright (C) 2015-2021, Gisselquist Technology, LLC
// {{{
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of  the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
`default_nettype	none
// }}}
module	memdev #(
//		parameter	LGMEMSZ=15, DW=32, EXTRACLOCK= 1,
		parameter	LGMEMSZ=15, DW=32, EXTRACLOCK= 0,
		parameter [0:0]	OPT_ROM = 1'b0,
		parameter AW = LGMEMSZ - 2
	) (
		input				i_clk, i_reset,
		//wishbone port
		input				i_wb_cyc, i_wb_stb, i_wb_we,
		input		[(AW-1):0]	i_wb_addr,
		input		[(DW-1):0]	i_wb_data,
		input		[(DW/8-1):0]	i_wb_sel,
		output				o_wb_stall,
		output	reg			o_wb_ack,
		output	reg	[(DW-1):0]	o_wb_data,
		//DMA port
		input 			dma_we_i,
		input  [31:0]	dma_addr_i,
		input  [31:0]	dma_wdata_i,
		input  [ 3:0]	dma_mem_wstrb_i,
		output reg [31:0] dma_rada_o
	);

	// Local declarations
	wire			w_wstb, w_stb;
	wire	[(DW-1):0]	w_data;
	wire	[(AW-1):0]	w_addr;
	wire	[(DW/8-1):0]	w_sel;

	// Declare the memory itself
	reg	[((DW-1)/4):0]	mem3	[0:((1<<AW)-1)];
	reg	[((DW-1)/4):0]	mem2	[0:((1<<AW)-1)];
	reg	[((DW-1)/4):0]	mem1	[0:((1<<AW)-1)];
	reg	[((DW-1)/4):0]	mem0	[0:((1<<AW)-1)];
	

	// Optionally add an extra clock
	
	assign	w_wstb = (i_wb_stb)&&(i_wb_we);
	assign	w_stb  = i_wb_stb;
	assign	w_addr = i_wb_addr;
	assign	w_data = i_wb_data;
	assign	w_sel  = i_wb_sel;
	
/*	begin : EXTRA_MEM_CLOCK_CYCLE
		reg		last_wstb, last_stb;
		reg	[(AW-1):0]	last_addr;
		reg	[(DW-1):0]	last_data;
		reg	[(DW/8-1):0]	last_sel;

		always @(posedge i_clk)
			last_wstb <= (i_wb_stb)&&(i_wb_we);

		initial	last_stb = 1'b0;
		
		always @(posedge i_clk)
		if (i_reset)
			last_stb <= 1'b0;
		else
			last_stb <= (i_wb_stb);

	always @(posedge i_clk)
		last_data <= i_wb_data;
	always @(posedge i_clk)
		last_addr <= i_wb_addr;
	always @(posedge i_clk)
		last_sel <= i_wb_sel;

	assign	w_wstb = last_wstb;
	assign	w_stb  = last_stb;
	assign	w_addr = last_addr;
	assign	w_data = last_data;
	assign	w_sel  = last_sel;
	*/
	
	wire [AW-2:0] addr_b;
	assign addr_b = dma_addr_i[AW:2];
	wire we_b;
	assign we_b = dma_we_i && dma_addr_i[31:AW+1] == 0;

	// Read from memory
	always @(posedge i_clk)
	begin
		o_wb_data[31:24] <= mem3[w_addr];
		o_wb_data[23:16] <= mem2[w_addr];
		o_wb_data[15: 8] <= mem1[w_addr];
		o_wb_data[ 7: 0] <= mem0[w_addr];
	end
		
	always @(posedge i_clk)
	begin
		dma_rada_o[31:24] <= mem3[addr_b];
		dma_rada_o[23:16] <= mem2[addr_b];
		dma_rada_o[15: 8] <= mem1[addr_b];
		dma_rada_o[ 7: 0] <= mem0[addr_b];
	end

	// Write to memory (if not a ROM)

	//begin : WRITE_TO_MEMORY
	always @(posedge i_clk)
	begin
		if (we_b) begin
			if (dma_mem_wstrb_i[3]) mem3[addr_b] <= dma_wdata_i[31:24];
			if (dma_mem_wstrb_i[2]) mem2[addr_b] <= dma_wdata_i[23:16];
			if (dma_mem_wstrb_i[1]) mem1[addr_b] <= dma_wdata_i[15: 8];
			if (dma_mem_wstrb_i[0]) mem0[addr_b] <= dma_wdata_i[ 7: 0];
		else
			if ((w_wstb)&&(w_sel[3]))
				mem3[w_addr] <= w_data[31:24];
			if ((w_wstb)&&(w_sel[2]))
				mem2[w_addr] <= w_data[23:16];
			if ((w_wstb)&&(w_sel[1]))
				mem1[w_addr] <= w_data[15:8];
			if ((w_wstb)&&(w_sel[0]))
				mem0[w_addr] <= w_data[7:0];
		end
	end


	// o_wb_ack
	initial	o_wb_ack = 1'b0;
	
	always @(posedge i_clk)
	if (i_reset)
		o_wb_ack <= 1'b0;
	else
		o_wb_ack <= (w_stb)&&(i_wb_cyc);

	assign	o_wb_stall = 1'b0;

endmodule
