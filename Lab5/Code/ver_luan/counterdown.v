module cnt_controller (
    input clk,
    input rst,
    input pulse_1s,
    input pulse_pd, 
	input pulse_nopd, 
    output [5:0] cnt_down_pd, // var type net is wire
    output [5:0] cnt_down_nopd, // var type net is wire  
    output timeout_pd, timeout_nopd
);

endmodule

module cnt_down ( 
    input clk,
    input rst,
    input pulse_1s,
	input [1:0] sel_led, 
    output [5:0] cnt_down, // var type net is wire  
    output timeout, Timeout
);

    localparam green = 3'd8;
    localparam yellow = 3'd2;
    localparam red = 3'd10;
    
    always @(posedge clk or negedge rst )begin
        if (~rst) begin      
            sel_led <= 3'd11;
        end else begin
            if (sel_led == 2'd00 && pulse_1s) green = green - 1 ;  
            else if (sel_led == 2'd01 && pulse_1s) yellow = yellow - 1; 
            else if (sel_led == 2'd10 && pulse_1s) red = red - 1;
        end
    end
    assign timeout = (yellow == 1) & pulse_1s;
    assign Timeout = (green == 1) & pulse_1s;
    assign cnt_down = cnt; // gan' ouput de? muc dich hien thi led 7 thanh

endmodule 