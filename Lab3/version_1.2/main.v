module main (
    input clk, rst,
    input enable_pulse_1s,
    output reg pulse_1s
);
    
    pulse_1s uut (
        .clk(clk), 
        .enable_pulse_1s(enable_pulse_1s), 
        .rst(rst), 
        .pulse_1s(pulse_1s)
    );

endmodule