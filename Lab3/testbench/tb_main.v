`timescale 1ns / 1ns

module main_tb;
    reg clk;
    reg rst;
    reg mode_button;
    reg increase_button;
    reg decrease_button;
    reg display_switch;
    wire [13:0] FPGA_led_12;
    wire [13:0] FPGA_led_34;
    wire [13:0] FPGA_led_56;
    wire [13:0] FPGA_led_78;
    wire [13:0] FPGA_led_s, FPGA_led_mi, FPGA_led_h;

    // Instantiate the Unit Under Test (UUT)
    main uut (
        .clk(clk), 
        .rst(rst), 
        .mode_button(mode_button),
        .increase_button(increase_button),
        .decrease_button(decrease_button),
        .display_switch(display_switch),
        .FPGA_led_12(FPGA_led_12),
        .FPGA_led_34(FPGA_led_34),
        .FPGA_led_56(FPGA_led_56),
        .FPGA_led_78(FPGA_led_78),

        .FPGA_led_s(FPGA_led_s),
        .FPGA_led_mi(FPGA_led_mi),
        .FPGA_led_h(FPGA_led_h)
    );

    initial begin
        clk = 0;
        rst = 1;
        #100 rst = 0;

        // Initialize Inputs
        mode_button = 0;
        increase_button = 0;
        decrease_button = 0;
        display_switch = 0;

        // Wait for 100 ns for global reset to finish
        #100;
        
        // De-assert reset
        rst = 1;
        #100;
        
        // First 10000ns: mode_button = 0, increase and decrease varies
        mode_button = 0;
        repeat(100) begin
            #100;
            increase_button = ~increase_button;
            decrease_button = ~decrease_button;
        end

        // Next 10000ns: mode_button = 1, increase and decrease varies
        mode_button = 1;
        repeat(100) begin
            #100;
            increase_button = ~increase_button;
            decrease_button = ~decrease_button;
        end

        // End simulation
        $finish;
    end
      
    // Clock generator
    always #10 clk = ~clk;
    
endmodule
