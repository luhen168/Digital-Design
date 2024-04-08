module fsm_mode(
    input clk,
    input rst,
    input mode_button,
	 input display_switch,
    output reg [2:0] state
);
    
    // reg [2:0] state_next = NORMAL;
	 reg pre_mode_button ;

    localparam NORMAL = 3'b000;
    localparam SS = 3'b001;
    localparam MI = 3'b010;
    localparam HH = 3'b011;
    localparam DD = 3'b100;
    localparam MO = 3'b101;
    localparam YY = 3'b110;
    localparam YY2 = 3'b111;

    always @(posedge clk  or negedge rst) begin
        if (~rst)
            state <= NORMAL;
        else begin
			if(mode_button != pre_mode_button) begin 
				pre_mode_button <= mode_button;
            if(display_switch == 0 && mode_button == 0) begin
                case(state)
                    NORMAL: 
                        state <= SS;
                    SS: 
                        state <= MI;
                    MI: 
                        state <= HH;
                    HH: 
                        state <= NORMAL;
                    default: 
                        state <= NORMAL;
                endcase  
            end else if(display_switch == 1 && mode_button == 0) begin
                case(state)
                    NORMAL: 
                        state <= DD;
                    DD:
                        state <= MO;
                    MO: 
                        state <= YY;
                    YY: 
                        state <= YY2;
                    YY2:
                        state <= NORMAL;
                    default: 
                        state <= NORMAL;
                endcase
            end
			end
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
