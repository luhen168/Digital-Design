// TOP module 2
module test(
    input [5:0] seconds, minutes, hours,    // Input BCD 6-bits
    output [6:0] unitd_s, tend_s,				// Output 4-bits
    output [6:0] unitd_m, tend_m,
    output [6:0] unitd_h, tend_h
);
	
    wire [3:0] unit_s, ten_s;				// Output 4-bits
    wire [3:0] unit_m, ten_m;
    wire [3:0] unit_h, ten_h;

	top_bcd6bits ints_time (
		.seconds(seconds),
		.minutes(minutes),
		.hours  (hours),
		.ten_m  (ten_m),
		.ten_s  (ten_s),
		.ten_h  (ten_h),
		.unit_m (unit_m),
		.unit_s (unit_s),
		.unit_h (unit_h)
		);

	top_Display7seg display(
		.in_top({ten_h[3:0], unit_h[3:0], ten_m[3:0], unit_m[3:0], ten_s[3:0], unit_s[3:0]}),
		.out_top({tend_h[6:0], unitd_h[6:0], tend_m[6:0], unitd_m[6:0], tend_s[6:0], unitd_s[6:0]})
		);
endmodule

// TOP module BCD_6bit
module top_bcd6bits(
    input [5:0] seconds, minutes, hours,    // Input BCD 6-bits
    output [3:0] unit_s, ten_s,				// Output 4-bits
    output [3:0] unit_m, ten_m,
    output [3:0] unit_h, ten_h
);

	sub_bcd6bits ints_second (         		// sub module in top
		.bin(seconds),
		.unit(unit_s),
		.ten(ten_s)
		);
	sub_bcd6bits ints_minute (				// sub module in top
		.bin(minutes), 
		.unit(unit_m), 
		.ten(ten_m)
		);
	sub_bcd6bits ints_hour (				// sub module in top
		.bin(hours), 
		.unit(unit_h), 
		.ten(ten_h)
		);
endmodule

module sub_bcd6bits(
   input [5:0] bin,
   output [3:0] unit,ten
   );
   
integer i;
	reg [7:0] bcd;
always @(bin) begin
    bcd=0;		 	
    for (i=0;i<6;i=i+1) begin					//Iterate once for each bit in input number
        if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
		if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;

		bcd = {bcd[6:0],bin[5-i]};				//Shift one bit, and shift in proper bit from input 
    end
end

   assign unit = bcd[3:0];
	assign ten = bcd[7:4];
endmodule

// Sub module BCD_6bit
module sub_bcd6bits2(
	input [5:0] bin,
	output[3:0] unit,ten
	);
    // Khai báo biến cục bộ
    reg [7:0] shift_register;
    reg [3:0] unit_temp;
    reg [3:0] tens_temp;
    reg [5:0] bcd_temp;

	 integer i;
	always @(bin) begin
	    // Khởi tạo các giá trị ban đầu
	    shift_register = 8'b00000000;
	    bcd_temp = shift_register;

	    // Áp dụng thuật toán Double Dabble
	    for (i = 0; i < 6; i = i + 1) begin
	        // Shift phải một bit
	        shift_register = {shift_register[5], shift_register[5:1]};
	        
	        // Kiểm tra bit 3 đầu tiên của BCD
	        if (bcd_temp[3] == 1'b1) begin
	            if (unit_temp >= 5) begin
	                unit_temp = unit_temp + 3;
	            end
	            unit_temp = unit_temp + 1;
	        end
	        
	        // Shift phải một bit cho BCD
	        bcd_temp = {bcd_temp[5], bcd_temp[5:1]};
	    end

	    // Kiểm tra nếu giá trị unit_temp vượt quá 9, chuyển thành đơn vị và hàng chục
	    if (unit_temp >= 10) begin
	        tens_temp = 1;
	        unit_temp = unit_temp - 10;
	    end else begin
	        tens_temp = 0;
	    end
	end
	// Gán giá trị đầu ra
	assign unit = unit_temp;
	assign tens = tens_temp;
endmodule

//Module Top Display 7seg
module top_Display7seg(
	input [23:0] in_top,    // bit msb trong so ben trai, [msb:lsb]
	output [41:0] out_top
);

sub_Display7seg inst0(.in(in_top[3:0]),.out(out_top[6:0])); 			// module con duoc bieu dien in theo tin hieu in_top và out theo tin hieu out_top 
sub_Display7seg inst1(.in(in_top[7:4]),.out(out_top[13:7]));
sub_Display7seg inst2(.in(in_top[11:8]),.out(out_top[20:14]));
sub_Display7seg inst3(.in(in_top[15:12]),.out(out_top[27:21]));
sub_Display7seg inst4(.in(in_top[19:16]),.out(out_top[34:28]));
sub_Display7seg inst5(.in(in_top[23:20]),.out(out_top[41:35]));

endmodule

// Submodule 
module sub_Display7seg (		// module giai ma led 7 thanh 
	input [3:0] in,				// khai bao co 4 input 0->3 ung voi A->D
	output [6:0] out				// khai bao co 7 output 0->6 ung voi F1->F7
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
