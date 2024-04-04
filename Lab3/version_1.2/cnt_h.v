module cnt_h (
    input clk,
    input rst,
    input pulse_1h,
    input increase_h, decrease_h, enable_cnt_h,
    output [5:0] cnt_h, // var type net is wire 
    output pulse_1d
);

    reg [5:0] hour_counter;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            hour_counter <= 6'd0;
        end else begin
            if(pulse_1h & enable_cnt_h) begin
                if (hour_counter == 6'd23) hour_counter <= 6'd0; // Reset hour_counter when it = 23
                else hour_counter <= hour_counter + 1;
            end else if(enable_cnt_h == 0) begin
                if(increase_h == 1) begin 
                    if (hour_counter == 6'd23) hour_counter <= 6'd0;
                    else hour_counter <= hour_counter + 1;
                end else if(decrease_h == 1) begin
                    if (hour_counter == 0) hour_counter <= 6'd23;
                    else hour_counter <= hour_counter - 1;
                end
            end
        end
    end
    assign pulse_1d = (hour_counter == 6'd23) & pulse_1h ;
    assign cnt_h = hour_counter;
endmodule