module tt_tdc_pg_tdl
#(
	parameter len_pop_out = 6,
	parameter dl_type = "ADD",
	parameter dl_len = 2**len_pop_out
)
(
	input
		clk_launch,
		rst, en,
	input [1:0] 
		sel,
  	input
  		pg_in, pg_tog,
  		pg_bypass,
  	output
  		dl_out
);

import tdc_wrapper_pkg::*;
ctrl_csr spi_stub;

always_comb spi_stub.ctl_pls_src = sel[0];
always_comb spi_stub.ctl_pls_src = sel[1];

logic [dl_len-1:0]
	dl_w;

logic 
	mux_in_dout,
	mux_bypass,
	pg_r_out;

genvar i;

always_comb
	case(spi_stub.ctl_pls_src) 
		 PG_IN: mux_in_dout = pg_in;
		PG_TOG: mux_in_dout = pg_tog;
	endcase

always_comb
	case(spi_stub.ctl_tog) 
		TOG_BYP: mux_bypass = pg_r_out;
		TOG_REG: mux_bypass = pg_tog;
	endcase

generate
	case(dl_type)
		// TODO: Check synthesis
		"ADD": begin
			(* keep *) wire [dl_len-1:0] a, b;
			(* keep *) wire [  dl_len:0] c;
			for(i=0; i<dl_len; i+=1) begin : gen_dl
				SKY130_ADD dl(
					.a(a[i]),
					.b(b[i]),
					.cin(c[i]),
					.s(dl_out[i]),
					.cout(c[i+1])
				);
			end
			always_comb c[0] = mux_bypass;
			always_comb    a = {dl_len{1'b1}};
			always_comb    b = {dl_len{1'b1}};
			end
	endcase
endgenerate

endmodule
