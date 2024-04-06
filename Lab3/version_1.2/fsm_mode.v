module fsm_mode(
    input clk,
    input rst,
    input mode_button,
    output reg [2:0] state
);
    

    localparam NORMAL = 3'b000;
    localparam SS = 3'b001;
    localparam MI = 3'b010;
    localparam HH = 3'b011;
    localparam DD = 3'b100;
    localparam MO = 3'b101;
    localparam YY = 3'b110;

    reg [2:0] state_next = NORMAL;

    always @(negedge mode_button) begin
        case(state)
            NORMAL: 
                state_next = SS;
            SS: 
                state_next = MI;
            MI: 
                state_next = HH;
            HH: 
                state_next = DD;
            DD:
                state_next = MO;
            MO: 
                state_next = YY;
            YY: 
                state_next = NORMAL;
            default: 
                state_next = NORMAL;
        endcase
    end 


    always@(posedge clk or negedge rst) begin 
        if(~rst) begin
          state <= NORMAL;
        end
        else 
          state <= state_next; 
    end  
endmodule
