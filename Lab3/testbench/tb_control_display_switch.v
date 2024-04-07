module control_display_switch (
	input display_switch,
	input [13:0] led_h, led_mi, led_s,
	input [13:0] led_d, led_mo, led_y_thousand_hundred, led_y_ten_unit,
	output reg [13:0] FPGA_led_12, FPGA_led_34, FPGA_led_56, FPGA_led_78
);

	always @(display_switch) begin
	    case (display_switch)  // có thể sử dụng if
	    	1'd0: 
				begin
	    		FPGA_led_12 = led_h; 
	    		FPGA_led_34 = led_mi;
	    		FPGA_led_56 = led_s;
				FPGA_led_78 = 14'b11111111111111;
				end
	      	1'd1: 
				begin
	    		FPGA_led_12 = led_d; 
	    		FPGA_led_34 = led_mo;
	    		FPGA_led_56 = led_y_thousand_hundred;
	    		FPGA_led_78 = led_y_ten_unit;
				end
	    endcase
	end
endmodule 