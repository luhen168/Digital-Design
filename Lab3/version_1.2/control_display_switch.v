module control_display_switch (
	input display_switch,
	input [7:0]	led_s, led_y_thousand_hundred,
	input [7:0] led_y_ten_unit,
	input [7:0] led_mi, led_mo,
	input [7:0] led_h, led_d,
	output reg [7:0] FPGA_led_12, FPGA_led_34, FPGA_led_56, FPGA_led_78
);

	always @(display_switch) begin
	    case (display_switch)  // có thể sử dụng if
	    	1'd0: 
				begin
	    		FPGA_led_12 = led_h; 
	    		FPGA_led_34 = led_mi;
	    		FPGA_led_56 = led_s;
				end
	      1'd1: 
				begin
	    		FPGA_led_12 = led_d; 
	    		FPGA_led_34 = led_mo;
	    		FPGA_led_78 = led_y_ten_unit;
	    		FPGA_led_56 = led_y_thousand_hundred;
				end
	    	default:
				begin	
	    		FPGA_led_12 = led_h; 
	    		FPGA_led_34 = led_mi;
	    		FPGA_led_56 = led_s;
				end
	    endcase
	end
endmodule 