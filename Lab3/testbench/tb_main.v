`timescale 1ns / 1ns

module main_tb;
    reg clk;
    reg rst;
    reg enable_pulse_1s;
    reg increase_s;
    reg decrease_s;
    reg enable_cnt_s;
    wire [5:0] cnt_s;
    wire pulse_1mi;

    // Instantiate the Unit Under Test (UUT)
    main uut (
        .clk(clk), 
        .rst(rst), 
        .enable_pulse_1s(enable_pulse_1s),
        .increase_s(increase_s),
        .decrease_s(decrease_s),
        .enable_cnt_s(enable_cnt_s),
        .cnt_s(cnt_s),
        .pulse_1mi(pulse_1mi)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        enable_pulse_1s = 1;
        increase_s = 0;
        decrease_s = 0;
        enable_cnt_s = 0;

        // Wait for 100 ns for global reset to finish
        #100;
        
        // De-assert reset
        rst = 1;
        #100;
        
        // First 1000ns: enable = 0, increase and decrease varies
        enable_cnt_s = 0;
        increase_s = 1;
        decrease_s = 0;
        repeat(10) begin
            #100;
            increase_s = ~increase_s;
            decrease_s = ~decrease_s;
        end

        // Next 1000ns: enable = 1, increase and decrease varies
        enable_cnt_s = 1;
        repeat(10) begin
            #100;
            increase_s = ~increase_s;
            decrease_s = ~decrease_s;
        end
    end
      
    // Clock generator
    always #10 clk = ~clk;
    
endmodule
