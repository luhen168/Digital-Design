//4 arithmetic operations (addition, subtraction, increment and decrement) 
//and 4 logic operations (AND, OR, INV, identity)

module ALU_if_nested(
	input [2:0] s,  
	input a,b,
	output reg result
);
	always @ (a or b or s)
		begin
			 
			if (s == 3'b000) 
				result = a + b;		// add
			
			if (s == 3'b001) 
				result = a - b;		// sub

			if (s == 3'b010) 
				result = a + 1;		// incre

			if (s == 3'b011)
				result = a - 1;		// decre

			if (s == 3'b100) 
				result = a & b;		// and
			
			if (s == 3'b101) 
				result = a | b;		// or

			if (s == 3'b110) 
				result =  ~a 	;	// inv

			if (s == 3'b111)
				result = a ;		// identify
		end
endmodule