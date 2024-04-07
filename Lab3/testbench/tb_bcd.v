`timescale 1ns / 1ps

module bcd_tb;
    reg clk;
    reg rst;
    reg enable_display;
    reg [6:0] cnt;
    wire [7:0] led_out;

    // Instantiate the Unit Under Test (UUT)
    bcd uut (
        .enable_display(enable_display),
        .cnt(cnt),
        .led_out(led_out)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        enable_display = 0;
        cnt = 0;

        // Wait for 100 ns for global reset to finish
        #100;
        
        // De-assert reset
        rst = 1;
        #100;
        
        // First 10000ns: enable_display = 0, cnt varies
        enable_display = 1;
        repeat(100) begin
            #100;
            cnt = cnt + 1;
        end

        // End simulation
        $finish;
    end
      
    // Clock generator
    always #10 clk = ~clk;
    
endmodule
