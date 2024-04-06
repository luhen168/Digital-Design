module control (
	input clk,
	input rst,
	input enable_pulse_1s, 
	input display_switch,
	input increase_signal, decrease_signal,
    input [5:0] enable_display,
    input [5:0] enable_cnt,
    output [13:0] FPGA_led_12, FPGA_led_34, FPGA_led_56, FPGA_led_78
);
	wire pulse_1s;
	
	wire [5:0] cnt_s, cnt_mi, cnt_h, cnt_d, cnt_mo;
    wire [6:0] cnt_y_ten_unit, cnt_y_thousand_hundred;
    wire [13:0] led_s, led_y_thousand_hundred;
	wire [13:0] led_y_ten_unit;
	wire [13:0] led_mi, led_mo;
	wire [13:0] led_h, led_d;

	pulse_1s inst_pulse_1s (
		.clk(clk),
		.rst(rst),
    	.enable_pulse_1s(enable_pulse_1s),
    	.pulse_1s(pulse_1s)
	);

	control_cnt cnt (
		.clk(clk),
	    .rst(rst),
	    .pulse_1s(pulse_1s),
	    .increase_signal(increase_signal),
	    .decrease_signal(decrease_signal),
	    .enable_cnt_d(enable_cnt[5]),	   	
	   	.enable_cnt_mo(enable_cnt[4]),
	   	.enable_cnt_y(enable_cnt[3]),
	    .enable_cnt_h(enable_cnt[2]),
	    .enable_cnt_mi(enable_cnt[1]),
	    .enable_cnt_s(enable_cnt[0]),
	   	.cnt_s(cnt_s),
	   	.cnt_mi(cnt_mi),
	   	.cnt_h(cnt_h),
	   	.cnt_d(cnt_d),
	   	.cnt_mo(cnt_mo),
		.cnt_y_ten_unit(cnt_y_ten_unit), 
		.cnt_y_thousand_hundred(cnt_y_thousand_hundred)
	);

	control_decode_7seg decode (
	    .enable_d(enable_display[5]),	   	
	   	.enable_mo(enable_display[4]),
	   	.enable_y(enable_display[3]),
	    .enable_h(enable_display[2]),
	    .enable_mi(enable_display[1]),
	    .enable_s(enable_display[0]),	
	   	.cnt_s(cnt_s),
	   	.cnt_mi(cnt_mi),
	   	.cnt_h(cnt_h),
	   	.cnt_d(cnt_d),
	   	.cnt_mo(cnt_mo),
		.cnt_y_ten_unit(cnt_y_ten_unit), 
		.cnt_y_thousand_hundred(cnt_y_thousand_hundred),
		.led_s(led_s),
		.led_mi(led_mi), 
		.led_h(led_h), 
		.led_d(led_d),
		.led_mo(led_mo),
		.led_y_ten_unit(led_y_ten_unit),
		.led_y_thousand_hundred(led_y_thousand_hundred)
	);


	control_display_switch inst_display_switch(
		.clk(clk),
		.rst(rst), 
		.display_switch(display_switch),
		.led_s(led_s),
		.led_mi(led_mi), 
		.led_h(led_h), 
		.led_d(led_d),
		.led_mo(led_mo),
		.led_y_ten_unit(led_y_ten_unit),
		.led_y_thousand_hundred(led_y_thousand_hundred),
		.FPGA_led_12(FPGA_led_12),
		.FPGA_led_34(FPGA_led_34), 
		.FPGA_led_56(FPGA_led_56), 
		.FPGA_led_78(FPGA_led_78)
	);

endmodule