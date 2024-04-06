`timescale 1ns / 1ns

module tb_main;
    // Inputs
    reg clk;
    reg rst;
    reg mode_button;
    reg increase_button;
    reg decrease_button;

    // Outputs
    wire [13:0] FPGA_led12;
    wire [13:0] FPGA_led34;
    wire [13:0] FPGA_led56;
    wire [13:0] FPGA_led78;

    // Instantiate the Unit Under Test (UUT)
    main uut (
        .clk(clk), 
        .rst(rst), 
        .mode_button(mode_button),
        .increase_button(increase_button),
        .decrease_button(decrease_button),
        .FPGA_led12(FPGA_led12),
        .FPGA_led34(FPGA_led34),
        .FPGA_led56(FPGA_led56),
        .FPGA_led78(FPGA_led78)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        mode_button = 1;
        increase_button = 1;
        decrease_button = 1;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Deassert reset
        rst = 0;
        #100;

        rst = 1;
        #100;
        
        // Assert mode_button
        mode_button = 0;
        #100;
        
        // Deassert mode_button
        mode_button = 1;
        #100;
        
        // Assert increase_button
        increase_button = 0;
        #100;
        
        // Deassert increase_button
        increase_button = 1;
        #100;
        
        // Assert decrease_button
        decrease_button = 0;
        #100;
        
        // Deassert decrease_button
        decrease_button = 1;
        #100;
        
        // Assert mode_button
        mode_button = 0;
        #100;
        
        // Deassert mode_button
        mode_button = 1;
        #100;
        
        // Assert increase_button
        increase_button = 0;
        #100;
        
        // Deassert increase_button
        increase_button = 1;
        #100;
        
        // Assert decrease_button
        decrease_button = 0;
        #100;
        
        // Deassert decrease_button
        decrease_button = 1;
        #100;
        
        // Assert mode_button
        mode_button = 0;
        #100;
        
        // Deassert mode_button
        mode_button = 1;
        #100;
        
        // Assert increase_button
        increase_button = 0;
        #100;
        
        // Deassert increase_button
        increase_button = 1;
        #100;
        
        // Assert decrease_button
        decrease_button = 0;
        #100;
        
        // Deassert decrease_button
        decrease_button = 1;
        #100;

        #10000;

        $finish;
    end
      
    always #10 clk = ~clk;
endmodule
