`timescale 1ns / 1ns

module tb_cnt_d;
    // Inputs
    reg clk;
    reg rst;
    reg pulse_1d;
    reg increase_d;
    reg decrease_d;
    reg enable_cnt_d;
    reg [6:0] cnt_y_ten_unit;
    reg [6:0] cnt_mo;

    // Outputs
    wire [5:0] cnt_d;
    wire pulse_1mo;
    wire [5:0] day_total_in_mo;

    // Instantiate the Unit Under Test (UUT)
    cnt_d uut (
        .clk(clk), 
        .rst(rst), 
        .pulse_1d(pulse_1d), 
        .increase_d(increase_d), 
        .decrease_d(decrease_d), 
        .enable_cnt_d(enable_cnt_d), 
        .cnt_y_ten_unit(cnt_y_ten_unit), 
        .cnt_mo(cnt_mo), 
        .cnt_d(cnt_d), 
        .pulse_1mo(pulse_1mo), 
        .day_total_in_mo(day_total_in_mo)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        pulse_1d = 0;
        increase_d = 1;
        decrease_d = 1;
        enable_cnt_d = 1;
        cnt_y_ten_unit = 7'd24;
        cnt_mo = 7'd1;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Deassert reset
        rst = 1;
        #100;
    
    end
      
    always begin 
        #60
        pulse_1d = 1;
        #20
        pulse_1d = 0;
    end

    always begin 
        #10 clk = ~clk;
        if (cnt_d == day_total_in_mo && pulse_1d) begin
            if (cnt_mo == 12) cnt_mo = 1;
            else cnt_mo = cnt_mo + 1;
        end
    end
endmodule