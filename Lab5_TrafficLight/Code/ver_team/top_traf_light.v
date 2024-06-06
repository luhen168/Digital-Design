module top_traf_light(
  input clk, rst_n,
  input car,
  output [2:0] led1_hw,
  output [2:0] led1_n,
  output [13:0] led7_hw,
  output [13:0] led7_n
  );
  
  wire time_out;
  wire ena_hw;
  wire ena_n;
  wire [1:0] state_hw;
  wire [2:0] light_hw;
  
  hw_controller hw_contr(
  .clk(clk), 
  .rst_n(rst_n), 
  .car(car), 
  .time_out(time_out), 
  .ena_hw(ena_hw),
  .ena_n(ena_n), 
  .state_hw(state_hw),
  .light_hw(light_hw)
  );
  
  wire [1:0] state_n;
  wire [2:0] light_n;
  
  n_controller n_contr(
  .clk(clk),
  .rst_n(rst_n),
  .time_out(time_out),
  .ena_n(ena_n),
  .ena_hw(ena_hw),
  .state_n(state_n),
  .light_n(light_n)
  );
  
  led1_dis led1_hw_dis(
  .light(light_hw),
  .led1(led1_hw)
  );
  
  led1_dis led1_n_dis(
  .light(light_n),
  .led1(led1_n)
  );
  
  wire time_out_hw;
  wire time_out_n;
  wire [3:0]count_hw;
  wire [3:0]count_n;
  wire ena_count;
  
  count_controller count_contr(
  .clk(clk),
  .rst_n(rst_n),
  .state_hw(state_hw),
  .state_n(state_n),
  .time_out_hw(time_out_hw),
  .time_out_n(time_out_n),
  .count_hw(count_hw),
  .count_n(count_n),
  .time_out(time_out),
  .ena_count(ena_count)
  );
  
  wire [3:0] so_gma_hw;
  count count_hw_hw(
  .clk(clk),
  .rst_n(rst_n),
  .count(count_hw),
  .ena_count(ena_count),
  .led(so_gma_hw),
  .time_out(time_out_hw)
  );
  
  wire [3:0] so_gma_n;
  count count_n_n(
  .clk(clk),
  .rst_n(rst_n),
  .count(count_n),
  .ena_count(ena_count),
  .led(so_gma_n),
  .time_out(time_out_n)
  );
  
  giaima7thanh gm7t_hw(
  .so_gma(so_gma_hw),
  .sseg(led7_hw)
  );
  
  giaima7thanh gm7t_n(
  .so_gma(so_gma_n),
  .sseg(led7_n)
  );
  
endmodule
  
  
  
  
  
  
