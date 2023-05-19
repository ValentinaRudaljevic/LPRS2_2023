
`timescale 1ns / 1ns

module uart_bridge_agent (
	input      	i_clk,
	input		i_rstn,
	output		o_serial_rx,
	input		i_serial_tx,
	input 		in_serial_cts,
	input		in_serial_dsr
	);
	
	reg  [7:0] 	s_rx_byte;
	reg			s_rx_dv;
	wire		s_rx_busy;

	wire  [7:0]	s_tx_byte;
	wire		s_tx_dv;

	//counter hack
	wire		s_prev;
	reg			buf_rx_busy;
	reg			buf_rx_was_busy;
	reg   [1:0] hack_cnt;
	


	uart_bridge #(
		.CLK_FREQ(50000000)
	) uart (
		.i_clk           (i_clk		    ), 
		.in_rst          (i_rstn       	),
		
		.i_serial_rx     (i_serial_tx 	),
		.o_serial_tx     (o_serial_rx   ),
		.on_serial_cts   (     			),	// open - high Z
		.on_serial_dsr   (     			),	// open - high Z
		
		.i_byte_tx_data  (s_rx_byte   	),
		.i_byte_tx_valid (s_rx_dv  		),
		.o_byte_tx_busy  (s_rx_busy     ),
		.o_byte_rx_data  (s_tx_byte 	),
		.o_byte_rx_valid (s_tx_dv      	)
	);
	

	integer v_rx_data;
	integer v_rx_valid;
	integer v_tx_data; 

	reg			first_send = 1;



	always @(posedge i_clk) begin
		if(!i_rstn)
			hack_cnt <= 0;
		else
			if(hack_cnt == 1)
				hack_cnt <= 2;
			else
				if(s_rx_dv)	
				hack_cnt <= 1;
			else
				hack_cnt <= 0;
	end

	assign s_prev = (buf_rx_busy && !buf_rx_was_busy);

//	assign	first_send = 1;
	

	always @(negedge i_clk) begin
		if (i_rstn) begin
			
//			first_send <= 1;

			s_rx_dv <= 1'b0;
//			if(!s_rx_busy) begin	
/*			if(!s_rx_busy && first_send) begin
				$peek_rx(v_rx_valid, v_rx_data);
					if(v_rx_valid) begin
						$display("recived %d", v_rx_data);
						s_rx_byte <= v_rx_data;
						s_rx_dv <= 1'b1;
						first_send <= 0;
					end			
				end
			else */
//			if(!s_rx_busy && hack_cnt != 0) begin		//hack edge detector
			if(!s_rx_busy) begin
				$peek_rx(v_rx_valid, v_rx_data);
				if(v_rx_valid) begin
//					$display("recived %d at time %t", v_rx_data, $time);
					s_rx_byte <= v_rx_data;
					s_rx_dv <= 1'b1;
				end
			end
			

			if(s_tx_dv) begin
				v_tx_data = s_tx_byte;
//				$display("sending %d at time %t", v_tx_data, $time);
				$send_tx(v_tx_data);		
			end


		end
	end
	
endmodule
