module tb_century_clock;
    reg clk;
    reg rst;
    reg display_switch;                                           // use switch to control
    reg mode_button, increase_button, decrease_button;            // use button to control

    wire [13:0] FPGA_led_12, FPGA_led_34, FPGA_led_56, FPGA_led_78; 

    century_clock inst_century_clock (
        .clk(clk),
        .rst(rst),
        .display_switch(display_switch),
    	.mode_button(mode_button),
        .increase_button(increase_button),
        .decrease_button(decrease_button),
        .FPGA_led_12(FPGA_led_12),
        .FPGA_led_34(FPGA_led_34),
        .FPGA_led_56(FPGA_led_56),
        .FPGA_led_78(FPGA_led_78)
    );



    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Generate 50MHz clock

    end
    
    initial begin
        rst = 0; // 
        #20 rst = 1; // Assert reset for 20 time units
        display_switch = 0;
        #100; // Select second 
        mode_button = 0;
        #100;
        mode_button = 1;

        #100; // Increase second 
        increase_button = 0;
        #100;
        increase_button = 1;

        #100; // Decrease second 
        decrease_button = 0;
        #100;
        decrease_button = 1;

        #100; // Select Min 
        mode_button = 0;
        #100;
        mode_button = 1;

        #100; // Select hour
        mode_button = 0;
        #100;
        mode_button = 1;

        #100; // Select normal 
        mode_button = 0;
        #100;
        mode_button = 1;

        #1000; // delay

        display_switch = 1; // display d/m/y
        #100; // Select yy
        mode_button = 0;
        #100;
        mode_button = 1;

        #100; // Increase yy
        increase_button = 0;
        #100;
        increase_button = 1;

        #100; // Decrease yy
        decrease_button = 0;
        #100;
        decrease_button = 1;

        #100; // Select mm 
        mode_button = 0;
        #100;
        mode_button = 1;

        #100; // Select dd
        mode_button = 0;
        #100;
        mode_button = 1;

        #100; // Select normal 
        mode_button = 0;
        #100;
        mode_button = 1;
        
        #100; // Simulate for 200 time units
        $stop; 
    end
endmodule 


