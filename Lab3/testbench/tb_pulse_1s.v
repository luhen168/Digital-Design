`timescale 1ns / 1ps

module pulse_1s_tb;
    reg clk;
    reg enable_pulse_1s;
    reg rst;
    wire pulse_1s;

    // Instantiate the Unit Under Test (UUT)
    pulse_1s uut (
        .clk(clk), 
        .enable_pulse_1s(enable_pulse_1s), 
        .rst(rst), 
        .pulse_1s(pulse_1s)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        enable_pulse_1s = 0;
        rst = 0;

        // Wait for 100 ns for global reset to finish
        #100;
        
        // De-assert reset
        rst = 1;
        enable_pulse_1s = 1;

        // Wait for 100 ns for system to stable
        #100;
        
        // Stimulus
        while(1) begin
            #10 clk = ~clk;  // Toggle clock every 10 ns
        end
    end

    initial begin
        $monitor("At time %dns, pulse_1s = %b", $time, pulse_1s);
    end
endmodule
