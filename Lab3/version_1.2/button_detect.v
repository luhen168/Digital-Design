module button_detect(
    input clk,
    input rst,
    input increase_button,
    input decrease_button,
    output increase_signal,
    output decrease_signal
);

cnt_button_press increase_press (
    .clk(clk),
    .rst(rst),
    .button(increase_button),
    .signal(increase_signal)
);

cnt_button_press decrease_press (
    .clk(clk),
    .rst(rst),
    .button(decrease_button),
    .signal(decrease_signal)
);

endmodule 
