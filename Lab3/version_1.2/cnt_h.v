module cnt_h (
    input clk,
    input rst,
    input pulse_1h,
    input increase_h, decrease_h, enable_cnt_h,
    output [5:0] cnt_h,
    output pulse_1d 
);
    reg [5:0] sec_counter;
    reg pre_increase_h, pre_decrease_h;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin
            sec_counter <= 6'd0;
            pre_increase_h <= 1;
            pre_decrease_h <= 1;
        end else begin
            if (enable_cnt_h) begin
                if (pulse_1h) begin
                    if (sec_counter == 6'd59) sec_counter <= 6'd0;
                    else sec_counter <= sec_counter + 1;   
                end

                if(increase_h != pre_increase_h) begin
                    pre_increase_h <= increase_h;
                    if (increase_h == 0) begin
                        if (sec_counter == 6'd59) sec_counter <= 6'd0;
                        else sec_counter <= sec_counter + 1;
                    end
                end else
                if(decrease_h != pre_decrease_h) begin
                    pre_decrease_h <= decrease_h;
                    if (decrease_h == 0) begin
                        if (sec_counter == 6'd00) sec_counter <= 6'd59;
                        else sec_counter <= sec_counter - 1;
                    end
                end
            end 
        end
    end
    assign pulse_1d = (sec_counter == 6'd59) & pulse_1h;
    assign cnt_h = sec_counter; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule