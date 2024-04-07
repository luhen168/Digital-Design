module cnt_y_thousand_hundred (
    input clk,
    input rst,
    input pulse_y_thousand_hundred,
    input increase_y_thousand_hundred, decrease_y_thousand_hundred, enable_cnt_y_thousand_hundred,
    output [6:0] cnt_y_thousand_hundred
);
    reg [6:0] cnt;
    reg pre_increase_y_thousand_hundred, pre_decrease_y_thousand_hundred;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin
            cnt <= 7'd20;
            pre_increase_y_thousand_hundred <= 1;
            pre_decrease_y_thousand_hundred <= 1;
        end else begin
            if (enable_cnt_y_thousand_hundred) begin
                if (pulse_y_thousand_hundred) begin
                    if (cnt == 7'd99) cnt <= 7'd0;
                    else cnt <= cnt + 1;   
                end

                if(increase_y_thousand_hundred != pre_increase_y_thousand_hundred) begin
                    pre_increase_y_thousand_hundred <= increase_y_thousand_hundred;
                    if (increase_y_thousand_hundred == 0) begin
                        if (cnt == 7'd99) cnt <= 7'd0;
                        else cnt <= cnt + 1;
                    end
                end else
                if(decrease_y_thousand_hundred != pre_decrease_y_thousand_hundred) begin
                    pre_decrease_y_thousand_hundred <= decrease_y_thousand_hundred;
                    if (decrease_y_thousand_hundred == 0) begin
                        if (cnt == 7'd00) cnt <= 7'd99;
                        else cnt <= cnt - 1;
                    end
                end
            end 
        end
    end
    assign cnt_y_thousand_hundred = cnt; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule