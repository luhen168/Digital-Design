module cnt_mo (
    input clk,
    input rst,
    input pulse_1mo,
    input increase_mo, decrease_mo, enable_cnt_mo,
    output [5:0] cnt_mo, // var type net is wire 
    output pulse_1y
);

    reg [5:0] mo_counter;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            mo_counter <= 6'd1;
        end else begin
            if(pulse_1mo & enable_cnt_mo) begin
                if (mo_counter == 6'd12) mo_counter <= 6'd1; // Reset hour_counter when it = 23
                else mo_counter <= mo_counter + 1;
            end else if ( enable_cnt_mo == 0) begin
                if (increase_mo == 0) begin 
                    if (mo_counter == 6'd12) mo_counter <= 6'd1;
                    else mo_counter <= mo_counter + 1;
                end else if (decrease_mo == 0) begin
                    if (mo_counter == 6'd1) mo_counter <= 6'd12;
                    else mo_counter <= mo_counter - 1;
                end 
            end
        end
    end
    assign pulse_1y = (mo_counter == 6'd12) & pulse_1mo ;
    assign cnt_mo = mo_counter;
endmodule