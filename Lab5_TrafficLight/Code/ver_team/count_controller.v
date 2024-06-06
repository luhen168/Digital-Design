module count_controller(
  input clk, rst_n,
  input [1:0] state_hw,
  input [1:0] state_n,
  input time_out_hw,
  input time_out_n,
  output reg [3:0] count_hw,
  output reg [3:0] count_n,
  output reg time_out,
  output  reg ena_count
  );
  
  always@(time_out_hw or time_out_n)
    begin
      time_out = time_out_hw|time_out_n ;
    end
    
  always@(state_n)
    begin
      case(state_n)
          2'b00: count_n = 4'b1010;
          2'b01: count_n = 4'b1000;
          2'b10: count_n = 4'b0010;
        endcase
    end
  
  always@(state_hw)
    begin
      case(state_hw)
          2'b00: count_hw = 4'b1010;
          2'b01: count_hw = 4'b1000;
          2'b10: count_hw = 4'b0010;
          default: count_hw = 4'b0000;
        endcase
    end
    
  wire [1:0] q_hw;
  reg ena_count_hw;
  ff_hw ff_inst(
  .clk(clk),
  .rst_n(rst_n),
  .q(q_hw),
  .state_hw(state_hw)
  );
  
  always@(q_hw or state_hw)
    begin
      if(state_hw != q_hw)
        ena_count_hw = 1'b1;
    else
        ena_count_hw = 1'b0;
  end
  
  wire [1:0] q_n;
  reg ena_count_n;
  ff_n ff_inst_n(
  .clk(clk),
  .rst_n(rst_n),
  .q(q_n),
  .state_n(state_n)
  );
  
  always@(q_n or state_n)
    begin
      if(state_n != q_n)
        ena_count_n = 1'b1;
    else
        ena_count_n = 1'b0;
  end
  
    
always@(ena_count_hw or ena_count_n)
  begin
    ena_count = ena_count_hw | ena_count_n;
  end

endmodule
    
