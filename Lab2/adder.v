module adder(
	input [3:0] a, b,
	output [3:0] s,
	output co
);

	assign {co,s}	= a+b;
endmodule 

`timescale 1ns/1ps 
module testbench_adder();
	
	reg [3:0] stim_a,stim_b;
	wire [3:0] mon_s;
	wire mon_co;
	// dat module can kiem tra vao testbench
	adder adder_duv(
		.a(stim_a),
		.b(stim_b),
		.s(mon_s),
		.co(mon_co)
	);
	// sinh cac tin hieu dau vao
	initial 
	begin
		stim_a = 0;
		stim_b = 1;
		#5;
		stim_a = 10;
		stim_b = 15;
	end 
	
	// quan sat dau ra
	initial 
	begin	
		$monitor("Time = %t, a = %d, b = %d, s=%d, co=%d\n",
			$time, stim_a, stim_b, mon_s, mon_co);
	end 
endmodule 