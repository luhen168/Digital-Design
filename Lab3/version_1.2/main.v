module main (
    input clk, rst,
    input enable_pulse_1s,

    input enable_cnt_s,
    input increase_s, decrease_s,
    output [5:0] cnt_s,
    output pulse_1mi,

    input enable_cnt_mi,
    input increase_mi, decrease_mi,
    output [5:0] cnt_mi,
    output pulse_1h,

    input enable_cnt_h,
    input increase_h, decrease_h,
    output [5:0] cnt_h,
    output pulse_1d,

    input enable_cnt_d,
    input increase_d, decrease_d,
    input [6:0] cnt_y_ten_unit, cnt_mo,
    output [5:0] day_total_in_mo,
    output [5:0] cnt_d,
    output pulse_1mo,

    output [13:0] FPGA_led12,
    output [13:0] FPGA_led34,
    output [13:0] FPGA_led56,
    output [13:0] FPGA_led78
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
        .increase_s(increase_s),
        .decrease_s(decrease_s),
        .enable_cnt_s(enable_cnt_s),
        .cnt_s(cnt_s),
        .pulse_1mi(pulse_1mi)
    );

    cnt_mi inst_cnt_mi (
        .clk(clk), 
        .rst(rst), 
        .pulse_1mi(pulse_1mi),
        .increase_mi(increase_mi),
        .decrease_mi(decrease_mi),
        .enable_cnt_mi(enable_cnt_mi),
        .cnt_mi(cnt_mi),
        .pulse_1h(pulse_1h)
    );

    cnt_h inst_cnt_h (
        .clk(clk), 
        .rst(rst), 
        .pulse_1h(pulse_1h),
        .increase_h(increase_h),
        .decrease_h(decrease_h),
        .enable_cnt_h(enable_cnt_h),
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

    wire [5:0] enable_display = 6'b111111;
    led_s inst_led_s (
        .enable_display(enable_display[0]),
        .cnt_s({1'b0, cnt_s}),
        .led_s(FPGA_led56)
    );

    led_mi inst_led_mi (
        .enable_display(enable_display[1]),
        .cnt_mi({1'b0, cnt_mi}),
        .led_mi(FPGA_led34)
    );

    led_h inst_led_h (
        .enable_display(enable_display[2]),
        .cnt_h({1'b0, cnt_h}),
        .led_h(FPGA_led12)
    );
    
endmodule