module cnt_mo (
    input clk,
    input rst,
    input pulse_1mo,
    input increase_mo, decrease_mo, enable_cnt_mo,
    output [5:0] cnt_mo,
    output pulse_1y 
);
    reg [5:0] cnt;
    reg pre_increase_mo, pre_decrease_mo;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin
            cnt <= 6'd1;
            pre_increase_mo <= 1;
            pre_decrease_mo <= 1;
        end else begin
            if (enable_cnt_mo) begin
                if (pulse_1mo) begin
                    if (cnt == 6'd59) cnt <= 6'd1;
                    else cnt <= cnt + 1;   
                end

                if(increase_mo != pre_increase_mo) begin
                    pre_increase_mo <= increase_mo;
                    if (increase_mo == 0) begin
                        if (cnt == 6'd12) cnt <= 6'd1;
                        else cnt <= cnt + 1;
                    end
                end else
                if(decrease_mo != pre_decrease_mo) begin
                    pre_decrease_mo <= decrease_mo;
                    if (decrease_mo == 0) begin
                        if (cnt == 6'd1) cnt <= 6'd12;
                        else cnt <= cnt - 1;
                    end
                end
            end 
        end
    end
    assign pulse_1y = (cnt == 6'd12) & pulse_1mo;
    assign cnt_mo = cnt; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule