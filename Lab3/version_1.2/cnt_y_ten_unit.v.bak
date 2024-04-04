module cnt_y_ten_unit (
    input clk,
    input rst,
    input pulse_1y,
    input increase_y, decrease_y, enable_cnt_y,
    output wire [6:0] cnt_y_ten_unit, // var type net is wire 
    output pulse_increase, pulse_decrease
);

    reg [6:0] y_ten_unit_counter;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            y_ten_unit_counter <= 7'd0;
            cnt_mo <= 0;
        end else begin
            if(pulse_1y & enable_cnt_y) begin
                if (y_ten_unit_counter == 7'd99) y_ten_unit_counter <= 7'd0; // Reset y_ten_unit_counter when it = 23
                else y_ten_unit_counter <= y_ten_unit_counter + 1;
            end else (enable_cnt_y == 0) begin
                if (increase_y == 1 ) begin
                    if(y_ten_unit_counter == 7'd99) begin 
                        y_ten_unit_counter <= 7'd0;
                        pulse_increase <= 1;
                    end else y_ten_unit_counter <= y_ten_unit_counter + 1;
                end else (decrease_y == 1) begin
                    if (y_ten_unit_counter == 7'd0) begin
                        y_ten_unit_counter <= 7'd99;
                        pulse_decrease <= 1;
                    end else y_ten_unit_counter <= y_ten_unit_counter - 1;
                end
            end
        end
    end
    assign pulse_increase = ((y_ten_unit_counter == 7'd99) & pulse_1y) | ((y_ten_unit_counter == 7'd99) & increase_y);
    assign pulse_decrease = (y_ten_unit_counter == 7'd0) & decrease_y;
    assign cnt_y_ten_unit = y_ten_unit_counter;
endmodule