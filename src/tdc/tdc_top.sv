module tdc_top #(
    parameter n=64,    
    parameter dl_type="rca",
    parameter n_sync=2 // Must be gt 0
)(
    input logic
        clk_launch,
        clk_capture,
        rst,
        en,    
    input logic 
        pg_src,
        pg_bypass,
    input logic
        pg_in,
        pg_tog,
    output [$clog2(n):0]
        hw
);

logic 
    pg_out;
logic [n-1:0]
    dl_out_r [n_sync];

tdc_pg pg(
	.clk_launch,
	.rst(rst), 
    .en(en),
    .pg_in(pg_in), 
    .pg_tog(pg_tog),	
    .pg_src(pg_src),
  	.pg_bypass(pg_bypass),
  	.pg_out(pg_out)
);

delay_line #(
    .n(n),
    .dl_type("rca")
) ( 
	.in(pg_out),
	.dl_out(dl_out[0])
);

// Combined capture & sync stages
integer i;
always@(posedge clk_capture)
   for(i=1; i<n_sync+1; i=i+1)
        dl_out_r[i] <= dl_out_r[i-1]; 

// Can swap out if needed for performance
pop_count_simple #(
    .N(n),
    .METHOD("SV")
)(
		.clk(clk_capture), 
        .rst(rst),
        .en(en),
		.x(dl_out_r[n_sync]),
		.y(hw)
);

endmodule
