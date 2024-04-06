module cnt_mi (
    input clk,
    input rst,
    input pulse_1mi,
    input increase_mi, decrease_mi, enable_cnt_mi,
    output [5:0] cnt_mi,
    output pulse_1h 
);
    reg [5:0] cnt;
    reg pre_increase_mi, pre_decrease_mi;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin
            cnt <= 6'd0;
            pre_increase_mi <= 1;
            pre_decrease_mi <= 1;
        end else begin
            if (enable_cnt_mi) begin
                if (pulse_1mi) begin
                    if (cnt == 6'd59) cnt <= 6'd0;
                    else cnt <= cnt + 1;   
                end

                if(increase_mi != pre_increase_mi) begin
                    pre_increase_mi <= increase_mi;
                    if (increase_mi == 0) begin
                        if (cnt == 6'd59) cnt <= 6'd0;
                        else cnt <= cnt + 1;
                    end
                end else
                if(decrease_mi != pre_decrease_mi) begin
                    pre_decrease_mi <= decrease_mi;
                    if (decrease_mi == 0) begin
                        if (cnt == 6'd00) cnt <= 6'd59;
                        else cnt <= cnt - 1;
                    end
                end
            end 
        end
    end
    assign pulse_1h = (cnt == 6'd59) & pulse_1mi;
    assign cnt_mi = cnt; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule