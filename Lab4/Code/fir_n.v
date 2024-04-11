module fir_n #(
    parameter DELAYS = 3, 
    parameter N = 16
) (
    input  clk,                 
    input  rst,
    input  ena,
    input  [(DELAYS+1)*N-1:0] b,     // signed integer coefficients, concatenated in order from 0th delay coefficient to nth delay coefficient
    input  [N-1:0] x_in,             // filter signal input (as a signed integer)
    output [N-1:0] y_out             // output from the system (as a signed integer)
);

    reg [N-1:0] x_in_sync;
    wire [DELAYS*N - 1:0] x_wire; // wires that connect the delay blocks (registers) to propagate x_in through the filter
    wire [DELAYS*N - 1:0] y_wire; // wires that connect y_out from the tapped_delay_blocks to propagate y_in through the filter

    tapped_delay_block #(N) TDBF(  // First delay block
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .b(b[N-1:0]),
        .x_in(x_in_sync), // initial x_in input
        .y_in(16'b0), // first block does not receive any previous y_wire input
        .x_out(x_wire[N-1:0]),
        .y_out(y_wire[N-1:0])
    );

    tapped_delay_block #(N) TDBL(  // Last delay block
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .b(b[(DELAYS+1)*N-1:DELAYS*N]),
        .x_in(x_wire[DELAYS*N-1:(DELAYS-1)*N]),
        .y_in(y_wire[DELAYS*N-1:(DELAYS-1)*N]),
        .y_out(y_out) //final output of the FIR filter
    );

    genvar i;
    for(i = 1; i < DELAYS; i = i + 1) begin
        tapped_delay_block #(N) TDBi(
            .clk(clk),
            .rst(rst),
            .ena(ena),
            .b(b[(i+1)*N-1:i*N]),
            .x_in(x_wire[i*N-1:(i-1)*N]),
            .y_in(y_wire[i*N-1:(i-1)*N]),
            .x_out(x_wire[(i+1)*N-1:i*N]),
            .y_out(y_wire[(i+1)*N-1:i*N])
        ); 
    end

    always @(posedge clk or negedge rst) begin
        if(~rst)
            x_in_sync <= 0;
        else if(ena)
            x_in_sync <= x_in;
    end
endmodule
