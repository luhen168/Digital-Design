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

    reg increase_mi;
    reg decrease_mi;
    reg enable_cnt_mi;
    wire [5:0] cnt_mi;
    wire pulse_1h;

    reg increase_h;
    reg decrease_h;
    reg enable_cnt_h;
    wire [5:0] cnt_h;
    wire pulse_1d;

    reg increase_d;
    reg decrease_d;
    reg enable_cnt_d;
    wire [5:0] cnt_d;
    wire pulse_1mo;
    reg [6:0] cnt_y_ten_unit;
    reg [6:0] cnt_mo;
    wire day_total_in_mo;

    // Instantiate the Unit Under Test (UUT)
    main uut (
        .clk(clk), 
        .rst(rst), 
        .enable_pulse_1s(enable_pulse_1s),

        .increase_s(increase_s),
        .decrease_s(decrease_s),
        .enable_cnt_s(enable_cnt_s),
        .cnt_s(cnt_s),
        .pulse_1mi(pulse_1mi),

        .increase_mi(increase_mi),
        .decrease_mi(decrease_mi),
        .enable_cnt_mi(enable_cnt_mi),
        .cnt_mi(cnt_mi),
        .pulse_1h(pulse_1h),

        .increase_h(increase_h),
        .decrease_h(decrease_h),
        .enable_cnt_h(enable_cnt_h),
        .cnt_h(cnt_h),
        .pulse_1d(pulse_1d),

        .increase_d(increase_d),
        .decrease_d(decrease_d),
        .enable_cnt_d(enable_cnt_d),
        .cnt_d(cnt_d),
        .pulse_1mo(pulse_1mo),
        .cnt_y_ten_unit(cnt_y_ten_unit),
        .cnt_mo(cnt_mo),
        .day_total_in_mo(day_total_in_mo)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        enable_pulse_1s = 1;

        increase_s = 0;
        decrease_s = 0;
        enable_cnt_s = 1; 

        increase_mi = 0;
        decrease_mi = 0;
        enable_cnt_mi = 1;

        increase_h = 0;
        decrease_h = 0;
        enable_cnt_h = 1;

        increase_d = 0;
        decrease_d = 0;
        enable_cnt_d = 1;

        cnt_y_ten_unit = 7'd24;
        cnt_mo = 7'd4;

        // Wait for 100 ns for global reset to finish
        #100;
        
        // De-assert reset
        rst = 1;
        #100;
        
        // First 1000ns: enable = 0, increase and decrease varies
        enable_cnt_d = 0;
        increase_d = 1;
        decrease_d = 0;
        repeat(10) begin
            #100;
            increase_d = ~increase_d;
            decrease_d = ~decrease_d;
        end

        // Next 1000ns: enable = 1, increase and decrease varies
        enable_cnt_d = 1;
        repeat(10) begin
            #100;
            increase_d = ~increase_d;
            decrease_d = ~decrease_d;
        end
    end
      
    // Clock generator
    always #10 clk = ~clk;
    
endmodule
