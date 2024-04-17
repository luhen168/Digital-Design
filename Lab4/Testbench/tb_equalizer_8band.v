module tb_equalizer_8band;

    // Parameters
    parameter N = 16;       // Number of bits input
    parameter NUM_FIRS = 8; // Number of FIR filters

    // Inputs
    reg clk;
    reg rst;
    reg ena;
    reg signed [N-1:0] x_in;

    // Outputs
    wire signed [N*2-1:0] y_out_1;
    wire signed [N*2-1:0] y_out_2;
    wire signed [N*2-1:0] y_out_3;
    wire signed [N*2-1:0] y_out_4;
    wire signed [N*2-1:0] y_out_5;
    wire signed [N*2-1:0] y_out_6;
    wire signed [N*2-1:0] y_out_7;
    wire signed [N*2-1:0] y_out_8;
    wire signed [N*2-1:0] y_out;
    // integer
    integer file,out_file_fir1,out_file_fir2,out_file_fir3,out_file_fir4,out_file_fir5,out_file_fir6,out_file_fir7,out_file_fir8, out_file;
    integer read_file;
    integer i;
    reg signed [N-1:0] mem[0:90000]; 
    
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
        .y_out_8(y_out_8),
        .y_out(y_out)
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
        ena = 1;    // Enable processing
        // Read data from the file and provide it to the DUT
            file = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Tools\\wav convert\\mono-synth.txt", "r");
            // file = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\ConvertWavToBit\\tft.txt", "r");
            for (i = 0; i < 90000; i = i + 1) begin
                read_file = $fscanf(file, "%b\n", mem[i]);
                x_in = mem[i];
                #20;       // Wait for some time before providing the next input
            end
        $fclose(file);
    end

    initial begin
        out_file_fir1 = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Testbench\\output_equalizer1.txt","w");
        out_file_fir2 = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Testbench\\output_equalizer2.txt","w");
        out_file_fir3 = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Testbench\\output_equalizer3.txt","w");
        out_file_fir4 = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Testbench\\output_equalizer4.txt","w");
        out_file_fir5 = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Testbench\\output_equalizer5.txt","w");
        out_file_fir6 = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Testbench\\output_equalizer6.txt","w");
        out_file_fir7 = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Testbench\\output_equalizer7.txt","w");
        out_file_fir8 = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Testbench\\output_equalizer8.txt","w");
        out_file =  $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Testbench\\output32bit.txt","w");
    end
    always@(posedge clk) begin
        $fdisplayb (out_file_fir1, y_out_1);
        $fdisplayb (out_file_fir2, y_out_2);
        $fdisplayb (out_file_fir3, y_out_3);
        $fdisplayb (out_file_fir4, y_out_4);
        $fdisplayb (out_file_fir5, y_out_5);
        $fdisplayb (out_file_fir6, y_out_6);
        $fdisplayb (out_file_fir7, y_out_7);
        $fdisplayb (out_file_fir8, y_out_8);
        $fdisplayb (out_file, y_out);
    end

    initial begin
        #1820000;
        $finish;
    end

endmodule
