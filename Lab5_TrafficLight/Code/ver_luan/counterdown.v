module counterdown (
    input clk,
    input rst,
    input pulse_1s,
    input cnt_pd, 
	input cnt_nopd, 
    output cnt_pd_end, cnt_nopd_end, 
    output [5:0] display_pd, display_nopd
);
    cnt_down cnt_down_pd (
        .clk(clk),
        .rst(rst),
        .pulse_1s(pulse_1s),
        .cnt(cnt_pd),
        .cnt_end(cnt_pd_end),
        .display(display_pd)
    );

    cnt_down cnt_down_nopd (
        .clk(clk),
        .rst(rst),
        .pulse_1s(pulse_1s),
        .cnt(cnt_nopd),
        .cnt_end(cnt_nopd_end),
        .display(display_nopd)
    );
endmodule

module cnt_down ( 
    input clk,
    input rst,
    input pulse_1s,
	input [2:0] cnt, 
    output [5:0] display, 
    output cnt_end
);
    reg [2:0] cnt_buffer;
    
    always @(posedge clk or negedge rst )begin
        if (~rst) begin      
            cnt_buffer <= 3'd0;
        end else begin
            if(cnt != 0 && cnt_buffer == 0) cnt_buffer <= cnt;
            else if(cnt != 0 && pulse_1s == 1) cnt_buffer <= cnt_buffer - 1;
        end
    end
    assign cnt_end = (cnt_buffer == 1) & pulse_1s;
    assign display = cnt_buffer; // gan' ouput de? muc dich hien thi led 7 thanh

endmodule 