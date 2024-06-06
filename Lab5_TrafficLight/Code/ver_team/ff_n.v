module ff_n(
  input clk, rst_n,
  input [1:0] state_n,
  output reg [1:0] q
);

always@(posedge clk or negedge rst_n)
  begin 
    if(~rst_n)
        q <= 2'b00;
    else
        q <= state_n;
end

endmodule


