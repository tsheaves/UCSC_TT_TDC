/*
   Filename: fa.sv
    Version: 1.0
   Standard: SystemVerilog 2012
Description: Full adder
     Author: Tyler Sheaves (@tsheaves)
*/
module fa(
	output logic
		co,
		s,
	input logic
		a,
		b,
		ci
);

	always_comb {co, s} = {1'b0,a} + {1'b0,b} + {1'b0,ci};

endmodule
