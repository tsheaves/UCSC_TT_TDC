/*
   Filename: ha.sv
    Version: 1.0
   Standard: SystemVerilog 2012
Description: Half adder
     Author: Tyler Sheaves (@tsheaves)
*/
module ha(
	output logic
		co,
		s,
	input logic
		a,
		b
);

	always_comb {co, s} = 2'b0 + {1'b0,a} + {1'b0,b};

endmodule
