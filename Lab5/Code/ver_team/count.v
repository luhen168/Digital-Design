module count (
    input clk,
    input rst_n,
    input [3:0] count,
    input ena_count,
    output [3:0] led,
    output time_out
);

    wire signal_1s;
    reg [3:0] count_buffer;

    pulse_1s pulse_1s_inst (
        .clk(clk),
        .rst_n(rst_n),
        // .ena_count(ena_count),
        .pulse_1s(signal_1s)
    );

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            count_buffer <= 4'd0;
        end else begin
            if(ena_count == 1) count_buffer <= count;
            else if(signal_1s == 1) count_buffer <= count_buffer - 1;          
        end
    end
    assign time_out = (count_buffer == 4'd1) & signal_1s & (count != 4'd10);
    assign led = count_buffer;
endmodule
