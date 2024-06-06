module fsm (
    input sw,
    input clk, 
    input rst,
    input cnt_pd_end, cnt_nopd_end,
    output [5:0] FPGA_led,
    output [2:0] cnt_nopd, cnt_pd,
    output enable_pulse_1s
);

    localparam state_idle = 3'b000;
    localparam go_pd = 3'b001;
    localparam wait_pd = 3'b010;
    localparam go_nopd = 3'b011;
    localparam wait_nopd = 3'b100;

    reg[2:0] state, next_state;

    always @(sw,state,finish) begin
        FPGA_led = 6'b000100;
        next_state = state_idle;
        enable_pulse_1s = 0;
        // cnt_nopd = 0;
        // cnt_pd = 0; 
        case(state)
            state_idle: 
                if (sw == 1) begin
                    next_state = go_pd;
                    FPGA_led = 6'b001100;  // green-yellow-red| green-yellow-red
                    enable_pulse_1s = 1;
                    cnt_pd = 8;
                    cnt_nopd = 10;
                end
            go_pd: 
                if (sw == 1&cnt_pd_end) begin
                    next_state = wait_pd;
                    FPGA_led = 6'b001010;
                    cnt_pd = 2;
                end
            wait_pd: 
                if (sw == 1&cnt_pd_end) begin
                    next_state = go_nopd;
                    FPGA_led = 6'b100001;
                    cnt_pd = 10;
                    cnt_nopd = 8; 
                end
            go_nopd: 
                if (sw == 1&cnt_nopd_end) begin
                    next_state = wait_nopd;
                    FPGA_led = 6'b010001;
                    cnt_nopd = 2; 
                end
            wait_nopd: 
                if (sw == 1&cnt_nopd_end) begin
                    next_state = go_pd;
                    FPGA_led = 6'b001100;
                    cnt_pd = 8;
                    cnt_nopd = 10;  
                end  
            default: next_state = state_idle;         
        endcase
    end

    always @(posedge clk or negedge rst) begin
        // Trong khoi always co' clk mo ta mach FF thi' dung' gan non-blocking <=
        if (~rst) begin 
                state <= state_idle;
            end
            else begin 
                state <= next_state;
            end
    end
endmodule 
