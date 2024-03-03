module tdc_pg (
	input
		clk_launch,
		rst, 
        en,
    input
  		pg_in, 
        pg_tog,	
    input
		pg_src,
  		pg_bypass,
  	output
  		pg_out
);

import tdc_pkg::*;
ctrl_lines ctl_lines;

logic 
	mux_in_dout,
	mux_bypass,
	pg_r_out;

always_comb ctl_lines.ctl_pls_src = pg_src;
always_comb ctl_lines.ctl_tog= sel[1];

always_comb
	case(spi_stub.ctl_pls_src) 
		 PG_IN: mux_in_dout = pg_in;
		PG_TOG: mux_in_dout = pg_tog;
	endcase

always_comb
	case(spi_stub.ctl_tog) 
		TOG_BYP: pg_out = pg_r_out;
		TOG_REG: pg_out = pg_tog;
	endcase

always_ff@(posedge clk_launch)
    if(rst) begin
        pg_r_out <= 1'b0;
    end else if(en)
        pg_r_out <= mux_in_dout;
    

endmodule
