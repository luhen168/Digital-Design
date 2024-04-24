module pulse_1s (
    input clk,
    input rst,
    // input ena_count,
    output reg pulse_1s
);
    // localparam divider = 49999999;
    // localparam divider = 19999;
    localparam divider = 19;

    reg [31:0] counter;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin      
            counter <= 0;
            pulse_1s <= 0;
        end else begin
            // if (ena_count) begin 
                if (counter == divider) begin
                    pulse_1s <= 1;
                    counter <= 0;
                end else begin
                    pulse_1s <= 0;
                    counter <= counter + 1;
                end
            // end else begin           
            //     counter <= 0;
            //     pulse_1s <= 0;
            // end
        end
    end
endmodule