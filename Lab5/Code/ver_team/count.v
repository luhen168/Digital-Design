module count (
    input clk,
    input rst,
    input [3:0] count,
    input ena_count,
    output [3:0] led,
    output timeout
);

    wire signal_1s;
    reg [3:0] count_buffer;

    pulse_1s pulse_1s_inst (
        .clk(clk),
        .rst(rst),
        // .ena_count(ena_count),
        .pulse_1s(signal_1s)
    );

    always @(posedge clk or negedge rst) begin
        if(~rst) begin
            count_buffer <= 4'd0;
        end else begin
            if(ena_count == 1) count_buffer <= count;
            else if(signal_1s == 1) count_buffer <= count_buffer - 1;          
        end
    end
    assign timeout = (count_buffer == 4'd1) & signal_1s & (count != 4'd10);
    assign led = count_buffer;
endmodule
