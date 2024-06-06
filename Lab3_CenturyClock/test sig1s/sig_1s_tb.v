module sig_1s_tb;
    reg clk;
    reg rst;
    wire sig_1s;

    // Instantiate the clk_1second module
    clk_1second dut (
        .clk_50MHz(clk),
        .rst(rst),
        .sig_1s(sig_1s)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Generate 50MHz clock

    end
    
    initial begin
        rst = 0; // 
        #20 rst = 1; // Assert reset for 20 time units

        #100; // Wait for a while after reset
        $display("Time  Sig_1s");
        $monitor("%4t: %b", $time, sig_1s); // Monitor sig_1s changes
        #500; // Simulate for 200 time units
        //$finish; // End simulation 
        $stop;  
      end  
endmodule