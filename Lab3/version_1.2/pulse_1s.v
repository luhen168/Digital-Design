module pulse_1s (
    input clk,
    input rst,
    input enable_pulse_1s,
    output reg pulse_1s
);
    // localparam divider = 49999999;
    // localparam divider = 199999;
    localparam divider = 2;

    reg [25:0] counter;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin      
            counter <= 0;
            pulse_1s <= 1;
        end else begin
            if (enable_pulse_1s) begin 
                if (counter == divider) begin
                    pulse_1s <= 1;
                    counter <= 0;
                end else begin
                    pulse_1s <= 0;
                    counter <= counter + 1;
                end
            end else begin           
                counter <= 0;
                pulse_1s <= 0;
            end
        end
    end
endmodule