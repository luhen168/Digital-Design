//4 arithmetic operations (addition, subtraction, increment and decrement) 
//and 4 logic operations (AND, OR, INV, identity)

module ALU_if_nested(
	input [2:0] s,   
	input a,b,
	output reg result
);
	always @ (a or b or s)
		begin
		    case(s)
		        3'b000: result = a + b; // add
		        3'b001: result = a - b; // sub
		        3'b010: result = a + 1; // incre
		        3'b011: result = a - 1; // decre
		        3'b100: result = a & b; // and
		        3'b101: result = a | b; // or
		        3'b110: result = ~a; // inv
		        3'b111: result = a; // identity 
		        default: result = a + b; // default value = 
		    endcase
		end
endmodule