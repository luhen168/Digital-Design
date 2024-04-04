`timescale 1ns / 1ps

module tb_main;
    reg clk;
    reg rst;
    reg enable_pulse_1s;
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
        #100;
        
        // Change enable to 1
        enable_pulse_1s = 1;
        #100;
        
        // End simulation
        $finish;
    end
      
    // Clock generator
    always #10 clk = ~clk;
    
endmodule
