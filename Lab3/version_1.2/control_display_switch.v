module control_display_switch (
	input display_switch,
	input [13:0] led_h, led_mi, led_s,
	input [13:0] led_d, led_mo, led_y_thousand_hundred, led_y_ten_unit,
	output [13:0] FPGA_led_12, FPGA_led_34, FPGA_led_56, FPGA_led_78
);

	assign FPGA_led_12 = display_switch ? led_d : led_h;
	assign FPGA_led_34 = display_switch ? led_mo : led_mi;
	assign FPGA_led_56 = display_switch ? led_y_thousand_hundred : led_s;
	assign FPGA_led_78 = display_switch ? led_y_ten_unit : 14'b11111111111111;
endmodule 