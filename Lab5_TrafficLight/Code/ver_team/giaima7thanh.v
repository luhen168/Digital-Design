module giaima7thanh(
	input [3:0] so_gma,
	output reg [13:0] sseg);
	
always @(so_gma)
	case(so_gma)
		0: sseg = 14'b10000001000000;
		1: sseg = 14'b10000001111001;
		2: sseg = 14'b10000000100100;
		3: sseg = 14'b10000000110000;
		4: sseg = 14'b10000000011001;
		5: sseg = 14'b10000000010010;
		6: sseg = 14'b10000000000010;
		7: sseg = 14'b10000001111000;
		8: sseg = 14'b10000000000000;
		9: sseg = 14'b10000000010000;
		10: sseg = 14'b11110011000000;
		default: sseg = 14'b10000001000000;
	endcase
endmodule

