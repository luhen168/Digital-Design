module pulse_1s (
    input clk,
    input enable_pulse_1s,
    input rst,
    output reg pulse_1s
);

    localparam divider = 4999999;

    reg [31:0] counter;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin      
            counter <= 0;
            pulse_1s <= 1;
        end else if (enable_pulse_1s) begin
            if (counter == divider) begin
                pulse_1s <= 1;
                counter <= 0;
            end else begin
                pulse_1s <= 0;
                counter <= counter + 1;
            end
        end
    end
endmodule