module tb_control_decode;
    // Inputs
    reg clk;
    reg enable_s, enable_mi, enable_h;
    reg enable_d, enable_mo, enable_y;
    reg [5:0] cnt_s, cnt_mi, cnt_h, cnt_d, cnt_mo;
    reg [6:0] cnt_y_ten_unit, cnt_y_thousand_hundred;

    // Outputs
    wire [13:0] led_s, led_y_thousand_hundred;
    wire [13:0] led_y_ten_unit;
    wire [13:0] led_mi, led_mo;
    wire [13:0] led_h, led_d;

    // Instantiate the module
    control_decode_7seg uut (
        .enable_s(enable_s),
        .enable_mi(enable_mi),
        .enable_h(enable_h),
        .enable_d(enable_d),
        .enable_mo(enable_mo),
        .enable_y(enable_y),
        .cnt_s(cnt_s),
        .cnt_mi(cnt_mi),
        .cnt_h(cnt_h),
        .cnt_d(cnt_d),
        .cnt_mo(cnt_mo),
        .cnt_y_ten_unit(cnt_y_ten_unit),
        .cnt_y_thousand_hundred(cnt_y_thousand_hundred),
        .led_s(led_s),
        .led_y_thousand_hundred(led_y_thousand_hundred),
        .led_y_ten_unit(led_y_ten_unit),
        .led_mi(led_mi),
        .led_mo(led_mo),
        .led_h(led_h),
        .led_d(led_d)
    );

       // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Generate 50MHz clock
    end

    // Reset generation
    initial begin
        enable_s = 1;
        enable_mi = 1;
        enable_h = 1;
        enable_d = 1;
        enable_mo = 1;
        enable_y = 1;
        cnt_s = 6'b111011;
        cnt_mi = 6'b111011;
        cnt_h = 6'b001010;
        cnt_d = 6'b010011;
        cnt_mo = 6'b001010;
        cnt_y_ten_unit = 7'b0000000;
        cnt_y_thousand_hundred = 7'b0000000;



        // Add more test scenarios as needed


        #15000000; // Simulate for 200 time units
    
        $stop; 
    end

endmodule
