module tdc_wrapper
#(
	parameter n_insync,
	parameter n_outsync,
)
(
	// TODO - move to SPI
	input logic
		clk_launch,
		clk_capture,
		rst,

	
);
	import tdc_wrapper_pkg::*;
	ctrl_csr ctl_csr;

	always@(posedge clk_launch)
		// Q1 - doesn't seem like a pin is needed
		tog <= rst ? 1'b0 : ~tog;


endmodule