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
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        pulse_1d = 0;
        increase_d = 1;
        decrease_d = 1;
        enable_cnt_d = 1;
        cnt_y_ten_unit = 7'd00;
        cnt_mo = 7'd1;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Deassert reset
        rst = 1;
        #100;
    
    end

    wire [5:0] day_total_in_mo;
    assign day_total_in_mo =    (cnt_mo == 7'd1) ? 5'd31 : // January
                            (cnt_mo == 7'd2) ? 
                            ((cnt_y_ten_unit != 7'd0 && cnt_y_ten_unit[1:0] == 2'b00) ? 5'd29 : 5'd28) : // February
                            (cnt_mo == 7'd3) ? 5'd31 : // March
                            (cnt_mo == 7'd4) ? 5'd30 : // April
                            (cnt_mo == 7'd5) ? 5'd31 : // May
                            (cnt_mo == 7'd6) ? 5'd30 : // June
                            (cnt_mo == 7'd7) ? 5'd31 : // July
                            (cnt_mo == 7'd8) ? 5'd31 : // August
                            (cnt_mo == 7'd9) ? 5'd30 : // September
                            (cnt_mo == 7'd10) ? 5'd31 : // October
                            (cnt_mo == 7'd11) ? 5'd30 : // November
                            (cnt_mo == 7'd12) ? 5'd31 : // December
                            6'd0; // Invalid month
      
    // pulse_1s is set high for 1 clk every 5clk
    integer count = 0;
    always @(posedge clk) begin
        if(count == 4) begin
            pulse_1d = 1;
            count = 0;
        end else begin
            pulse_1d = 0;
            count = count + 1;
        end
    end

    always begin 
        #10 clk = ~clk;
        if (cnt_d == day_total_in_mo && pulse_1d && clk) begin
            if (cnt_mo == 12) cnt_mo = 1;
            else cnt_mo = cnt_mo + 1;
        end
    end
endmodule
