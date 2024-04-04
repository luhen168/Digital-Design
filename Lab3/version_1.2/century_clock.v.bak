// Top Module
module century_clock (
    input clk,
    input rst,
    input display_switch,                                           // use switch to control
    input mode_button, increase_button, decrease_button,            // use button to control
    output [7:0] FPGA_led_1, FPGA_led_2, FPGA_led_3, FPGA_led_4, FPGA_led_5, FPGA_led_6, FPGA_led_7, FPGA_led_8      
);

    wire enable_pulse_1s;
    wire [5:0] increase_signal, decrease_signal;
    wire [5:0] enable_display, enable_cnt;

    button_detect button_detect (
        .clk(clk),
        .rst(rst),
        .increase_button(increase_button),
        .decrease_button(decrease_button),
        .increase_signal(increase_signal),
        .decrease_signal(decrease_signal)
    );

    fsm fsm(
        .clk(clk),
        .rst(rst),
        .mode_button(mode_button),
        .enable_display(enable_display),
        .enable_cnt(enable_cnt),
        .enable_pulse_1s(enable_pulse_1s)
    );

    control control(
        .clk(clk),
        .rst(rst),
        .enable_pulse_1s(enable_pulse_1s), 
        .display_switch(display_switch),
        .increase_signal(increase_signal),
        .decrease_signal(decrease_signal),
        .enable_display(enable_display),
        .enable_cnt(enable_cnt),
        .enable_pulse_1s(enable_pulse_1s),
        .FPGA_led_1(FPGA_led_1), 
        .FPGA_led_2(FPGA_led_2), 
        .FPGA_led_3(FPGA_led_3), 
        .FPGA_led_4(FPGA_led_4), 
        .FPGA_led_5(FPGA_led_5), 
        .FPGA_led_6(FPGA_led_6), 
        .FPGA_led_7(FPGA_led_7), 
        .FPGA_led_8(FPGA_led_8)
    );
endmodule    
   