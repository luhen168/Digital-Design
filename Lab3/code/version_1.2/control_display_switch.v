module control_display_switch (
	input clk, rst, 
	input display_switch,
	input [13:0] led_s, led_y_thousand_hundred,
	input [13:0] led_y_ten_unit,
	input [13:0] led_mi, led_mo,
	input [13:0] led_h, led_d,
	output reg [13:0] FPGA_led_12, FPGA_led_34, FPGA_led_56, FPGA_led_78
);

	
	always @(posedge clk or negedge rst ) begin
	    if (~display_switch) begin
	    	FPGA_led_12 = led_h; 
	    	FPGA_led_34 = led_mi;
	    	FPGA_led_56 = led_s;
	    	FPGA_led_78 = 14'b11111111111111;
		end else begin
	    	FPGA_led_12 = led_d; 
	    	FPGA_led_34 = led_mo;
	    	FPGA_led_78 = led_y_ten_unit;
	    	FPGA_led_56 = led_y_thousand_hundred;
		end
	end
endmodule 