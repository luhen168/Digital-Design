module control_cnt (
    input clk,
    input rst,
    input pulse_1s,
    input increase_signal, decrease_signal,  // có thể thay thế 
	 input enable_cnt_s, enable_cnt_mi, enable_cnt_h,
	 input enable_cnt_d, enable_cnt_mo, enable_cnt_y_ten_unit, enable_cnt_y_thousand_hundred,
    output [5:0] cnt_s, cnt_mi, cnt_h, cnt_d, cnt_mo,
    output [6:0] cnt_y_ten_unit, cnt_y_thousand_hundred
);
    wire pulse_1mi, pulse_1h, pulse_1d, pulse_1mo, pulse_y_ten_unit, pulse_y_thousand_hundred;

    // Connect to modules counter ss,mm,hh- dd,mm,yy 
    cnt_s inst_cnt_s (
        .clk(clk),
		.rst(rst),
        .enable_cnt_s(enable_cnt_s),
        .pulse_1s(pulse_1s),
        .increase_s(increase_signal),
        .decrease_s(decrease_signal),
        .pulse_1mi (pulse_1mi),
        .cnt_s(cnt_s)
    );

    cnt_mi inst_cnt_mi (
        .clk(clk),
		.rst(rst),
        .enable_cnt_mi(enable_cnt_mi),
        .pulse_1mi(pulse_1mi),
        .increase_mi(increase_signal),
        .decrease_mi(decrease_signal),
        .pulse_1h (pulse_1h),
        .cnt_mi(cnt_mi)
    );

    cnt_h inst_cnt_h (
        .clk(clk),
		.rst(rst),
        .enable_cnt_h(enable_cnt_h),
        .pulse_1h(pulse_1h),
        .increase_h(increase_signal),
        .decrease_h(decrease_signal),
        .pulse_1d (pulse_1d),
        .cnt_h(cnt_h)
    );

    cnt_d inst_cnt_d (
        .clk(clk),
		.rst(rst),
        .enable_cnt_d(enable_cnt_d),
        .pulse_1d(pulse_1d),
        .cnt_y_ten_unit(cnt_y_ten_unit),
        .cnt_mo(cnt_mo),
        .increase_d(increase_signal),
        .decrease_d(decrease_signal),
        .pulse_1mo (pulse_1mo),
        .cnt_d(cnt_d)
    );

    cnt_mo inst_cnt_mo (
        .clk(clk),
		.rst(rst),
        .enable_cnt_mo(enable_cnt_mo),
        .pulse_1mo(pulse_1mo),
        .increase_mo(increase_signal),
        .decrease_mo(decrease_signal),
        .pulse_y_ten_unit (pulse_y_ten_unit),
        .cnt_mo(cnt_mo)
    );

    cnt_y_ten_unit inst_cnt_y_ten_unit (
        .clk(clk),
		.rst(rst),
        .enable_cnt_y_ten_unit(enable_cnt_y_ten_unit),
        .pulse_y_ten_unit(pulse_y_ten_unit),
        .increase_y(increase_signal),
        .decrease_y(decrease_signal),
        .pulse_y_thousand_hundred(pulse_y_thousand_hundred),
        .cnt_y_ten_unit(cnt_y_ten_unit)
    );

    cnt_y_thousand_hundred inst_cnt_y_thousand_hundred (
        .clk(clk),
        .rst(rst),
        .pulse_y_thousand_hundred(pulse_y_thousand_hundred),
        .increase_y_thousand_hundred(increase_signal), 
        .decrease_y_thousand_hundred(decrease_signal), 
        .enable_cnt_y_thousand_hundred(enable_cnt_y_thousand_hundred),
        .cnt_y_thousand_hundred(cnt_y_thousand_hundred)
    );
endmodule