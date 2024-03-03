/*
   Filename: compress_8_4.sv
    Version: 1.0
   Standard: SystemVerilog 2012
Description: 8-4 compression proposed in citation
     Author: Tyler Sheaves (@tsheaves)
   Citation: Marimuthu, R., et al. "Design of 8-4 and 9-4 compressors
             forhigh speed multiplication." American Journal of 
             Applied Sciences 10.8 (2013): 893-900.
*/
module compress_8_4(
	input logic [7:0]
		x,
	output logic [3:0]
		y
);
	
	// Stage 0
	logic co00, s00;
	ha i0(co00, s00, x[0], x[1]);
	logic co01, s01;
	fa i1(co01, s01, x[2], x[3], x[4]);
	logic co02, s02;
	fa i2(co02, s02, x[5], x[6], x[7]);

	// Stage 1
	logic co10;
	fa i3(co10, y[0], s00, s01, s02);
	logic co11, s11;
	fa i4(co11, s11, co00, co01, co02);

	// Stage 2
	logic co20;
	ha i5(co20, y[1], co10, s11);
	ha i6(y[3], y[2], co11, co20);

endmodule
