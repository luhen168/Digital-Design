// TOP module
module control_bcd(
	input enable_s, enable_mi, enable_h,
	input enable_d, enable_mo, enable_y, 	
    input [5:0] cnt_s, cnt_mi, cnt_h, cnt_d, cnt_mo,   	// Input BCD 6-bits
    input [6:0] cnt_y_ten_unit, cnt_y_thousand_hundred,	// Input BCD 7-bits
    output [3:0] unit_s, ten_s,							// Output 4-bits
    output [3:0] unit_mi, ten_mi,
    output [3:0] unit_h, ten_h
    output [3:0] unit_d, ten_d,
    output [3:0] unit_mo, ten_mo
    output [3:0] unit_y_ten_unit, ten_y_ten_unit,
    output [3:0] unit_y_thousand_hundred, ten_y_thousand_hundred
);

	led_s ints_second (         		
		.enable_display(enable_s),
		.cnt(cnt_s),
		.unit(unit_s),
		.ten(ten_s)
	);

	led_mi ints_minute (				// sub module in top
		.enable_display(enable_mi),
		.cnt(cnt_mi),
		.unit(unit_mi),
		.ten(ten_mi)
	);

	led_h ints_hour (				// sub module in top
		.enable_display(enable_h),
		.cnt(cnt_h),
		.unit(unit_h),
		.ten(ten_h)		
	);

	led_d ints_d (
		.enable_display(enable_d),
		.cnt(cnt_d),
		.unit(unit_d),
		.ten(ten_d)
    );

	led_mo ints_mo (
		.enable_display(enable_mo),
		.cnt(cnt_mo),
		.unit(unit_mo),
		.ten(ten_mo)
    );

	led_y_ten_unit ints_y (
		.enable_display(enable_y),
		.cnt(cnt_y_ten_unit),
		.unit(unit_y_ten_unit),
		.ten(ten_y_ten_unit)
    );

    led_y_thousand_hundred ints_y (
		.enable_display(enable_y),
		.cnt(cnt_y_thousand_hundred),
		.unit(unit_y_thousand_hundred),
		.ten(ten_y_thousand_hundred)
    );


endmodule

// Doubble Dabble 
module bcd(
	input enable_display,
   	input [6:0] cnt,
   	output [3:0] unit,ten
);
   
	integer i;
	reg [7:0] bcd;
	always @(cnt) begin
	    bcd=0;		 	
	    for (i=0;i<6;i=i+1) begin					//Iterate once for each bit in input number
	        if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
			if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;

			bcd = {bcd[6:0],bin[5-i]};				//Shift one bit, and shift in proper bit from input 
	    end
	end
    assign unit = enable_display ? bcd[3:0] : 4'b1111;
    assign ten = enable_display ? bcd[7:4] : 4'b1111;
endmodule

