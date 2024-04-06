module cnt_y_ten_unit (
    input clk,
    input rst,
    input pulse_1y,
    input increase_y, decrease_y, enable_cnt_y,
    output [6:0] cnt_y_ten_unit, // var type net is wire 
    output pulse_increase, pulse_decrease
);

    reg [6:0] cnt;
    reg pre_increase_y, pre_decrease_y;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin
            cnt <= 7'd0;
            pre_increase_y <= 1;
            pre_decrease_y <= 1;
        end else begin
            if (enable_cnt_y) begin
                if (pulse_1y) begin
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
    assign pulse_increase = (cnt == 7'd99) & pulse_1y;
    assign pulse_increase = (cnt == 7'd99) & ~increase_y;   
    assign pulse_decrease = (cnt == 7'd0) & ~decrease_y;
    assign cnt_y_ten_unit = cnt;
endmodule
