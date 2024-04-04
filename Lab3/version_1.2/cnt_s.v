module cnt_s (
    input clk,
    input rst,
    input pulse_1s,
    input increase_s, decrease_s, enable_cnt_s,
    output [5:0] cnt_s,
    output pulse_1mi 
);
    reg [5:0] sec_counter;
    reg pulse_1mi_reg;      // pulse_1mi_reg will update immediatly when sec_counter goes from 59 to 0

    always @(posedge clk or negedge rst)begin
        if (~rst) begin
            sec_counter <= 6'd0;
            pulse_1mi_reg <= 1'b1;
        end else begin
            if (enable_cnt_s) begin
                if (pulse_1s) begin
                    if (sec_counter == 6'd59) sec_counter <= 6'd0;
                    else sec_counter <= sec_counter + 1;    
                end
                pulse_1mi_reg <= (sec_counter == 6'd59) && (pulse_1s);
            end else begin
                if(increase_s == 1) begin 
                    if (sec_counter == 6'd59) sec_counter <= 6'd0;
                    else sec_counter <= sec_counter + 1;
                end else if (decrease_s == 1) begin
                    if (sec_counter == 0) sec_counter <= 6'd59;
                    else sec_counter <= sec_counter - 1;
                end
                pulse_1mi_reg <= 1'b0;
            end 
        end
    end

    assign pulse_1mi = pulse_1mi_reg;
    assign cnt_s = sec_counter; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule