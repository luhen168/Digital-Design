module led_decoder (
	input enable_display,
   input [6:0] cnt,
	output [13:0] led
);

	wire [7:0] bcd_out;
	
	bcd inst_bcd (
		.enable_display(enable_display),
		.cnt(cnt),
		.led_out(bcd_out)
	);
	
	bin_to_7seg inst_bin_to_7seg_1 (
		.in(bcd_out[7:4]),
		.out(led[13:7])
	);
	
	bin_to_7seg inst_bin_to_7seg_2 (
		.in(bcd_out[3:0]),
		.out(led[6:0])
	);
endmodule