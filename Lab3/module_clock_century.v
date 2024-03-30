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
		.sig_1s(sig_1s),            // input from module sig_1s
        .next_minute(next_minute),  // output to incre minute
        .seconds(seconds)           // output for bcd6its
    );

    MinutesCounter inst_min (
        .clk(clk),                  // input 
        .rst(rst),                  // input
        .next_minute(next_minute),  // input  
        .next_hour(next_hour),      // output
        .minutes(minutes)           // output for 7-seg
    );

    HoursCounter inst_hour (
        .clk(clk),                  // input
        .rst(rst),                  // input
        .next_hour(next_hour),      // input
        .next_day (next_day),       // output
        .hours(hours)               // output 
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
        if (~rst) begin      
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
    output next_minute 
);
    reg [5:0] sec_counter;

    always @(posedge clk or negedge rst)begin
        if (~rst) begin      // 
            sec_counter <= 6'd0;
        end else begin
            if (sig_1s == 1) begin
                if (sec_counter == 6'd59) begin
                    sec_counter = 6'd0;
                end else begin
                    sec_counter <= sec_counter + 1;
                end
            end 
        end 
    end
    assign next_minute = (sec_counter == 6'd59) & sig_1s;
    assign seconds = sec_counter; // gan' ouput de? muc dich hien thi led 7 thanh
endmodule

module MinutesCounter (
    input clk,     
    input rst,
    input next_minute,
    output wire [5:0] minutes, // var type net is wire 
    output next_hour 
);
    reg [5:0] minute_counter;  // 

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            minute_counter <= 6'd0;
        end else begin 
            if(next_minute == 1)begin
                if (minute_counter == 6'd59) begin
                    minute_counter <= 6'd0; 
                end else begin
                    minute_counter <= minute_counter + 1;
                end
            end 
        end
    end
    assign next_hour = (minute_counter == 6'd59) & next_minute ;
    assign minutes = minute_counter;
endmodule



module HoursCounter (
    input clk,
    input rst,
    input next_hour,
    output wire [5:0] hours, // var type net is wire 
    output next_day
);

    reg [5:0] hour_counter;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            hour_counter <= 5'd0;
        end else begin
            if(next_hour == 1) begin
                if (hour_counter == 5'd23) begin
                    hour_counter <= 5'd0; // Reset hour_counter when it = 23
                end else begin
                    hour_counter <= hour_counter + 1;
                end
            end
        end
    end
    // assign next_hour = (minute_counter == 6'd59) & next_minute ;
    assign hours = hour_counter;
endmodule