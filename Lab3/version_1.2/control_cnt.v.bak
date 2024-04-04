module control_cnt (
    input clk,
    input rst,
    input pulse_1s,
    input increase_s, decrease_s, enable_cnt_s,
    input increase_mi, decrease_mi, enable_cnt_mi,
    input increase_h, decrease_h, enable_cnt_h,
    input increase_d, decrease_d, enable_cnt_d,
    input increase_mo, decrease_mo, enable_cnt_mo,
   	input increase_y, decrease_y, enable_cnt_y,
    output [5:0] cnt_s, cnt_mi, cnt_h, cnt_d, cnt_mo,
    output [6:0] cnt_y_ten_unit, cnt_y_thousand_hundred,
);
    wire pulse_1mi, pulse_1h, pulse_1d, pulse_1mo, pulse_1y;
    wire pulse_increase, pulse_decrease;

    // Connect to modules counter ss,mm,hh- dd,mm,yy 
    cnt_s cnt_s (
        .clk(clk),
		.rst(rst),
        .enable_cnt_s(enable_cnt_s),
        .pulse_1s(pulse_1s),
        .increase_s(increase_s),
        .decrease_s(decrease_s),
        .pulse_1mi (pulse_1mi),
        .cnt_s(cnt_s)
    );

    cnt_mi cnt_mi (
        .clk(clk),
		.rst(rst),
        .enable_cnt_mi(enable_cnt_mi),
        .pulse_1mi(pulse_1mi),
        .increase_mi(increase_mi),
        .decrease_mi(decrease_mi),
        .pulse_1h (pulse_1h),
        .cnt_mi(cnt_mi)
    );

    cnt_h cnt_h (
        .clk(clk),
		.rst(rst),
        .enable_cnt_h(enable_cnt_h),
        .pulse_1h(pulse_1h),
        .increase_h(increase_h),
        .decrease_h(decrease_h),
        .pulse_1d (pulse_1d)
        .cnt_h(cnt_h)
    );

    cnt_d cnt_d (
        .clk(clk),
		.rst(rst),
        .enable_cnt_d(enable_cnt_d),
        .pulse_1d(pulse_1d),
        .cnt_y_ten_unit(cnt_y_ten_unit),
        .cnt_mo(cnt_mo),
        .increase_d(increase_d),
        .decrease_d(decrease_d),
        .pulse_1mo (pulse_1mo),
        .cnt_d(cnt_d)
    );

    cnt_mo cnt_mo (
        .clk(clk),
		.rst(rst),
        .enable_cnt_mo(enable_cnt_mo),
        .pulse_1mo(pulse_1mo),
        .increase_mo(increase_mo),
        .decrease_mo(decrease_mo),
        .pulse_1y (pulse_1y),
        .cnt_mo(cnt_mo)
    );

    cnt_y_ten_unit cnt_y_ten_unit (
        .clk(clk),
		.rst(rst),
        .enable_cnt_y(enable_cnt_y),
        .pulse_1y(pulse_1y),
        .increase_y(increase_y),
        .decrease_y(decrease_y),
        .pulse_increase(pulse_increase),
        .pulse_decrease(pulse_decrease),
        .cnt_y_ten_unit(cnt_y_ten_unit)
    );

    cnt_y_thousand_hundred cnt_y_thousand_hundred (
        .clk(clk),
		.rst(rst),
        .enable_cnt_y(enable_cnt_y),
        .pulse_increase(pulse_increase),
        .pulse_decrease(pulse_decrease),
        .cnt_y_thousand_hundred(cnt_y_thousand_hundred)
    );
endmodule