module led1_dis(
  input [2:0] light,
  output reg[2:0] led1
  );
  
  always@(light)
    begin
     led1 = light;   
    end
    
endmodule 
