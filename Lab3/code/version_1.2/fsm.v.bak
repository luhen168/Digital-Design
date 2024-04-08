module fsm (
    input clk,
    input rst,
    input mode_button,
    output [5:0] enable_display,
    output [5:0] enable_cnt,
    output enable_pulse_1s
);

    wire [2:0] state;

    fsm_mode fsm_mode (
        .clk(clk),
        .rst(rst),
        .mode_button(mode_button),    
        .state(state)
    );

    fsm_state_handler fsm_state_handler (
        .state(state),
        .enable_display(enable_display),
        .enable_cnt(enable_cnt),
        .enable_pulse_1s(enable_pulse_1s)
    );
endmodule 





