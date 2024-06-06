// TOP module
module display (
	input rst,
	input clk,
    input [5:0] display_pd, display_nopd,   	// Input BCD 6-bits
	output [13:0] FPGA_led7seg_12, FPGA_led7seg_56
);

    wire [7:0] led8_pd, led8_nopd;

	bcd led_pd (
		.rst(rst),
		.clk(clk),         		
		.cnt({4'b0,display_pd}),
		.led_out(led8_pd)
	);

	bcd led_nopd (				
		.rst(rst),
		.clk(clk), 
		.cnt({4'b0,display_nopd}),
		.led_out(led8_nopd)
	);

   control_display_7seg inst_display_7seg(
		.in_top({led8_pd[7:4], led8_pd[3:0], 
				led8_nopd[7:4], led8_nopd[3:0], 
				}),
		.out_top({led_pd[13:0], 
				led_nopd[13:0], 
				})
	);
endmodule

// BCD by Doubble Dabble 
module bcd(
	input clk,
	input rst,
   	input [6:0] cnt,
   	output [7:0] led_out
);
   
	integer i;
	reg [7:0] bcd;
	always @(cnt) begin
	    bcd=0;		 	
	    for (i=0;i<7;i=i+1) begin					//Iterate once for each bit in input number
	        if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
			if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;

			bcd = {bcd[6:0],cnt[6-i]};				//Shift one bit, and shift in proper bit from input 
	    end
	end
    assign led_out = (rst == 1) ? bcd[7:0] : 8'b11111111;

endmodule

// Module Top Display 7seg
module control_display_7seg(
	input [15:0] in_top,    		// bit msb trong so ben trai, [msb:lsb]
	output [27:0] out_top
);
    bin_to_7seg inst0(.in(in_top[3:0]),.out(out_top[6:0])); 			// module con duoc bieu dien in theo tin hieu in_top và out theo tin hieu out_top 
    bin_to_7seg inst1(.in(in_top[7:4]),.out(out_top[13:7]));
    bin_to_7seg inst2(.in(in_top[11:8]),.out(out_top[20:14]));
    bin_to_7seg inst3(.in(in_top[15:12]),.out(out_top[27:21]));

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
	assign out[0] = x&z | x&y | y&~z&~w | ~x&~y&~z&w ;				//ham Fa ~ have lowest weight
	assign out[1] = x&z | x&y | y&~z&w | y&z&~w  ;					//ham Fb 
	assign out[2] = x&z | x&y | ~y&z&~w		;   						//ham Fc
	assign out[3] = x&z | x&y | y&~z&~w | y&z&w | ~x&~y&~z&w; 	//ham Fd 
	assign out[4] = w | y&~z | x&z 	;									//ham Fe 
	assign out[5] = ~y&z | z&w | x&y | ~x&~y&w;						//ham Ff
	assign out[6] = x&z | x&y | ~x&~y&~z | y&z&w ;					//ham Fg 
endmodule
