module SKY130_ADD(
	input logic
		a, b, cin,
	output logic
		s, cout
);

	// TODO: Add as macro so we can place
	always_comb {cout, s} = a + b + cin;

endmodule