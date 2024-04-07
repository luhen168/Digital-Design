module cnt_y_ten_unit (
    input clk,
    input rst,
    input pulse_y_ten_unit,
    input increase_y_ten_unit, decrease_y_ten_unit, enable_cnt_y_ten_unit,
    output [6:0] cnt_y_ten_unit,
    output pulse_y_thousand_hundred 
);
    reg [6:0] cnt;
    reg pre_increase_y_ten_unit, pre_decrease_y_ten_unit;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin
            cnt <= 7'd24;
            pre_increase_y_ten_unit <= 1;
            pre_decrease_y_ten_unit <= 1;
        end else begin
            if (enable_cnt_y_ten_unit) begin
                if (pulse_y_ten_unit) begin
                    if (cnt == 7'd99) cnt <= 7'd0;
                    else cnt <= cnt + 1;   
                end

                if(increase_y_ten_unit != pre_increase_y_ten_unit) begin
                    pre_increase_y_ten_unit <= increase_y_ten_unit;
                    if (increase_y_ten_unit == 0) begin
                        if (cnt == 7'd99) cnt <= 6'd0;
                        else cnt <= cnt + 1;
                    end
                end else
                if(decrease_y_ten_unit != pre_decrease_y_ten_unit) begin
                    pre_decrease_y_ten_unit <= decrease_y_ten_unit;
                    if (decrease_y_ten_unit == 0) begin
                        if (cnt == 7'd00) cnt <= 7'd99;
                        else cnt <= cnt - 1;
                    end
                end
            end 
        end
    end
    assign pulse_y_thousand_hundred = (cnt == 7'd99) & pulse_y_ten_unit;
    assign cnt_y_ten_unit = cnt; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule