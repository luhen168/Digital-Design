// Top Module
module century_clock (
    input clk,
    input rst,
    input display_switch,                                           // use switch to control
    input mode_button, increase_button, decrease_button,            // use button to control
    output [13:0] FPGA_led_12, FPGA_led_34, FPGA_led_56, FPGA_led_78      
);

    wire enable_pulse_1s;
    wire [5:0] increase_signal, decrease_signal;
    wire [5:0] enable_display, enable_cnt;

    button_detect inst_button_detect (
        .clk(clk),
        .rst(rst),
        .increase_button(increase_button),
        .decrease_button(decrease_button),
        .increase_signal(increase_signal),
        .decrease_signal(decrease_signal)
    );

    fsm inst_fsm(
        .clk(clk),
        .rst(rst),
        .mode_button(mode_button),
        .enable_display(enable_display),
        .enable_cnt(enable_cnt),
        .enable_pulse_1s(enable_pulse_1s)
    );

    control inst_control(
        .clk(clk),
        .rst(rst),
        .enable_pulse_1s(enable_pulse_1s), 
        .display_switch(display_switch),
        .increase_signal(increase_signal),
        .decrease_signal(decrease_signal),
        .enable_display(enable_display),
        .enable_cnt(enable_cnt),
        .FPGA_led_12(FPGA_led_12),
        .FPGA_led_34(FPGA_led_34), 
        .FPGA_led_56(FPGA_led_56), 
        .FPGA_led_78(FPGA_led_78)
    );
endmodule    
   