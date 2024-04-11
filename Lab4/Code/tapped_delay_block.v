module tapped_delay_block #(parameter N = 16) (
    input  clk,
    input  rst,
    input  ena,
    input  [N-1:0] b,     // coefficients
    input  [N-1:0] x_in,  // input to the delay block
    input  [N-1:0] y_in,  // signal to add to x_in after arithmetic operations
    output [N-1:0] x_out, // delayed x_in 
    output [N-1:0] y_out // signal after arithmetic operations (combinationally driven)
);

reg [N-1:0] x_reg;

always @(posedge clk or negedge rst) begin
    if (~rst)
        x_reg <= 0;
    else if (ena)
        x_reg <= x_in;
end

assign x_out = x_reg;
assign y_out = (x_in * b) + y_in;  // combinational logic where x_in is multiplied by coefficient and added to y_in

endmodule
