// module tb_each_module;
//     // Signals
//     reg clk;
//     reg rst;
//     reg enable_pulse_1s;
//     reg display_switch;
//     reg [5:0] increase_signal;
//     reg [5:0] decrease_signal;
//     reg [5:0] enable_display;
//     reg [5:0] enable_cnt;
//     wire [6:0] FPGA_led_1;
//     wire [6:0] FPGA_led_2;
//     wire [6:0] FPGA_led_3;
//     wire [6:0] FPGA_led_4;
//     wire [6:0] FPGA_led_5;
//     wire [6:0] FPGA_led_6;
//     wire [6:0] FPGA_led_7;
//     wire [6:0] FPGA_led_8;

//     // Instantiate of control
//     control dut (
//         .clk(clk),
//         .rst(rst),
//         .enable_pulse_1s(enable_pulse_1s),
//         .display_switch(display_switch),
//         .increase_signal(increase_signal),
//         .decrease_signal(decrease_signal),
//         .enable_display(enable_display),
//         .enable_cnt(enable_cnt),
//         .FPGA_led_1(FPGA_led_1),
//         .FPGA_led_2(FPGA_led_2),
//         .FPGA_led_3(FPGA_led_3),
//         .FPGA_led_4(FPGA_led_4),
//         .FPGA_led_5(FPGA_led_5),
//         .FPGA_led_6(FPGA_led_6),
//         .FPGA_led_7(FPGA_led_7),
//         .FPGA_led_8(FPGA_led_8)
//     );

//     pulse_1s inst_sig (
//         .clk(clk),
//         .rst(rst),
//         .enable_pulse_1s(enable_pulse_1s),
//         .pulse_1s(pulse_1s)
//     );

    // // Clock generation
    // always begin
    //     clk = 0;
    //     forever #10 clk = ~clk; // Generate 50MHz clock
    // end

    // // Reset generation
    // initial begin
    //     rst = 0; // 
    //     #20 rst = 1; // Assert reset for 20 time units
    //     enable_pulse_1s = 1;
    //     enable_display = 6'b111111;
    //     enable_cnt = 6'b111111;
    //     display_switch = 0;
    //     increase_signal = 0;
    //     decrease_signal = 0;
    //     #15000000; // Simulate for 200 time units
    //     $stop; 
    // end

    // // // Stimulus
    // // initial begin
    // //     // Here you can apply stimulus to your control module by toggling inputs
    // //     // Example:
    // //     #10 enable_pulse_1s = 1;
    // //     #10 enable_pulse_1s = 0;

    // //     #20 display_switch = 1;
    // //     #20 display_switch = 0;

    // //     // Continue with other inputs as needed
    // // end

// endmodule
module tb_each_module;
    // Signals
    reg clk;
    reg rst;
    reg increase_s;
    reg decrease_s;
    reg enable_cnt_s;
    reg increase_mi;
    reg decrease_mi;
    reg enable_cnt_mi;
    reg increase_h;
    reg decrease_h;
    reg enable_cnt_h;
    reg increase_d;
    reg decrease_d;
    reg enable_cnt_d;
    reg increase_mo;
    reg decrease_mo;
    reg enable_cnt_mo;
    reg increase_y;
    reg decrease_y;
    reg enable_cnt_y;

    reg enable_pulse_1s;
    
    wire [5:0] cnt_s;
    wire [5:0] cnt_mi;
    wire [5:0] cnt_h;
    wire [5:0] cnt_d;
    wire [5:0] cnt_mo;
    wire [6:0] cnt_y_ten_unit;
    wire [6:0] cnt_y_thousand_hundred;
    wire pulse_1s;



    pulse_1s inst_sig (
        .clk(clk),
        .rst(rst),
        .enable_pulse_1s(enable_pulse_1s),
        .pulse_1s(pulse_1s)
    );

    // Instantiate the DUT
    control_cnt dut (
        .clk(clk),
        .rst(rst),
        .pulse_1s(pulse_1s),
        .increase_s(increase_s),
        .decrease_s(decrease_s),
        .enable_cnt_s(enable_cnt_s),
        .increase_mi(increase_mi),
        .decrease_mi(decrease_mi),
        .enable_cnt_mi(enable_cnt_mi),
        .increase_h(increase_h),
        .decrease_h(decrease_h),
        .enable_cnt_h(enable_cnt_h),
        .increase_d(increase_d),
        .decrease_d(decrease_d),
        .enable_cnt_d(enable_cnt_d),
        .increase_mo(increase_mo),
        .decrease_mo(decrease_mo),
        .enable_cnt_mo(enable_cnt_mo),
        .increase_y(increase_y),
        .decrease_y(decrease_y),
        .enable_cnt_y(enable_cnt_y),
        .cnt_s(cnt_s),
        .cnt_mi(cnt_mi),
        .cnt_h(cnt_h),
        .cnt_d(cnt_d),
        .cnt_mo(cnt_mo),
        .cnt_y_ten_unit(cnt_y_ten_unit),
        .cnt_y_thousand_hundred(cnt_y_thousand_hundred)
    );

       // Clock generation
    always begin
        clk = 0;
        forever #10 clk = ~clk; // Generate 50MHz clock
    end

    // Reset generation
    initial begin
        rst = 0; // 
        #20 rst = 1; // Assert reset for 20 time units
        enable_pulse_1s = 1;
        enable_cnt_s = 1;
        enable_cnt_mi = 1;
        enable_cnt_h = 1;
        enable_cnt_d = 1;
        enable_cnt_mo =1;
        enable_cnt_y = 1;
        #1500000000; // Simulate for 200 time units
        #1500000000;
        #1500000000;
        #1500000000;
        #1500000000;
        #1500000000;
        #1500000000;
        #1500000000;
        $stop; 
    end

endmodule
