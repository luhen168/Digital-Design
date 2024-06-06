module cnt_s (
    input clk,
    input rst,
    input pulse_1s,
    input increase_s, 
	 input decrease_s, 
	 input enable_cnt_s,
    output [5:0] cnt_s, // var type net is wire 
    output pulse_1mi 
);
    reg [5:0] cnt;
    reg pre_increase_s, pre_decrease_s;     // store status edge button
    
    always @(posedge clk or negedge rst )begin
        if (~rst) begin      
            cnt <= 6'd0;
            pre_increase_s <= 1;
            pre_decrease_s <= 1;
        end else begin
            if (enable_cnt_s) begin  // if enable_cnt_s = 1 
                if (pulse_1s) begin  // if pulse_1s = 1
                    if (cnt == 6'd59) cnt <= 6'd0;
                    else cnt <= cnt + 1;   
                end

                if(increase_s != pre_increase_s) begin      // if increase_button # pre is not run  
                    pre_increase_s <= increase_s;           // store state into pre_increase_s 
                    if (increase_s == 0) begin              // if increase_s = 0 -> cnt value , press and release   
                        if (cnt == 6'd59) cnt <= 6'd0;
                        else cnt <= cnt + 1;
                    end
                end else if(decrease_s != pre_decrease_s) begin      
                    pre_decrease_s <= decrease_s;
                    if (decrease_s == 0) begin
                        if (cnt == 6'd00) cnt <= 6'd59;
                        else cnt <= cnt - 1;
                    end
                end
            end 
        end
    end
    assign pulse_1mi = (cnt == 6'd59) & pulse_1s;
    assign cnt_s = cnt; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule