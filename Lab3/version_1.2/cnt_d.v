module cnt_d (
    input clk,
    input rst,
    input pulse_1d, 
    input increase_d, decrease_d, enable_cnt_d,
    input [6:0] cnt_y_ten_unit, cnt_mo,
    output [5:0] cnt_d, // var type net is wire 
    output pulse_1mo,
    output [5:0] day_total_in_mo
);

    reg [5:0] day_counter;
    // reg [5:0] day_total_in_mo;


    assign day_total_in_mo = (cnt_mo == 7'd1) ? 6'd31 : // January
                        (cnt_mo == 7'd2) ? 6'd28 : // February (non-leap year)
                        (cnt_mo == 7'd3) ? 6'd31 : // March
                        (cnt_mo == 7'd4) ? 6'd30 : // April
                        (cnt_mo == 7'd5) ? 6'd31 : // May
                        (cnt_mo == 7'd6) ? 6'd30 : // June
                        (cnt_mo == 7'd7) ? 6'd31 : // July
                        (cnt_mo == 7'd8) ? 6'd31 : // August
                        (cnt_mo == 7'd9) ? 6'd30 : // September
                        (cnt_mo == 7'd10) ? 6'd31 : // October
                        (cnt_mo == 7'd11) ? 6'd30 : // November
                        (cnt_mo == 7'd12) ? 6'd31 : // December
                        6'd0; // Invalid month

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            day_counter <= 6'd1;
        end else begin
            // if((cnt_y_ten_unit[1:0] == 2'b00) & (cnt_mo == 6'd2)) begin
            //     day_total_in_mo <= 5'd29; // kiểm tra hai bit cuối 
            //     // định sửa vào đây 
                
            // end else begin
            //     case(cnt_mo)
            //         7'd1: day_total_in_mo <= 5'd31;
            //         7'd2: day_total_in_mo <= 5'd28;
            //         7'd3: day_total_in_mo <= 5'd31;
            //         7'd4: day_total_in_mo <= 5'd30;
            //         7'd5: day_total_in_mo <= 5'd31;
            //         7'd6: day_total_in_mo <= 5'd30;
            //         7'd7: day_total_in_mo <= 5'd31;
            //         7'd8: day_total_in_mo <= 5'd31;
            //         7'd9: day_total_in_mo <= 5'd30;
            //         7'd10: day_total_in_mo <= 5'd31;
            //         7'd11: day_total_in_mo <= 5'd30;
            //         7'd12: day_total_in_mo <= 5'd31;               
            //     endcase
            // end 
            if(pulse_1d & enable_cnt_d) begin
                if (day_counter == day_total_in_mo) day_counter <= 6'd1; // Reset hour_counter when it = 23
                else day_counter <= day_counter + 1;
            end else if(enable_cnt_d == 0) begin
                if(increase_d == 1) begin 
                    if (day_counter == day_total_in_mo) day_counter <= 6'd1;
                    else day_counter <= day_counter + 1;
                end else if(decrease_d == 1) begin
                    if (day_counter == 0) day_counter <= day_total_in_mo;
                    else day_counter <= day_counter - 1;
                end
            end
		end
    end
    assign pulse_1mo = (day_counter == day_total_in_mo) & pulse_1d ;
    assign cnt_d = day_counter;
endmodule