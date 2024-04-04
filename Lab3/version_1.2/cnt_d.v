module cnt_d (
    input clk,
    input rst,
    input pulse_1d, 
    input increase_d, decrease_d, enable_cnt_d,
    input [6:0] cnt_y_ten_unit, cnt_mo,
    output [5:0] cnt_d, // var type net is wire 
    output pulse_1mo
);

    reg [5:0] day_counter;
    reg [5:0] day_total_in_mo;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            day_counter <= 6'd1;
        end else begin
            if((cnt_y_ten_unit[1:0] == 2'b00) & (cnt_mo == 6'd2)) day_total_in_mo <= 5'd29; // kiểm tra hai bit cuối 
            else begin
                case(cnt_mo)
                    6'd1: day_total_in_mo <= 5'd31;
                    6'd2: day_total_in_mo <= 5'd28;
                    6'd3: day_total_in_mo <= 5'd31;
                    6'd4: day_total_in_mo <= 5'd30;
                    6'd5: day_total_in_mo <= 5'd31;
                    6'd6: day_total_in_mo <= 5'd30;
                    6'd7: day_total_in_mo <= 5'd31;
                    6'd8: day_total_in_mo <= 5'd31;
                    6'd9: day_total_in_mo <= 5'd30;
                    6'd10: day_total_in_mo <= 5'd31;
                    6'd11: day_total_in_mo <= 5'd30;
                    6'd12: day_total_in_mo <= 5'd31;               
                endcase
            end 
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