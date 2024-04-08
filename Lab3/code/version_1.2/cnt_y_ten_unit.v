module cnt_y_ten_unit (
    input clk,
    input rst,
    input pulse_y_ten_unit,
    input increase_y, decrease_y, enable_cnt_y_ten_unit,
    output [6:0] cnt_y_ten_unit, // var type net is wire 
    output pulse_y_thousand_hundred
);

    reg [6:0] cnt;
    reg pre_increase_y, pre_decrease_y;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin
            cnt <= 7'd20;
            pre_increase_y <= 1;
            pre_decrease_y <= 1;
        end else begin
            if (enable_cnt_y_ten_unit) begin
                if (pulse_y_ten_unit) begin
                    if (cnt == 7'd99) cnt <= 7'd0;
                    else cnt <= cnt + 1;   
                end

                if(increase_y != pre_increase_y) begin
                    pre_increase_y <= increase_y;
                    if (increase_y == 0) begin
                        if (cnt == 7'd99) cnt <= 7'd0;
                        else cnt <= cnt + 1;
                    end
                end else
                if(decrease_y != pre_decrease_y) begin
                    pre_decrease_y <= decrease_y;
                    if (decrease_y == 0) begin
                        if (cnt == 7'd00) cnt <= 7'd99;
                        else cnt <= cnt - 1;
                    end
                end
            end 
        end
    end
    assign pulse_y_thousand_hundred = (cnt == 7'd99) & pulse_y_ten_unit;
    assign cnt_y_ten_unit = cnt;
endmodule
