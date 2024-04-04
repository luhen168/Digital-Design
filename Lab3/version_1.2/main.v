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
    output pulse_1h
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

endmodule