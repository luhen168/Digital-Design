module tb_trafficlight;
    // Inputs
    reg clk;
    reg rst;
    reg sw;

    // Outputs
    wire [13:0] FPGA_led7seg_12;
    wire [13:0] FPGA_led7seg_56;
    wire [5:0] FPGA_led;

    // Instantiate the unit under test (UUT)
    traffic_light uut (
        .clk(clk),
        .rst(rst),
        .sw(sw),
        .FPGA_led(FPGA_led),
        .FPGA_led7seg_12(FPGA_led7seg_12),
        .FPGA_led7seg_56(FPGA_led7seg_56)
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
        sw = 1;    // Enable processing
        #200;
    end

    initial begin
        sw = 0;
        #200;
        $finish;
    end

endmodule
