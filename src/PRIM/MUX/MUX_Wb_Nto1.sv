module 
#( parameter N = 2,
   parameter W = 32 ) 
MUX_Wb_Nto1 
(	input logic [0:N-1][W-1:0]
		data_in,
	input logic [$clog2(N)-1:0]
		sel,
	output logic [W-1:0]
		data_out );

	always_comb data_out = data_in[sel];

endmodule