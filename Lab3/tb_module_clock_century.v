module tb_module_clock_century;
    reg clk;
    reg rst;
    reg in;
    wire sig_1s;
    wire [5:0] seconds, minutes, hours; // use wire to bcd and display 7- 
    wire next_minute, next_hour, next_day;    

    // Instantiate the top module
    module_clock_century dut (
        .clk(clk),
        .rst(rst)
    );

    sig_1s inst_sig (
        .clk(clk),
        .rst(rst),
        .sig_1s(sig_1s)
    );

    SecondsCounter inst_sec (
        .clk(clk),
        .rst(rst),
        .sig_1s(sig_1s),
        .next_minute(next_minute),  // output to incre minute
        .seconds(seconds)           // output for 7-seg
    );

    MinutesCounter inst_min (
        .clk(clk),
        .rst(rst),
        .next_minute(next_minute),  // input
        .next_hour(next_hour),      // output 
        .minutes(minutes)           
    );

    HoursCounter inst_hour (
        .clk(clk),
        .rst(rst),      
        .next_hour(next_hour),      // input
        .next_day (next_day),       // output
        .hours(hours)               // output 
    );



    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Generate 50MHz clock

    end
    
    initial begin
        rst = 0; // 
        #20 rst = 1; // Assert reset for 20 time units

        #15000000; // Simulate for 200 time units
        $stop; 
    end
endmodule 


