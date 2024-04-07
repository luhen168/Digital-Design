module fsm_state_handler(
    input [2:0] state,
    output reg [6:0] enable_display,
    output reg [6:0] enable_cnt,
    output reg enable_pulse_1s
);
    localparam NORMAL = 3'b000;
    localparam SS = 3'b001;
    localparam MI = 3'b010;
    localparam HH = 3'b011;
    localparam DD = 3'b100;
    localparam MO = 3'b101;
    localparam YY = 3'b110;
    localparam YY2 = 3'b111;

    always@(state) begin
       if(state == NORMAL) begin
          enable_display = 7'b1111111;
          enable_cnt = 7'b1111111;
          enable_pulse_1s = 1'b1;
         end
        else if(state == SS) begin
          enable_display = 7'b0000001;
          enable_cnt = 7'b0000001;
          enable_pulse_1s = 1'b0;  
         end   
        else if(state == MI) begin
          enable_display = 7'b0000010;
          enable_cnt = 7'b0000010;
          enable_pulse_1s = 1'b0;
         end
        else if(state == HH) begin
          enable_display = 7'b0000100;
          enable_cnt = 7'b0000100;
          enable_pulse_1s = 1'b0;
         end
        else if(state == DD) begin
          enable_display = 7'b1000000;
          enable_cnt = 7'b1000000;
          enable_pulse_1s = 1'b0;
         end
        else if(state == MO) begin
          enable_display = 7'b0100000;
          enable_cnt = 7'b0100000;
          enable_pulse_1s = 1'b0;
         end
        else if(state == YY) begin
          enable_display = 7'b0010000;
          enable_cnt = 7'b0010000;
          enable_pulse_1s = 1'b0;
        end
        else if(state == YY2) begin
          enable_display = 7'b0001000;
          enable_cnt = 7'b0001000;
          enable_pulse_1s = 1'b0;
        end
    end 
endmodule

