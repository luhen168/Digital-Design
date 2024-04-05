module cnt_mi (
    input clk,     
    input rst,
    input pulse_1mi,
    input increase_mi, decrease_mi, enable_cnt_mi,
    output [5:0] cnt_mi, // var type net is wire 
    output pulse_1h 
);
    reg [5:0] minute_counter; 
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            minute_counter <= 6'd0;
        end else begin 
            if (pulse_1mi & enable_cnt_mi) begin
                if (minute_counter == 6'd59) minute_counter <= 6'd0;
                else minute_counter <= minute_counter + 1;
            end else if(enable_cnt_mi == 0) begin
                if(increase_mi == 1) begin 
                    if (minute_counter == 6'd59) minute_counter <= 6'd0;
                    else minute_counter <= minute_counter + 1;
                end else if(decrease_mi == 1) begin
                    if (minute_counter == 0) minute_counter <= 6'd59;
                    else minute_counter <= minute_counter - 1;
                end
            end
        end 
    end
    assign pulse_1h = (minute_counter == 6'd59) & pulse_1mi ;
    assign cnt_mi = minute_counter;
endmodule