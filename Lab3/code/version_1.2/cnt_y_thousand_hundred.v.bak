module cnt_y_thousand_hundred (
    input clk,
    input rst,
    input pulse_increase, pulse_decrease, enable_cnt_y,
    output wire [6:0] cnt_y_thousand_hundred, // var type net is wire 
);

    reg [6:0] y_thousand_hundred_counter;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            y_thousand_hundred_counter <= 7'd0;
        end else begin
            if(pulse_increase & enable_cnt_y) begin
                if (y_thousand_hundred_counter == 7'd99) y_thousand_hundred_counter <= 7'd0; // Reset hour_counter when it = 23
                else y_thousand_hundred_counter <= y_thousand_hundred_counter + 1;
            end else (pulse_increase & ~enable_cnt_y) begin
                if (y_thousand_hundred_counter == 7'd99) y_thousand_hundred_counter <= 7'd0; // Reset hour_counter when it = 23
                else y_thousand_hundred_counter <= y_thousand_hundred_counter + 1;
            end else (pulse_increase & ~enable_cnt_y) begin
                if (y_thousand_hundred_counter == 7'd0) y_thousand_hundred_counter <= 7'd99; // Reset hour_counter when it = 23
                else y_thousand_hundred_counter <= y_thousand_hundred_counter - 1;
            end
        end
    end
    assign cnt_y_thousand_hundred = y_thousand_hundred_counter;
endmodule