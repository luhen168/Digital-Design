module fsm_state_handler(
    input [3:0] state,
    output reg [5:0] enable_display,
    output reg [5:0] enable_cnt,
    output reg enable_pulse_1s
);
    parameter NORMAL = 000;
    parameter SS = 001;
    parameter MI = 010;
    parameter HH = 011;
    parameter DD = 100;
    parameter MO = 101;
    parameter YY = 110;

    always@(state)
    begin
       if(state == NORMAL) begin
          enable_display <= 6'b111111;
          enable_cnt <= 6'b111111;
          enable_pulse_1s <= 1'b1;
         end
        else if(state == SS) begin
          enable_display <= 6'b000001;
          enable_cnt <= 6'b000001;
          enable_pulse_1s <= 0;  
         end   
        else if(state == MI) begin
          enable_display <= 6'b000010;
          enable_cnt <= 6'b000010;
          enable_pulse_1s = 0;
         end
        else if(state == HH) begin
          enable_display <= 6'b000100;
          enable_cnt <= 6'b000100;
          enable_pulse_1s <= 0;
         end
        else if(state == DD) begin
          enable_display <= 6'b100000;
          enable_cnt <= 6'b100000;
          enable_pulse_1s <= 0;
         end
        else if(state == MO) begin
          enable_display <= 6'b010000;
          enable_cnt <= 6'b010000;
          enable_pulse_1s <= 0;
         end
        else if(state == YY) begin
          enable_display <= 6'b001000;
          enable_cnt <= 6'b001000;
          enable_pulse_1s <= 0;
         end
    end 
endmodule

