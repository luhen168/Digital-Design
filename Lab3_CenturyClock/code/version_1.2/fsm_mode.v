module fsm_mode(
    input clk,
    input rst,
    input mode_button,
	input display_switch,
    output reg [2:0] state
);
    
    reg [2:0] next_state = NORMAL;

    localparam NORMAL = 3'b000;
    localparam SS = 3'b001;
    localparam MI = 3'b010;
    localparam HH = 3'b011;
    localparam DD = 3'b100;
    localparam MO = 3'b101;
    localparam YY = 3'b110;
    localparam YY2 = 3'b111;

    always @(negedge mode_button or negedge rst) begin
        if (~rst)
            next_state <= NORMAL;
        else begin 
            case(state)
                NORMAL: 
                    if(display_switch == 0) next_state <= SS;
                    else next_state <= DD;
                SS: next_state <= MI;
                MI: next_state <= HH;
                HH: next_state <= NORMAL;

                DD: next_state <= MO;
                MO: next_state <= YY;
                YY: next_state <= YY2;
                YY2: next_state <= NORMAL;
                    
                default: next_state <= NORMAL;
            endcase
        end
	end

    always @(posedge clk) begin
        if(display_switch == 1) begin 
            if (state == SS || state == MI || state == HH) state <= NORMAL;
            else state <= next_state; 
        end else begin
            if (state == DD || state == MO || state == YY || state == YY2) state <= NORMAL;
            else state <= next_state;     
        end
    end
endmodule

