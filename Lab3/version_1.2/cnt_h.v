module cnt_h (
    input clk,
    input rst,
    input pulse_1h,
    input increase_h, decrease_h, enable_cnt_h,
    output [5:0] cnt_h,
    output pulse_1d 
);
    reg [5:0] cnt;
    reg pre_increase_h, pre_decrease_h;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin
            cnt <= 6'd0;
            pre_increase_h <= 1;
            pre_decrease_h <= 1;
        end else begin
            if (enable_cnt_h) begin
                if (pulse_1h) begin
                    if (cnt == 6'd23) cnt <= 6'd0;
                    else cnt <= cnt + 1;   
                end

                if(increase_h != pre_increase_h) begin
                    pre_increase_h <= increase_h;
                    if (increase_h == 0) begin
                        if (cnt == 6'd23) cnt <= 6'd0;
                        else cnt <= cnt + 1;
                    end
                end else
                if(decrease_h != pre_decrease_h) begin
                    pre_decrease_h <= decrease_h;
                    if (decrease_h == 0) begin
                        if (cnt == 6'd00) cnt <= 6'd23;
                        else cnt <= cnt - 1;
                    end
                end
            end 
        end
    end
    assign pulse_1d = (cnt == 6'd59) & pulse_1h;
    assign cnt_h = cnt; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule