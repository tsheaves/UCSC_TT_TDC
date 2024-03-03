/*
   Filename: pop_count_8_4.sv
    Version: 1.0
   Standard: SystemVerilog 2012
Description: Popcount using 8-4 compression
     Author: Tyler Sheaves (@tsheaves)
*/
module pop_count_8_4 #(
    parameter N=64
)(
	input logic
		clk, rst, en,
		input logic [N-1:0]
		x,
	output logic [$clog2(N):0]
		y
);
    localparam clog2_N = $clog2(N);
    // Stage 1: 1st 8-4 compression
    // Packed 2-D array to hold stage 1 compression
    logic [3:0] compr_stage_1 [(N/8)-1:0];
    integer l, m, p, q;
    genvar i;

    generate
        // Distribute TDC output to 8-4 compressors
        for (i=0; i<N/8; i=i+1) begin : compr_s1
            compress_8_4 compr(
                .x(x[8*i+7:8*i]),
                .y(compr_stage_1[i])
            );
        end
    endgenerate
    
    // Reshape output of stage 1
    logic [(N/8)-1:0] compr_stage_1_inv [3:0];
    always_comb begin
	for(l=0; l<N/8; l=l+1)
		for(m=0; m<4; m=m+1)
			compr_stage_1_inv[m][l]=compr_stage_1[l][m];
    end
  
    // Pipe stage 2: 2nd 8-4 compression
    genvar j;
    logic [$clog2(N):0] compr_stage_2 [N/64-1:0] [3:0];
    generate
        // Distribute chunk of dots
        for (i=0; i<N/64; i=i+1) begin : col_stage2
            for (j=0; j<4; j=j+1) begin : chunk_stage2
                logic [3:0] compr_y;
                compress_8_4 compr(
                    .x(compr_stage_1_inv[j][8*i+7:8*i]),
                    .y(compr_y)
                );
                always_comb begin
                    compr_stage_2[i][j] = {$clog2(N){1'b0}};
                    compr_stage_2[i][j] = {{clog2_N-3{1'b0}}, compr_y} << j;
                end
            end
        end
    endgenerate

    // Wrap up by adding all terms
    logic [$clog2(N):0] y_c;
    always_comb begin
        y_c = {$clog2(N){1'b0}};
        for(p=0; p<N/64; p=p+1)
		    for(q=0; q<4; q=q+1)
			    y_c = y_c + compr_stage_2[p][q];	
    end
    
    // Output registers
    always_ff@(posedge clk) begin
        if(rst)
            y <= {$clog2(N){1'b0}};
        else if(en)
            y <= y_c;
    end

`ifdef ASSERT_ON
    // Check tested parameter range
    if((N & 5'd31) != 5'd0 || N < 63)
        $error("Illegal value for parameter N (%d). Should be >63 and divisible by 32", N);
	
	// Lots of code to reduce area, but this is the basic assertion
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
