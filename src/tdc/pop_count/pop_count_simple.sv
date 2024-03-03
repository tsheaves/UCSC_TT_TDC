/*
   Filename: pop_count_simple.sv
    Version: 1.0
   Standard: SystemVerilog 2012
Description: Simple pop count methods
     Author: Tyler Sheaves (@tsheaves)
*/
module pop_count_simple 
#(
    parameter N=64,
    parameter METHOD="SV"
)(
	input logic
		clk, 
        rst,
        en,
    input logic [N-1:0]
		x,
	output logic [$clog2(N):0]
		y
);

    logic [$clog2(N):0]
		y_c;
 
    generate
        // Easy ways of computing pop count 
        case(METHOD)
            "LOOP": begin
                always_comb begin
                    y_c = {$clog2(N)+1{1'b0}};
                    for(int i=0; i < N; i+=1) begin
                        y_c = y_c + {{$clog2(N){1'b0}}, x[i]}; 
                    end
                end
            end 
            "SV": begin
                always_comb
                    y_c = $countones(x);
            end
        endcase
    endgenerate

    // Ouput registers
    always_ff@(posedge clk) begin
        if(rst)
            y <= {$clog2(N)+1{1'b0}};
        else if(en)
            y <= y_c;
    end

`ifdef ASSERT_ON
  	check_popcount:
        assert
            property (                                  
                @(posedge clk) disable iff (rst || $past(x)==={N{1'bx}} || x==={N{1'bx}})
                    y == $countones($past(x))
            )
            else                                    
                $error("Error y (%0d) doesn't equal modeled value (%d) for x (%0b)",
                       y, $countones($past(x)), $past(x));
`endif

endmodule
