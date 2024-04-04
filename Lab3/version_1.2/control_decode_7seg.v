// TOP module
module control_decode_7seg (
	input enable_s, enable_mi, enable_h,
		input enable_d, enable_mo, enable_y,
    input [5:0] cnt_s, cnt_mi, cnt_h, cnt_d, cnt_mo,   	// Input BCD 6-bits
    input [6:0] cnt_y_ten_unit, cnt_y_thousand_hundred,	// Input BCD 7-bits 
	output [13:0] led_s, led_y_thousand_hundred,
	output [13:0] led_y_ten_unit,
	output [13:0] led_mi, led_mo,
	output [13:0] led_h, led_d
);
    wire [7:0] led8_s, led8_mi, led8_h;
    wire [7:0] led8_d, led8_mo;
    wire [7:0] led8_y_ten_unit;
    wire [7:0] led8_y_thousand_hundred;


	bcd inst_led_s (         		
		.enable_display(enable_s),
		.cnt(cnt_s),
		.led_out(led8_s)
	);

	bcd inst_led_mi (				// sub module in top
		.enable_display(enable_mi),
		.cnt(cnt_mi),
		.led_out(led8_mi)
	);

	bcd inst_led_h (				// sub module in top
		.enable_display(enable_h),
		.cnt(cnt_h),
		.led_out(led8_h)	
	);

	bcd inst_led_d (
		.enable_display(enable_d),
		.cnt(cnt_d),
		.led_out(led8_d)
    );

	bcd inst_led_mo (
		.enable_display(enable_mo),
		.cnt(cnt_mo),
		.led_out(led8_mo)
    );

	bcd inst_led_y_ten_unit (
		.enable_display(enable_y),
		.cnt(cnt_y_ten_unit),
		.led_out(led8_y_ten_unit)
    );

   bcd inst_led_y_thousand_hundred (
		.enable_display(enable_y),
		.cnt(cnt_y_thousand_hundred),
		.led_out(led8_y_thousand_hundred)
    );

   control_display_7seg inst_display_7seg(
		.in_top({led8_h[7:4], led8_h[3:0], led8_mi[7:4], 
				led8_mi[3:0], led8_s[7:4], led8_s[3:0], 
				led8_d[7:4], led8_d[3:0], led8_mo[7:4], 
				led8_mo[3:0], led8_y_ten_unit[7:4], led8_y_ten_unit[3:0],
				led8_y_thousand_hundred[7:4], led8_y_thousand_hundred[3:0]}),
		.out_top({led_h[13:0], led_mi[13:0], led_s[13:0], led_d[13:0], led_mo[13:0], 
				led_h[13:0], led_y_ten_unit[13:0], led_y_thousand_hundred[13:0]})
	);
endmodule

// BCD by Doubble Dabble 
module bcd(
	input [5:0] enable_display,
   	input [6:0] cnt,
   	output [7:0] led_out
);
   
	integer i;
	reg [7:0] bcd;
	always @(cnt) begin
	    bcd=0;		 	
	    for (i=0;i<6;i=i+1) begin					//Iterate once for each bit in input number
	        if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
			if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;

			bcd = {bcd[6:0],cnt[6-i]};				//Shift one bit, and shift in proper bit from input 
	    end
	end
    assign led_out = enable_display ? bcd[7:0] : 8'b11111111;
endmodule

// Module Top Display 7seg
module control_display_7seg(
	input [55:0] in_top,    		// bit msb trong so ben trai, [msb:lsb]
	output [97:0] out_top
);
    bin_to_7seg inst0(.in(in_top[3:0]),.out(out_top[6:0])); 			// module con duoc bieu dien in theo tin hieu in_top và out theo tin hieu out_top 
    bin_to_7seg inst1(.in(in_top[7:4]),.out(out_top[13:7]));
    bin_to_7seg inst2(.in(in_top[11:8]),.out(out_top[20:14]));
    bin_to_7seg inst3(.in(in_top[15:12]),.out(out_top[27:21]));
    bin_to_7seg inst4(.in(in_top[19:16]),.out(out_top[34:28]));
    bin_to_7seg inst5(.in(in_top[23:20]),.out(out_top[41:35]));
    bin_to_7seg inst6(.in(in_top[27:24]),.out(out_top[48:42]));
    bin_to_7seg inst7(.in(in_top[31:28]),.out(out_top[55:49]));
    bin_to_7seg inst8(.in(in_top[35:32]),.out(out_top[62:56])); 			// module con duoc bieu dien in theo tin hieu in_top và out theo tin hieu out_top 
    bin_to_7seg inst9(.in(in_top[39:36]),.out(out_top[69:63]));
    bin_to_7seg inst10(.in(in_top[43:40]),.out(out_top[76:70]));
    bin_to_7seg inst11(.in(in_top[47:44]),.out(out_top[83:77]));
    bin_to_7seg inst12(.in(in_top[51:48]),.out(out_top[90:84]));
    bin_to_7seg inst13(.in(in_top[55:52]),.out(out_top[97:91]));
endmodule

// sub module 
module bin_to_7seg (		// module giai ma led 7 thanh 
	input [3:0] in,			// khai bao co 4 input 0->3 ung voi A->D
	output [6:0] out		// khai bao co 7 output 0->6 ung voi F1->F7
);
	wire x,y,z,w;						// Tao day tin hieu noi trung gian 
	assign x = in[3];
	assign y = in[2];
	assign z = in[1];
	assign w = in[0];
	// Luc nap mach co the bi nguoc thi dao lai 0 la sang 
	assign out[0] = x&z | x&y | y&~z&~w | ~x&~y&~z&w ;				//ham Fa 
	assign out[1] = x&z | x&y | y&~z&w | y&z&~w  ;					//ham Fb 
	assign out[2] = x&z | x&y | ~y&z&~w		;   						//ham Fc
	assign out[3] = x&z | x&y | y&~z&~w | y&z&w | ~x&~y&~z&w; 	//ham Fd 
	assign out[4] = w | y&~z | x&z 	;									//ham Fe 
	assign out[5] = ~y&z | z&w | x&y | ~x&~y&w;						//ham Ff
	assign out[6] = x&z | x&y | ~x&~y&~z | y&z&w ;					//ham Fg 
endmodule

