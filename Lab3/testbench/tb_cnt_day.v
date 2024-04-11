// `timescale 1ns / 1ns // if use set value in software simulation 

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
    // wire [5:0] day_total_in_mo;

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
        .pulse_1mo(pulse_1mo) 
        // .day_total_in_mo(day_total_in_mo)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        // Initialize Inputs
        enable_cnt_d = 1;
        rst = 0; 
        #20 rst = 1 ;
        // enable_cnt_d = 1;
        // pulse_1d = 0;
        // #50 pulse_1d = ~pulse_1d;
        increase_d = 1;
        decrease_d = 1;
        cnt_y_ten_unit = 7'd24;
        cnt_mo = 7'd1;

        // Wait 100 ns for global reset to finish
        #10000000;
        
        // // Deassert reset
        // rst = 1;
        // #100;
        $stop;
    end
      
    always@ (posedge clk) begin // var reg is only in block always or initial 
        pulse_1d = 0; 
        #10 pulse_1d = ~pulse_1d;
    end

    always @(posedge clk) begin 
        if (pulse_1mo) begin
            if (cnt_mo == 12) cnt_mo = 1;
            else cnt_mo = cnt_mo + 1;
        end
    end

endmodule