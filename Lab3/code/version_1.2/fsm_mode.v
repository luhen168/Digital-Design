module fsm_mode(
    input clk,
    input rst,
    input mode_button,
    output reg [2:0] state
);
    
    // reg [2:0] state_next = NORMAL;

    localparam NORMAL = 3'b000;
    localparam SS = 3'b001;
    localparam MI = 3'b010;
    localparam HH = 3'b011;
    localparam DD = 3'b100;
    localparam MO = 3'b101;
    localparam YY = 3'b110;

    always @(negedge rst or negedge mode_button) begin
        if (~rst)
            state <= NORMAL;
        else begin
            case(state)
                NORMAL: 
                    state = SS;
                SS: 
                    state = MI;
                MI: 
                    state = HH;
                HH: 
                    state = DD;
                DD:
                    state = MO;
                MO: 
                    state = YY;
                YY: 
                    state = NORMAL;
                default: 
                    state = NORMAL;
            endcase
        end
    end 
endmodule
    // always @(negedge mode_button) begin 
    // // always @(mode_button or state) begin 
    //         state_next = NORMAL;
    //         case(state)
    //             NORMAL: state_next = SS;
    //             SS: state_next = MI;
    //             MI: state_next = HH;
    //             HH: state_next = DD;
    //             DD: state_next = MO;
    //             MO: state_next = YY;
    //             YY: state_next = NORMAL;
    //             default: state_next = NORMAL;
    //         endcase
    // end 


    // always@(posedge clk or negedge rst) begin 
    //     if(~rst)
    //        state <= NORMAL;
    //     else 
    //        state <= state_next; 
    // end  
// endmodule
