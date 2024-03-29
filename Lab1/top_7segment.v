//Comment method 1: the first project
/*Comment method 2 */
//Module Top 
module top_7segment(
	input [15:0] in_top,    // bit msb trong so ben trai, [msb:lsb]
	output [27:0] out_top
);

bin_to_7segment inst0(.in(in_top[3:0]),.out(out_top[6:0])); 			// module con duoc bieu dien in theo tin hieu in_top và out theo tin hieu out_top 
bin_to_7segment inst1(.in(in_top[7:4]),.out(out_top[13:7]));
bin_to_7segment inst2(.in(in_top[11:8]),.out(out_top[20:14]));
bin_to_7segment inst3(.in(in_top[15:12]),.out(out_top[27:21]));

endmodule


module bin_to_7segment (		// module giai ma led 7 thanh 
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