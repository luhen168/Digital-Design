module cnt_mi (
    input clk,
    input rst,
    input pulse_1mi,
    input increase_mi, decrease_mi, enable_cnt_mi,
    output [5:0] cnt_mi,
    output pulse_1h 
);
    reg [5:0] sec_counter;
    reg pre_increase_mi, pre_decrease_mi;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin
            sec_counter <= 6'd0;
            pre_increase_mi <= 1;
            pre_decrease_mi <= 1;
        end else begin
            if (enable_cnt_mi) begin
                if (pulse_1mi) begin
                    if (sec_counter == 6'd59) sec_counter <= 6'd0;
                    else sec_counter <= sec_counter + 1;   
                end

                if(increase_mi != pre_increase_mi) begin
                    pre_increase_mi <= increase_mi;
                    if (increase_mi == 0) begin
                        if (sec_counter == 6'd59) sec_counter <= 6'd0;
                        else sec_counter <= sec_counter + 1;
                    end
                end else
                if(decrease_mi != pre_decrease_mi) begin
                    pre_decrease_mi <= decrease_mi;
                    if (decrease_mi == 0) begin
                        if (sec_counter == 6'd00) sec_counter <= 6'd59;
                        else sec_counter <= sec_counter - 1;
                    end
                end
            end 
        end
    end
    assign pulse_1h = (sec_counter == 6'd59) & pulse_1mi;
    assign cnt_mi = sec_counter; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule