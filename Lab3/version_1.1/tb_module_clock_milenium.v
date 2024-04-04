module tb_module_clock_milenium;
    reg clk;
    reg rst;
    reg in;
    wire sig_1s;
    wire [5:0] seconds, minutes, hours; // use wire to bcd and display 7- 
    wire sig_1min, sig_1hour, sig_1day;    

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
        .sig_1min(sig_1min),  // output to incre minute
        .seconds(seconds)           // output for 7-seg
    );

    MinutesCounter inst_min (
        .clk(clk),
        .rst(rst),
        .sig_1min(sig_1min),  // input
        .sig_1hour(sig_1hour),      // output 
        .minutes(minutes)           
    );

    HoursCounter inst_hour (
        .clk(clk),
        .rst(rst),      
        .sig_1hour(sig_1hour),      // input
        .sig_1day (sig_1day),       // output
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


