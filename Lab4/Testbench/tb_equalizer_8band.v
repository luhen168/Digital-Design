module top_module_tb;

    // Parameters
    parameter N = 16;       // Number of bits input
    parameter NUM_FIRS = 8; // Number of FIR filters

    // Inputs
    reg clk;
    reg rst;
    reg ena;
    reg [N-1:0] x_in;

    // Outputs
    wire [N-1:0] y_out_1;
    wire [N-1:0] y_out_2;
    wire [N-1:0] y_out_3;
    wire [N-1:0] y_out_4;
    wire [N-1:0] y_out_5;
    wire [N-1:0] y_out_6;
    wire [N-1:0] y_out_7;
    wire [N-1:0] y_out_8;

    // Instantiate the unit under test (UUT)
    top_module uut (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .x_in(x_in),
        .y_out_1(y_out_1),
        .y_out_2(y_out_2),
        .y_out_3(y_out_3),
        .y_out_4(y_out_4),
        .y_out_5(y_out_5),
        .y_out_6(y_out_6),
        .y_out_7(y_out_7),
        .y_out_8(y_out_8)
    );

    // Clock generation
    always begin
        #10 clk = ~clk;
    end

    // Initializations
    initial begin
        clk = 0;
        rst = 0;
        ena = 0;
        x_in = 0;

        #10 rst = 1; // Deassert reset after 10 time units

        // Open the file for reading
        integer file;
        file = $fopen("C:\Users\luan1\OneDrive\Desktop\TKS\Lab\Lab4\ConvertWavToBit\tft.txt", "r");

        // Read data from the file and provide it to the DUT
        repeat (26) begin
            // Read a line from the file
            bit [N-1:0] data;
            $fscanf(file, "%b\n", data);
            
            // Provide data to the DUT
            #10;        // Wait for a few cycles
            ena = 1;    // Enable processing
            x_in = data;
            #100;       // Wait for some time before providing the next input
        end

        // Close the file
        $fclose(file);
    end

endmodule
