module led_s (
	input enable_display,
   	input [6:0] cnt_s,
	output [13:0] led_s
);

    led_decoder inst_led_decoder (
        .enable_display(enable_display),
        .cnt(cnt_s),
        .led(led_s)
    );
    
endmodule

module led_mi (
	input enable_display,
   	input [6:0] cnt_mi,
	output [13:0] led_mi
);

    led_decoder inst_led_decoder (
        .enable_display(enable_display),
        .cnt(cnt_mi),
        .led(led_mi)
    );
    
endmodule

module led_h (
	input enable_display,
   	input [6:0] cnt_h,
	output [13:0] led_h
);

    led_decoder inst_led_decoder (
        .enable_display(enable_display),
        .cnt(cnt_h),
        .led(led_h)
    );
    
endmodule