module traffic_light (
    input clk,
    input rst,
    input sw,
    output [13:0]FPGA_led7seg_12,
    output [13:0]FPGA_led7seg_56,
    output [5:0]FPGA_led
);

    wire enable_pulse_1s;
    wire pulse_1s;
    wire [2:0] cnt_pd, cnt_nopd;
    wire cnt_pd_end, cnt_nopd_end;
    wire [5:0] display_pd, display_nopd;


    pulse_1s counter1 (
        .clk(clk),
        .rst(rst),
        .enable_pulse_1s(enable_pulse_1s),
        .pulse_1s(pulse_1s)
    );

    counterdown counter2 (
        .clk(clk),
        .rst(rst),
        .pulse_1s(pulse_1s),
        .cnt_pd(cnt_pd), 
	    .cnt_nopd(cnt_nopd), 
        .cnt_pd_end(cnt_pd_end),
        .cnt_nopd_end(cnt_nopd_end), 
        .display_pd(display_pd), 
        .display_nopd(display_nopd)
    );

    fsm controller (
        .clk(clk), 
        .rst(rst),
        .cnt_pd_end(cnt_pd_end),
        .cnt_nopd_end(cnt_nopd_end),
        .FPGA_led(FPGA_led),
        .cnt_nopd(cnt_nopd), 
        .cnt_pd(cnt_pd),
        .enable_pulse_1s(enable_pulse_1s)
    );

    display display (
        .clk(clk),
        .rst(rst),
        .display_pd(display_pd),
        .display_nopd(display_nopd),
        .FPGA_led7seg_12(FPGA_led7seg_12),
        .FPGA_led7seg_56(FPGA_led7seg_56)
    );
endmodule