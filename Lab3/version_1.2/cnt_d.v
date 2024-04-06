module cnt_d (
    input clk,
    input rst,
    input pulse_1d, 
    input [6:0] cnt_mo, cnt_y_ten_unit,
    input increase_d, decrease_d, enable_cnt_d,
    output [5:0] cnt_d,
    output pulse_1mo,

    output [5:0] day_total_in_mo
);
    reg [5:0] cnt;
    reg pre_increase_d, pre_decrease_d;

    assign pulse_1mo = (cnt == day_total_in_mo) & pulse_1d;
    assign day_total_in_mo =    (cnt_mo == 7'd1) ? 5'd31 : // January
                                (cnt_mo == 7'd2) ? 
                                ((cnt_y_ten_unit != 7'd0 && cnt_y_ten_unit[1:0] == 2'b00) ? 5'd29 : 5'd28) : // February
                                (cnt_mo == 7'd3) ? 5'd31 : // March
                                (cnt_mo == 7'd4) ? 5'd30 : // April
                                (cnt_mo == 7'd5) ? 5'd31 : // May
                                (cnt_mo == 7'd6) ? 5'd30 : // June
                                (cnt_mo == 7'd7) ? 5'd31 : // July
                                (cnt_mo == 7'd8) ? 5'd31 : // August
                                (cnt_mo == 7'd9) ? 5'd30 : // September
                                (cnt_mo == 7'd10) ? 5'd31 : // October
                                (cnt_mo == 7'd11) ? 5'd30 : // November
                                (cnt_mo == 7'd12) ? 5'd31 : // December
                                6'd0; // Invalid month


    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            cnt <= 6'd1;
            pre_increase_d <= 1;
            pre_decrease_d <= 1;
        end else begin
            if (enable_cnt_d) begin
                if (pulse_1d) begin
                    if (cnt == day_total_in_mo) cnt <= 6'd1;
                    else cnt <= cnt + 1;   
                end

                if(increase_d != pre_increase_d) begin
                    pre_increase_d <= increase_d;
                    if (increase_d == 0) begin
                        if (cnt == day_total_in_mo) cnt <= 6'd1;
                        else cnt <= cnt + 1;
                    end
                end else
                if(decrease_d != pre_decrease_d) begin
                    pre_decrease_d <= decrease_d;
                    if (decrease_d == 0) begin
                        if (cnt == 6'd1) cnt <= day_total_in_mo;
                        else cnt <= cnt - 1;
                    end
                end
            end 
        end
    end

    assign cnt_d = cnt;
endmodule