module tb_euqalizer_8band;

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
    
    // integer
    integer file,out_file;
    integer read_file;
    integer i;
    reg [N-1:0] mem[0:90000]; 
    
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
    initial begin
        forever #10 clk = ~clk;
    end
    
    // Initializations
    initial begin
        clk = 0;
        rst = 0;
        ena = 0;
        x_in = 0;

        #10 rst = 1; // Deassert reset after 10 time units
        ena = 1;    // Enable processing
        // Read data from the file and provide it to the DUT
            file = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\ConvertWavToBit\\tft.txt", "r");
            for (i = 0; i < 90000; i = i + 1) begin
                read_file = $fscanf(file, "%b\n", mem[i]);
                x_in = mem[i];
                #10;       // Wait for some time before providing the next input
            end
        $fclose(file);
        
        $stop;
    end

    initial begin
        out_file = $fopen("C:\\Users\\luan1\\OneDrive\\Desktop\\TKS\\Lab\\Lab4\\Code\\output_equalizer.txt","w");
    end
    always@(posedge clk) begin
        $fdisplay (out_file, y_out_1);
        $fdisplay (out_file, y_out_2);
        $fdisplay (out_file, y_out_3);
        $fdisplay (out_file, y_out_4);
        $fdisplay (out_file, y_out_5);
        $fdisplay (out_file, y_out_6);
        $fdisplay (out_file, y_out_7);
        $fdisplay (out_file, y_out_8);
    end
    

endmodule
