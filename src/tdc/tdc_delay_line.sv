/*
   Filename: tdc_delay_line.sv
    Version: 1.0
   Standard: SystemVerilog 2012
Description: Create a delay line using vmacros
     Author: Tyler Sheaves (@tsheaves)
*/
module delay_line #(
    parameter n=32,
    parameter dl_type="rca"
) ( 
	input 
        in,
	output [n-1:0]
        dl_out
);
	
    generate
	    case(dl_type)
		    "rca": begin
                logic keep_co;
			    (* keep *)
			    rca dl #(.n(n))(
				    .a({n{1'b1}}),
				    .b({n{1'b1}}),
				    .ci(in),
				    .s(dl_out),
				    .co(keep_co)
			    );
            end
	    endcase
    endgenerate

endmodule
