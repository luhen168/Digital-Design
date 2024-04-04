module control (
	input clk,
	input rst,
	input enable_pulse_1s, 
	input display_switch,
	input [5:0] increase_signal, decrease_signal,
    input [5:0] enable_display,
    input [5:0] enable_cnt,
    input [1:0] enable_pulse_1s,
    output [7:0] FPGA_led_1, FPGA_led_2, FPGA_led_3, FPGA_led_4, FPGA_led_5, FPGA_led_6, FPGA_led_7, FPGA_led_8
);
	wire pulse_1s;
	wire [5:0] cnt_s, cnt_mi, cnt_h, cnt_d, cnt_mo;
    wire [6:0] cnt_y_ten_unit, cnt_y_thousand_hundred;
    wire [3:0] unit_s, ten_s;							
    wire [3:0] unit_mi, ten_mi;
    wire [3:0] unit_h, ten_h;
    wire [3:0] unit_d, ten_d;
    wire [3:0] unit_mo, ten_mo;
    wire [3:0] unit_y_ten_unit, ten_y_ten_unit;
    wire [3:0] unit_y_thousand_hundred, ten_y_thousand_hundred;
    wire [7:0] FPGA_led_12, FPGA_led_34, FPGA_led_56, FPGA_led_78;

	pulse_1s pulse_1s (
		.clk(clk),
		.rst(rst),
    	.enable_pulse_1s(enable_pulse_1s),
    	.pulse_1s(pulse_1s)
	);

	control_cnt cnt (
		.clk(clk),
	    .rst(rst),
	    .pulse_1s(pulse_1s),
	    .increase_s(increase_signal[0]),
	    .increase_mi(increase_signal[1]),
	    .increase_h(increase_signal[2]),
	    .increase_d(increase_signal[3]),
	    .increase_mo(increase_signal[4]),
	    .increase_y(increase_signal[5]),
	    .decrease_s(decrease_signal[0]),
	    .decrease_mi(decrease_signal[1]),
	    .decrease_h(decrease_signal[2]),
	    .decrease_d(decrease_signal[3]),
	    .decrease_mo(decrease_signal[4]),
	    .decrease_y(decrease_signal[5]),
	    .enable_cnt_s(enable_cnt[0]),
	    .enable_cnt_mi(enable_cnt[1]),
	   	.enable_cnt_h(enable_cnt[2]),
	    .enable_cnt_d(enable_cnt[3]),
	    .enable_cnt_mo(enable_cnt[4]),
	   	.enable_cnt_y(enable_cnt[5]),
	   	.cnt_s(cnt_s),
	   	.cnt_mi(cnt_mi),
	   	.cnt_h(cnt_h),
	   	.cnt_d(cnt_d),
	   	.cnt_mo(cnt_mo),
		.cnt_y_ten_unit(cnt_y_ten_unit), 
		.cnt_y_thousand_hundred(cnt_y_thousand_hundred)
	);

	control_bcd bcd (
		.enable_s(enable_display[0]),
		.enable_mi(enable_display[1]), 
		.enable_h(enable_display[2]),
		.enable_d(enable_display[3]), 
		.enable_mo(enable_display[4]), 
		.enable_y(enable_display[5]), 	
	   	.cnt_s(cnt_s),
	   	.cnt_mi(cnt_mi),
	   	.cnt_h(cnt_h),
	   	.cnt_d(cnt_d),
	   	.cnt_mo(cnt_mo),
		.cnt_y_ten_unit(cnt_y_ten_unit), 
		.cnt_y_thousand_hundred(cnt_y_thousand_hundred)
		.unit_s(unit_s),
		.unit_mi(unit_mi), 
	    .unit_h(unit_h),
	    .unit_d(unit_d),
	    .unit_mo(unit_mo),
	    .unit_y_ten_unit(unit_y_ten_unit),
	    .unit_y_thousand_hundred(unit_y_thousand_hundred),  
		.ten_s(ten_s),							// Output 4-bits
	    .ten_mi(ten_mi),
	    .ten_h(ten_h),
	    .ten_d(ten_d),
	    .ten_mo(ten_mo),
	    .ten_y_ten_unit(ten_y_ten_unit),
	    .ten_y_thousand_hundred(ten_y_thousand_hundred)
	);


	control_display_switch display_switch(
		.display_switch(display_switch),
		.led_s({ten_s, unit_s}),
		.led_mi({ten_mi, unit_mi}), 
		.led_h({ten_h, unit_h}), 
		.led_d({ten_d, unit_d}),
		.led_mo({ten_mo, unit_mo}),
		.led_y_ten_unit({ten_y_ten_unit, unit_y_ten_unit}),
		.led_y_thousand_hundred({ten_y_thousand_hundred, unit_y_thousand_hundred}),
		.FPGA_led_12(FPGA_led_12),
		.FPGA_led_34(FPGA_led_34), 
		.FPGA_led_56(FPGA_led_56), 
		.FPGA_led_78(FPGA_led_78)
	);

	control_display7seg display(
		.in_top({FPGA_led_12[7:4], FPGA_led_12[3:0], FPGA_led_34[7:4], FPGA_led_34[3:0], FPGA_led_56[7:4], FPGA_led_56[3:0], FPGA_led_78[7:4], FPGA_led_78[3:0]}),
		.out_top({FPGA_led_1[6:0], FPGA_led_2[6:0], FPGA_led_3[6:0], FPGA_led_4[6:0], FPGA_led_5[6:0], FPGA_led_6[6:0], FPGA_led_7[6:0], FPGA_led_8[6:0]})
	);

endmodule