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

module led_d (
	input enable_display,
   	input [6:0] cnt_d,
	output [13:0] led_d
);

    led_decoder inst_led_decoder (
        .enable_display(enable_display),
        .cnt(cnt_d),
        .led(led_d)
    );
    
endmodule

module led_mo (
	input enable_display,
   	input [6:0] cnt_mo,
	output [13:0] led_mo
);

    led_decoder inst_led_decoder (
        .enable_display(enable_display),
        .cnt(cnt_mo),
        .led(led_mo)
    );
    
endmodule

module led_y_ten_unit (
	input enable_display,
   	input [6:0] cnt_y_ten_unit,
	output [13:0] led_y_ten_unit
);

    led_decoder inst_led_decoder (
        .enable_display(enable_display),
        .cnt(cnt_y_ten_unit),
        .led(led_y_ten_unit)
    );
    
endmodule

module led_y_thousand_hundred (
	input enable_display,
   	input [6:0] cnt_y_thousand_hundred,
	output [13:0] led_y_thousand_hundred
);

    led_decoder inst_led_decoder (
        .enable_display(enable_display),
        .cnt(cnt_y_thousand_hundred),
        .led(led_y_thousand_hundred)
    );
    
endmodule