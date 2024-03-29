module module_clock_century (
    input clk,
    input rst,
    output [6:0] unitd_s, tend_s,               // Output 7-bits to seg 
    output [6:0] unitd_m, tend_m,
    output [6:0] unitd_h, tend_h
);
    wire sig_1s;
    wire [5:0] seconds, minutes, hours;         // use wire to bcd and display 7- 
    wire next_minute, next_hour, next_day;      // 

    // 4-bits for each 
    wire [3:0] unit_s, ten_s;
    wire [3:0] unit_m, ten_m;
    wire [3:0] unit_h, ten_h;

    sig_1s inst_sig (
        .clk(clk),                  // input
        .rst(rst),                  // input
        .sig_1s(sig_1s)             // output
    );

    SecondsCounter inst_sec (
        .clk(clk),                  // input
        .rst(rst),                  // input
		.sig_1s(sig_1s),            // input
        .next_minute(next_minute),  // output to incre minute
        .seconds(seconds)           // output for 7-seg
    );

    MinutesCounter inst_min (
        .clk(clk),                  // input 
        .rst(rst),                  // input
        .sig_1s(sig_1s),            // input
        .next_minute(next_minute),  // input to get incre minute
        .next_hour(next_hour),      // output
        .minutes(minutes)           // output 
    );

    HoursCounter inst_hour (
        .clk(clk),                  // input
        .rst(rst),                  // input
        .sig_1s(sig_1s),
        .next_hour(next_hour),
        .next_day (next_day),
        .hours(hours)
    );

    test inst_display (
        .seconds(seconds),
        .minutes(minutes),
        .hours  (hours),
        .tend_h (tend_h),
        .tend_m (tend_m),
        .tend_s (tend_s),
        .unitd_h (unitd_h),
        .unitd_m (unitd_m),
        .unitd_s (unitd_s)
        );
endmodule

module sig_1s (
    input clk,
    input rst,
    output reg sig_1s
);
    // localparam divider = 49999999;
    // localparam divider = 199999;
    localparam divider = 19;

    reg [31:0] counter;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin      // reset khi clock ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â»ÃƒÆ’Ã¢â‚¬Â¦Ãƒâ€šÃ‚Â¸ mÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â»ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â©c logic 0
            counter <= 0;
            sig_1s <= 1;
        end else begin
            if (counter == divider) begin
                sig_1s <= 1;
                counter <= 0;
            end else begin
                sig_1s <= 0;
                counter <= counter + 1;
            end
        end
    end
endmodule

module SecondsCounter (
    input clk,
    input rst,
    input sig_1s,
    output wire [5:0] seconds, // var type net is wire 
    output reg next_minute 
);
    reg [5:0] sec_counter;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin      // reset khi clock ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â»ÃƒÆ’Ã¢â‚¬Â¦Ãƒâ€šÃ‚Â¸ mÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â»ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â©c logic 0
            sec_counter <= 6'b000000;
            next_minute <= 1'b0;
        end else begin
            if (sig_1s == 1) begin
                if (sec_counter == 6'b111011) begin
                    sec_counter = 6'b000000;
                    next_minute = 1'b1;
                end else begin
                    sec_counter <= sec_counter + 1;
                    next_minute <= 1'b0;
                end
            end
        end 
    end
    assign seconds = sec_counter; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule

module MinutesCounter (
    input clk,     
    input rst,
    input sig_1s,
    input next_minute,
    output wire [5:0] minutes, // var type net is wire 
    output reg next_hour 
);
    reg [5:0] minute_counter;  // 

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            minute_counter <= 6'b000000;
            next_hour <= 1'b0;
        end else if(next_minute == 1&& sig_1s == 1)begin
            if (minute_counter == 6'b111011) begin
                minute_counter <= 6'b000000; 
                next_hour <= 1'b1;
            end else begin
                minute_counter <= minute_counter + 1;
                next_hour <= 1'b0;
            end
        end
    end
    assign minutes = minute_counter;
endmodule



module HoursCounter (
    input clk,
    input rst,
    input sig_1s,
    input next_hour,
    output wire [4:0] hours, // var type net is wire 
    output reg next_day
);

    reg [4:0] hour_counter;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            hour_counter <= 5'b00000;
            next_day <= 1'b0;
        end else if(next_hour==1&&sig_1s == 1) begin
            if (hour_counter == 5'b10111) begin
                hour_counter <= 5'b00000; // Reset hour_counter when it = 23
                next_day <= 1'b1;
            end else begin
                hour_counter <= hour_counter + 1;
                next_day <= 1'b0;
            end
        end
    end
    assign hours = hour_counter;
endmodule