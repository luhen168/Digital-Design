module n_controller #(
  parameter [2:0] red_n = 3'b001,
  parameter [2:0] yellow_n = 3'b010,
  parameter [2:0] green_n = 3'b100
  )(
  input clk, 
  input rst_n,
  input ena_n,
  input time_out,
  output reg ena_hw,
  output reg [2:0] light_n,
  output reg [1:0] state_n);
  
  reg [2:0] current_state;
  reg [2:0] next_state;
  
  always@ (current_state, next_state, ena_hw, time_out) begin
    next_state = current_state;
    ena_hw = 0;
	 
    case(current_state)
      green_n: begin
		  state_n = 2'b01;
		  light_n = green_n;
        if (time_out == 1) begin
          next_state = yellow_n;
        end
		  end
      yellow_n: begin
		  state_n = 2'b10;
		  light_n = yellow_n;
        if (time_out == 1) begin
          next_state = red_n;
          ena_hw = 1;
        end
		  end
      red_n: begin
		  state_n = 2'b00;
		  light_n = red_n;
        if (ena_n == 1) begin
          next_state = green_n;
        end
		  end
    endcase
  end
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      current_state <= red_n;
    else
      current_state <= next_state;
  end
endmodule