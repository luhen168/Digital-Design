module tb_count;
    // Inputs
    reg clk;
    reg rst;
    reg ena_count;
    reg [3:0] count;

    // Outputs
    wire [3:0] led;
    wire timeout;

    // Instantiate the unit under test (UUT)
    count uut (
        .clk(clk),
        .rst(rst),
        .ena_count(ena_count),
        .count(count),
        .led(led),
        .timeout(timeout)
    );

    // Clock generation
    initial begin
        forever #10 clk = ~clk;
    end
    
    // Initializations
    initial begin
        clk = 0;
        rst = 0;
        // ena = 0;
        // x_in = 0;

        #10 rst = 1; // Deassert reset after 10 time units
        #20 ena_count = 1;    // Enable processing
        count = 4'd8;
        #20 ena_count = 0;
    end

    initial begin
        #3400;
        $finish;
    end

endmodule
