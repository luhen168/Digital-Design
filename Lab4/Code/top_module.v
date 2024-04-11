module top_module # (
    parameter N = 16,      // Number of bits input
    parameter NUM_FIRS = 8 // Number of FIR filters
) (
    input  clk,
    input  rst,
    input  ena,
    input  [N-1:0] x_in,
    output [N-1:0] y_out_1,
    output [N-1:0] y_out_2,
    output [N-1:0] y_out_3,
    output [N-1:0] y_out_4,
    output [N-1:0] y_out_5,
    output [N-1:0] y_out_6,
    output [N-1:0] y_out_7,
    output [N-1:0] y_out_8
);

    parameter [5:0] DELAYS [1:8] = '{ // Use array have 8 elements , each element have 6bits
        5'd24, 
        5'd42,
        5'd48,
        5'd48,
        5'd48,
        5'd50,
        5'd52,
        5'd52      
    };

   // parameter [(52+1)*N-1:0] COEFFICIENTS [1:8]

    // parameter [NUM_FIRS*64-1:0] DELAYS = '{3, 4, 5, 6, 7, 8, 9, 10}; // Array of DELAYS for each FIR filter
    // parameter [NUM_FIRS-1:0] COEFFICIENTS = '{32'h12345678, 32'h23456789, 32'h3456789A, 32'h456789AB, 32'h56789ABC, 32'h6789ABCD, 32'h789ABCDE, 32'h89ABCDEF}; // Array of coefficients for each FIR filter
    parameter [(DELAYS[1]+1)*N-1:0] b_1 = {
        16'hFFB9,
        16'hFFAA,
        16'hFF95,
        16'hFF9F,
        16'h0000,
        16'h00F5,
        16'h02A6,
        16'h0511,
        16'h0802,
        16'h0B16,
        16'h0DCD,
        16'h0FAC,
        16'h1056,
        16'h0FAC,
        16'h0DCD,
        16'h0B16,
        16'h0802,
        16'h0511,
        16'h02A6,
        16'h00F5,
        16'h0000,
        16'hFF9F,
        16'hFF95,
        16'hFFAA,
        16'hFFB9
    };

    parameter [(DELAYS[2]+1)*N-1:0] b_2 = {
        16'h0,
        16'h0,
        16'h0,
        16'h0,
        16'hfffd,
        16'hfffa,
        16'hfff8,
        16'hfffc,
        16'h000d,
        16'h002b,
        16'h53,
        16'h00c3,
        16'h00b2,
        16'hffef,
        16'hfdd4,
        16'hfa8d,
        16'hf7c4,
        16'hf7fe,
        16'hfcbe,
        16'h04d9,
        16'h0c8f,
        16'h0fbb,
        16'h0c8f,
        16'h04d9,
        16'hfcbe,
        16'hf7fe,
        16'hf7c4,
        16'hfa8d,
        16'hfdd4,
        16'hffef,
        16'h00b2,
        16'h00c3,
        16'h53,
        16'h002b,
        16'h000d,
        16'hfffc,
        16'hfff8,
        16'hfffa,
        16'hfffd,
        16'h0,
        16'h0,
        16'h0,
        16'h0
    };

    parameter [(DELAYS[3]+1)*N-1:0] b_3 = {
        16'h0,
        16'h0,
        16'h0,
        16'h0,
        16'h1,
        16'h3,
        16'h3,
        16'hfffe,
        16'hfff6,
        16'hfff5,
        16'h3,
        16'h15,
        16'h004c,
        16'hffd8,
        16'hfed8,
        16'hfe3f,
        16'h0,
        16'h042c,
        16'h674,
        16'h01c7,
        16'hf803,
        16'hf302,
        16'hfa5b,
        16'h08d9,
        16'h103f,
        16'h08d9,
        16'hfa5b,
        16'hf302,
        16'hf803,
        16'h01c7,
        16'h674,
        16'h042c,
        16'h0,
        16'hfe3f,
        16'hfed8,
        16'hffd8,
        16'h004c,
        16'h15,
        16'h3,
        16'hfff5,
        16'hfff6,
        16'hfffe,
        16'h3,
        16'h3,
        16'h1,
        16'h0,
        16'h0,
        16'h0,
        16'h0
    };

    parameter [(DELAYS[4]+1)*N-1:0] b_4 = {
        16'h0,
        16'h0,
        16'h0,
        16'h0,
        16'hfffe,
        16'h0,
        16'h5,
        16'h4,
        16'hfff7,
        16'hfff0,
        16'h3,
        16'h004e,
        16'hffe4,
        16'hff4d,
        16'h42,
        16'h021a,
        16'h14,
        16'hfb1a,
        16'hfd95,
        16'h07c7,
        16'h07a2,
        16'hf845,
        16'hf26e,
        16'h340,
        16'h1029,
        16'h340,
        16'hf26e,
        16'hf845,
        16'h07a2,
        16'h07c7,
        16'hfd95,
        16'hfb1a,
        16'h14,
        16'h021a,
        16'h42,
        16'hff4d,
        16'hffe4,
        16'h004e,
        16'h3,
        16'hfff0,
        16'hfff7,
        16'h4,
        16'h5,
        16'h0,
        16'hfffe,
        16'h0,
        16'h0,
        16'h0,
        16'h0
    };

    parameter [(DELAYS[5]+1)*N-1:0] b_5 = {
        16'h0,
        16'h0,
        16'h0,
        16'h1,
        16'hffff,
        16'hfffe,
        16'h4,
        16'h3,
        16'hfff4,
        16'h0,
        16'h19,
        16'hfffa,
        16'hffbe,
        16'h009c,
        16'h79,
        16'hfdec,
        16'h0,
        16'h04f3,
        16'hfd51,
        16'hf85b,
        16'h806,
        16'h076b,
        16'hf23e,
        16'hfcd4,
        16'h1027,
        16'hfcd4,
        16'hf23e,
        16'h076b,
        16'h806,
        16'hf85b,
        16'hfd51,
        16'h04f3,
        16'h0,
        16'hfdec,
        16'h79,
        16'h009c,
        16'hffbe,
        16'hfffa,
        16'h19,
        16'h0,
        16'hfff4,
        16'h3,
        16'h4,
        16'hfffe,
        16'hffff,
        16'h1,
        16'h0,
        16'h0,
        16'h0
    };

    parameter [(DELAYS[6]+1)*N-1:0] b_6 = {
        16'h0,
        16'h0,
        16'h0,
        16'hffff,
        16'h0,
        16'h2,
        16'hfffc,
        16'h2,
        16'h7,
        16'hfff2,
        16'h6,
        16'h15,
        16'hffd4,
        16'h51,
        16'h46,
        16'hfe9f,
        16'h01ef,
        16'h6,
        16'hfb8f,
        16'h06d3,
        16'hfdfb,
        16'hf7fc,
        16'h0d35,
        16'hfa2b,
        16'hf72d,
        16'h100e,
        16'hf72d,
        16'hfa2b,
        16'h0d35,
        16'hf7fc,
        16'hfdfb,
        16'h06d3,
        16'hfb8f,
        16'h6,
        16'h01ef,
        16'hfe9f,
        16'h46,
        16'h51,
        16'hffd4,
        16'h15,
        16'h6,
        16'hfff2,
        16'h7,
        16'h2,
        16'hfffc,
        16'h2,
        16'h0,
        16'hffff,
        16'h0,
        16'h0,
        16'h0
    };

    parameter [(DELAYS[7]+1)*N-1:0] b_7 = {
        16'h0,
        16'h0,
        16'h0,
        16'h0,
        16'h1,
        16'hfffe,
        16'h2,
        16'h0,
        16'hfffc,
        16'h9,
        16'hfff3,
        16'h9,
        16'h9,
        16'h1,
        16'h60,
        16'hff10,
        16'h182,
        16'hfe88,
        16'h0,
        16'h032c,
        16'hf8f0,
        16'h984,
        16'hf7b8,
        16'h029f,
        16'h05c1,
        16'hf2c3,
        16'h0ffe,
        16'hf2c3,
        16'h05c1,
        16'h029f,
        16'hf7b8,
        16'h984,
        16'hf8f0,
        16'h032c,
        16'h0,
        16'hfe88,
        16'h182,
        16'hff10,
        16'h60,
        16'h1,
        16'h9,
        16'h9,
        16'hfff3,
        16'h9,
        16'hfffc,
        16'h0,
        16'h2,
        16'hfffe,
        16'h1,
        16'h0,
        16'h0,
        16'h0,
        16'h0
    };

    parameter [(DELAYS[8]+1)*N-1:0] b_8 = {
        16'h0,
        16'h0,
        16'h0,
        16'hffff,
        16'h1,
        16'hfffe,
        16'h2,
        16'hfffe,
        16'h1,
        16'h2,
        16'hfff8,
        16'h12,
        16'hffe0,
        16'h70,
        16'hff5f,
        16'h0000,
        16'hfed3,
        16'h149,
        16'hfefd,
        16'h28,
        16'h165,
        16'hfc65,
        16'h645,
        16'hf6f8,
        16'h0b74,
        16'hf2e5,
        16'h0d7d,
        16'hf2e5,
        16'h0b74,
        16'hf6f8,
        16'h645,
        16'hfc65,
        16'h165,
        16'h28,
        16'hfefd,
        16'h149,
        16'hfed3,
        16'h0,
        16'hff5f,
        16'h70,
        16'hffe0,
        16'h12,
        16'hfff8,
        16'h2,
        16'h1,
        16'hfffe,
        16'h2,
        16'hfffe,
        16'h1,
        16'hffff,
        16'h0,
        16'h0,
        16'h0
    };

    fir_n #(DELAYS[1], N) fir_1 (
        .clk(clk), 
        .rst(rst), 
        .ena(ena), 
        .b(b_1), 
        .x_in(x_in), 
        .y_out(y_out_1)
    );

    fir_n #(DELAYS[2], N) fir_2 (
        .clk(clk), 
        .rst(rst), 
        .ena(ena), 
        .b(b_2), 
        .x_in(x_in), 
        .y_out(y_out_2)
    );

    fir_n #(DELAYS[3], N) fir_3 (
        .clk(clk), 
        .rst(rst), 
        .ena(ena), 
        .b(b_3), 
        .x_in(x_in), 
        .y_out(y_out_3)
    );

    fir_n #(DELAYS[4], N) fir_4 (
        .clk(clk), 
        .rst(rst), 
        .ena(ena), 
        .b(b_4), 
        .x_in(x_in), 
        .y_out(y_out_4)
    );

    fir_n #(DELAYS[5], N) fir_5 (
        .clk(clk), 
        .rst(rst), 
        .ena(ena), 
        .b(b_5), 
        .x_in(x_in), 
        .y_out(y_out_5)
    );

    fir_n #(DELAYS[6], N) fir_6 (
        .clk(clk), 
        .rst(rst), 
        .ena(ena), 
        .b(b_6), 
        .x_in(x_in), 
        .y_out(y_out_6)
    );

    fir_n #(DELAYS[7], N) fir_7 (
        .clk(clk), 
        .rst(rst), 
        .ena(ena), 
        .b(b_7), 
        .x_in(x_in), 
        .y_out(y_out_7)
    );

    fir_n #(DELAYS[8], N) fir_8 (
        .clk(clk), 
        .rst(rst), 
        .ena(ena), 
        .b(b_8), 
        .x_in(x_in), 
        .y_out(y_out_8)
    );

endmodule