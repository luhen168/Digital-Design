module fsm (
    input sw,
    input clk, 
    input rst,
    output led[5:0],
    output start_pd, start_nopd;
);

    localparam state_idle = 3'b000;
    localparam go_pd = 3'b001;
    localparam wait_pd = 3'b010;
    localparam go_nopd = 3'b011;
    localparam wait_nopd = 3'b100;

    reg[2:0] state, next_state;

    always @(sw,state,finish) begin
        led[5:0] = 6'b000100;
        next_state = state_idle;
        case(state)
            state_idle: 
                if (sw = 1) begin
                    next_state = go_pd;
                    led[5:0] = 6'001100;  // green-yellow-red| green-yellow-red
                end
            go_pd: 
                if (sw = 1&&) begin
                    next_state = wait_pd;
                    led[5:0] = 6'001010;  
                end
            wait_pd: 
                if (sw = 1&&) begin
                    next_state = go_nopd;
                    led[5:0] = 6'100001;
                end
            go_nopd: 
                if (sw = 1&&) begin
                    next_state = wait_nopd;
                    led[5:0] = 6'010001;
                end
            wait_nopd: 
                if (sw = 1&&) begin
                    next_state = go_pd;
                    led[5:0] = 6'001100;
                end            
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        // Trong khoi always co' clk mo ta mach FF thi' dung' gan non-blocking <=
        if (~rst_n) begin 
                state <= state_idle;
            end
            else begin 
                state <= nextstate;
            end
    end

endmodule 
