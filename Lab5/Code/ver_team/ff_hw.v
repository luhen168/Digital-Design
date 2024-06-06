module ff_hw(
  input clk, rst_n,
  input state_hw,
  output reg [1:0] q
);

always@(posedge clk or negedge rst_n)
  begin 
    if(~rst_n)
        q <= 2'b00;
    else
        q <= state_hw;
end

endmodule
