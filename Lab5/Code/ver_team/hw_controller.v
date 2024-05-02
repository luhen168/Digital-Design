module hw_controller #(
  parameter [2:0] red_h = 3'b001,
  parameter [2:0] yellow_h = 3'b010,
  parameter [2:0] green_h = 3'b100
  )(
  input clk, 
  input rst_n,
  input car, 
  input ena_hw,
  input time_out,
  output reg ena_n,
  output reg [2:0] light_hw,
  output reg [1:0] state_hw);
  
  reg [2:0] current_state;
  reg [2:0] next_state;
  
  always@ (current_state, next_state, ena_hw, car, time_out) begin
    next_state = current_state;
    ena_n = 0;
	 
    case(current_state)
      green_h: begin
		  state_hw = 2'b01;
		  light_hw = green_h;
        if (time_out == 1) begin
          next_state = yellow_h;
        end
		  end
      yellow_h: begin
		  state_hw = 2'b10;
		  light_hw = yellow_h;
        if (time_out == 1) begin
          next_state = red_h;
          ena_n = 1;
        end
		  end
      red_h: begin
		  state_hw = 2'b00;
		  light_hw = red_h;
        if (ena_hw == 1) begin
          next_state = green_h;
        end
		  end
      default: begin
		  state_hw = 2'b11;
		  light_hw = green_h;
        if (car == 1) begin
          next_state = green_h;
		  end
		  end
    endcase
  end
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      current_state <= 3'b000;
    else
      current_state <= next_state;
  end
endmodule