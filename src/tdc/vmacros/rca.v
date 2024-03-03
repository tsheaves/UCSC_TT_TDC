/*
   Filename: rca.v
    Version: 1.0
   Standard: Verilog
Description: Gauranteed to be an adder independent of inputs
     Author: Tyler Sheaves (@tsheaves)
*/
`define FA_CELL         sky130_fd_sc_hd__fa_1  

(* techmap_celltype = "$add" *)
module rca #(parameter n=32) ( 
	input [n-1:0] 	a, b,
	input 			ci,
	output [n-1:0]	s,
	output			co
);
	wire [n:0] c;
	
	assign c[0] = ci;
	assign co = c[n];
	
	generate 
		genvar i;
		for(i=0; i<n; i=i+1) 
			`FA_CELL FA ( .COUT(c[i+1]), .CIN(c[i]), .A(a[i]), .B(b[i]), .SUM(s[i]) );
   	endgenerate

endmodule
