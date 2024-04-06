module main (
    input clk, rst,
    input mode_button, increase_button, decrease_button,
    input display_switch,
    //input enable_pulse_1s,

    // input enable_cnt_s,
    // input increase_s, decrease_s,
    // output [5:0] cnt_s,
    // output pulse_1mi,

    // input enable_cnt_mi,
    // input increase_mi, decrease_mi,
    // output [5:0] cnt_mi,
    // output pulse_1h,

    // input enable_cnt_h,
    // input increase_h, decrease_h,
    // output [5:0] cnt_h,
    // output pulse_1d,

    // input enable_cnt_d,
    // input increase_d, decrease_d,
    // input [6:0] cnt_y_ten_unit, cnt_mo,
    // output [5:0] day_total_in_mo,
    // output [5:0] cnt_d,
    // output pulse_1mo,

    output [13:0] FPGA_led_12,
    output [13:0] FPGA_led_34,
    output [13:0] FPGA_led_56,
    output [13:0] FPGA_led_78
);
    wire [5:0] enable_display;
    wire [5:0] enable_cnt;
    wire enable_pulse_1s;
    wire [2:0] state;
    
    wire pulse_1s, pulse_1mi, pulse_1h;
    wire [5:0] cnt_s, cnt_mi, cnt_h;
    wire [13:0] FPGA_led_s, FPGA_led_mi, FPGA_led_h;

    wire increase_signal, decrease_signal;
    button_detect inst_button_detect (
        .clk(clk),
        .rst(rst),
        .increase_button(increase_button),
        .decrease_button(decrease_button),
        .increase_signal(increase_signal),
        .decrease_signal(decrease_signal)
    );

    pulse_1s inst_pulse_1s (
        .clk(clk), 
        .enable_pulse_1s(enable_pulse_1s), 
        .rst(rst), 
        .pulse_1s(pulse_1s)
    );

    cnt_s inst_cnt_s (
        .clk(clk), 
        .rst(rst), 
        .pulse_1s(pulse_1s),
        .increase_s(increase_button),
        .decrease_s(decrease_button),
        .enable_cnt_s(enable_cnt[0]),
        .cnt_s(cnt_s),
        .pulse_1mi(pulse_1mi)
    );

    cnt_mi inst_cnt_mi (
        .clk(clk), 
        .rst(rst), 
        .pulse_1mi(pulse_1mi),
        .increase_mi(increase_button),
        .decrease_mi(decrease_button),
        .enable_cnt_mi(enable_cnt[1]),
        .cnt_mi(cnt_mi),
        .pulse_1h(pulse_1h)
    );

    cnt_h inst_cnt_h (
        .clk(clk), 
        .rst(rst), 
        .pulse_1h(pulse_1h),
        .increase_h(increase_button),
        .decrease_h(decrease_button),
        .enable_cnt_h(enable_cnt[2]),
        .cnt_h(cnt_h),
        .pulse_1d(pulse_1d)
    );

    cnt_d inst_cnt_d (
        .clk(clk), 
        .rst(rst), 
        .pulse_1d(pulse_1d), 
        .increase_d(increase_d), 
        .decrease_d(decrease_d), 
        .enable_cnt_d(enable_cnt_d), 
        .cnt_y_ten_unit(cnt_y_ten_unit), 
        .cnt_mo(cnt_mo), 
        .cnt_d(cnt_d), 
        .pulse_1mo(pulse_1mo), 
        .day_total_in_mo(day_total_in_mo)
    );
    
    led_s inst_led_s (
        .enable_display(enable_display[0]),
        .cnt_s({1'b0, cnt_s}),
        .led_s(FPGA_led_s)
    );

    led_mi inst_led_mi (
        .enable_display(enable_display[1]),
        .cnt_mi({1'b0, cnt_mi}),
        .led_mi(FPGA_led_mi)
    );

    led_h inst_led_h (
        .enable_display(enable_display[2]),
        .cnt_h({1'b0, cnt_h}),
        .led_h(FPGA_led_h)
    );

    control_display_switch inst_control_display_switch (
        .display_switch(display_switch),
        .led_h(FPGA_led_h),
        .led_mi(FPGA_led_mi),
        .led_s(FPGA_led_s),

        .FPGA_led_12(FPGA_led_12),
        .FPGA_led_34(FPGA_led_34),
        .FPGA_led_56(FPGA_led_56),
        .FPGA_led_78(FPGA_led_78)
    );
    
    fsm_mode inst_fsm_mode (
        .clk(clk),
        .rst(rst),
        .mode_button(mode_button),
        .state(state)
    );

    fsm_state_handler inst_fsm_state_handler (
        .state(state),
        .enable_display(enable_display),
        .enable_cnt(enable_cnt),
        .enable_pulse_1s(enable_pulse_1s)
    );
endmodule