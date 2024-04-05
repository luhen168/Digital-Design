module tb_each_module;
//     // Signals
    reg clk;
    reg rst;
    reg enable_pulse_1s;
    // reg display_switch;
    reg increase_signal;
    reg decrease_signal;
    // reg [5:0] enable_display;
    reg [5:0] enable_cnt;
    wire [5:0] cnt_s;
    wire [5:0] cnt_mi;
    wire [5:0] cnt_h;
    wire [5:0] cnt_d;
    wire [5:0] cnt_mo;
    wire [6:0] cnt_y_ten_unit;
    wire [6:0] cnt_y_thousand_hundred;   

    pulse_1s inst2 (
        .clk(clk),
        .rst(rst),
        .enable_pulse_1s(enable_pulse_1s),
        .pulse_1s(pulse_1s)
    );

    control_cnt inst3 (
        .clk(clk),
        .rst(rst),
        .pulse_1s(pulse_1s),
        .increase_signal(increase_signal),
        .decrease_signal(decrease_signal),
        .enable_cnt_d(enable_cnt[5]),       
        .enable_cnt_mo(enable_cnt[4]),
        .enable_cnt_y(enable_cnt[3]),
        .enable_cnt_h(enable_cnt[2]),
        .enable_cnt_mi(enable_cnt[1]),
        .enable_cnt_s(enable_cnt[0]),
        .cnt_s(cnt_s),
        .cnt_mi(cnt_mi),
        .cnt_h(cnt_h),
        .cnt_d(cnt_d),
        .cnt_mo(cnt_mo),
        .cnt_y_ten_unit(cnt_y_ten_unit), 
        .cnt_y_thousand_hundred(cnt_y_thousand_hundred)
    );

       // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Generate 50MHz clock
    end

    // Reset generation
    initial begin
        rst = 0; // 
        #20 rst = 1; // Assert reset for 20 time units
        enable_pulse_1s = 1;
        // display_switch = 1'b0;
        enable_cnt [5:0] = 6'b111111;
        // enable_display [5:0] = 6'b111111;


        #15000000; // Simulate for 200 time units
    
        $stop; 
    end

endmodule
