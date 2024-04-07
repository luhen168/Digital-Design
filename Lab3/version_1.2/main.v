module main (
    input clk, rst,
    input mode_button, increase_button, decrease_button,
    input display_switch,

    output [13:0] FPGA_led_12,
    output [13:0] FPGA_led_34,
    output [13:0] FPGA_led_56,
    output [13:0] FPGA_led_78,

    output [13:0] FPGA_led_s, FPGA_led_mi, FPGA_led_h
);

    localparam NORMAL = 3'b000;
    localparam SS = 3'b001;
    localparam MI = 3'b010;
    localparam HH = 3'b011;
    localparam DD = 3'b100;
    localparam MO = 3'b101;
    localparam YY = 3'b110;
    localparam YY2 = 3'b111;

    wire [6:0] enable_display;
    wire [6:0] enable_cnt;
    wire enable_pulse_1s;
    wire [2:0] state;
    
    wire pulse_1s, pulse_1mi, pulse_1h;
    wire [5:0] cnt_s, cnt_mi, cnt_h, cnt_d, cnt_mo;
    wire [6:0] cnt_y_ten_unit, cnt_y_thousand_hundred;
    wire [13:0] FPGA_led_d, FPGA_led_mo, FPGA_led_y_ten_unit, FPGA_led_y_thousand_hundred;

    reg display_switch_signal;
    reg increase_signal, decrease_signal;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            display_switch_signal = 0;
            increase_signal = 1;
            decrease_signal = 1;
        end
        else begin
            if (state != NORMAL) begin
                if (state == HH || state == MI || state == SS) 
                    display_switch_signal = 0;
                else
                    display_switch_signal = 1;

                increase_signal = increase_button;
                decrease_signal = decrease_button;
            end
            else begin
                display_switch_signal = display_switch;
                increase_signal = 1;
                decrease_signal = 1;
            end
        end
    end

    // button_detect inst_button_detect (
    //     .clk(clk),
    //     .rst(rst),
    //     .increase_button(increase_button),
    //     .decrease_button(decrease_button),
    //     .increase_signal(increase_signal),
    //     .decrease_signal(decrease_signal)
    // );

    pulse_1s inst_pulse_1s (
        .clk(clk), 
        .enable_pulse_1s(enable_pulse_1s), 
        .rst(rst), 
        .pulse_1s(pulse_1s)
    );

    cnt_s inst_cnt_s (
        .clk(clk), 
        .rst(rst), 
        .pulse_1s(pulse_1s),
        .increase_s(increase_signal),
        .decrease_s(decrease_signal),
        .enable_cnt_s(enable_cnt[0]),
        .cnt_s(cnt_s),
        .pulse_1mi(pulse_1mi)
    );

    cnt_mi inst_cnt_mi (
        .clk(clk), 
        .rst(rst), 
        .pulse_1mi(pulse_1mi),
        .increase_mi(increase_signal),
        .decrease_mi(decrease_signal),
        .enable_cnt_mi(enable_cnt[1]),
        .cnt_mi(cnt_mi),
        .pulse_1h(pulse_1h)
    );

    cnt_h inst_cnt_h (
        .clk(clk), 
        .rst(rst), 
        .pulse_1h(pulse_1h),
        .increase_h(increase_signal),
        .decrease_h(decrease_signal),
        .enable_cnt_h(enable_cnt[2]),
        .cnt_h(cnt_h),
        .pulse_1d(pulse_1d)
    );

    cnt_d inst_cnt_d (
        .clk(clk), 
        .rst(rst), 
        .pulse_1d(pulse_1d), 
        .increase_d(increase_signal), 
        .decrease_d(decrease_signal), 
        .enable_cnt_d(enable_cnt[6]), 
        .cnt_y_ten_unit(cnt_y_ten_unit), 
        .cnt_mo(cnt_mo), 
        .cnt_d(cnt_d), 
        .pulse_1mo(pulse_1mo)
    );

    cnt_mo inst_cnt_mo (
        .clk(clk), 
        .rst(rst), 
        .pulse_1mo(pulse_1mo),
        .increase_mo(increase_signal),
        .decrease_mo(decrease_signal),
        .enable_cnt_mo(enable_cnt[5]),
        .cnt_mo(cnt_mo),
        .pulse_1y(pulse_1y)
    );

    cnt_y_ten_unit inst_cnt_y_ten_unit (
        .clk(clk), 
        .rst(rst), 
        .pulse_y_ten_unit(pulse_1y_ten_unit),
        .increase_y_ten_unit(increase_signal),
        .decrease_y_ten_unit(decrease_signal),
        .enable_cnt_y_ten_unit(enable_cnt[3]),
        .cnt_y_ten_unit(cnt_y_ten_unit),
        .pulse_y_thousand_hundred(pulse_y_thousand_hundred)
    );
    
    cnt_y_thousand_hundred inst_cnt_y_thousand_hundred (
        .clk(clk), 
        .rst(rst), 
        .pulse_y_thousand_hundred(pulse_1y_thousand_hundred),
        .increase_y_thousand_hundred(increase_signal),
        .decrease_y_thousand_hundred(decrease_signal),
        .enable_cnt_y_thousand_hundred(enable_cnt[4]),
        .cnt_y_thousand_hundred(cnt_y_thousand_hundred)
    );
    
    led_s inst_led_s (
        .enable_display(enable_display[0]),
        .cnt_s({1'b0, cnt_s}),
        .led_s(FPGA_led_s)
    );

    led_mi inst_led_mi (
        .enable_display(enable_display[1]),
        .cnt_mi({1'b0, cnt_mi}),
        .led_mi(FPGA_led_mi)
    );

    led_h inst_led_h (
        .enable_display(enable_display[2]),
        .cnt_h({1'b0, cnt_h}),
        .led_h(FPGA_led_h)
    );

    led_d inst_led_d (
        .enable_display(enable_display[6]),
        .cnt_d(cnt_d),
        .led_d(FPGA_led_d)
    );

    led_mo inst_led_mo (
        .enable_display(enable_display[5]),
        .cnt_mo(cnt_mo),
        .led_mo(FPGA_led_mo)
    );

    led_y_ten_unit inst_led_y_ten_unit (
        .enable_display(enable_display[3]),
        .cnt_y_ten_unit(cnt_y_ten_unit),
        .led_y_ten_unit(FPGA_led_y_ten_unit)
    );

    led_y_thousand_hundred inst_led_y_thousand_hundred (
        .enable_display(enable_display[4]),
        .cnt_y_thousand_hundred(cnt_y_thousand_hundred),
        .led_y_thousand_hundred(FPGA_led_y_thousand_hundred)
    );

    control_display_switch inst_control_display_switch (
        .display_switch(display_switch_signal),
        .led_h(FPGA_led_h),
        .led_mi(FPGA_led_mi),
        .led_s(FPGA_led_s),
        .led_d(FPGA_led_d),
        .led_mo(FPGA_led_mo),
        .led_y_ten_unit(FPGA_led_y_ten_unit),
        .led_y_thousand_hundred(FPGA_led_y_thousand_hundred),

        .FPGA_led_12(FPGA_led_12),
        .FPGA_led_34(FPGA_led_34),
        .FPGA_led_56(FPGA_led_56),
        .FPGA_led_78(FPGA_led_78)
    );
    
    fsm_mode inst_fsm_mode (
        .clk(clk),
        .rst(rst),
        .mode_button(mode_button),
        .state(state)
    );

    fsm_state_handler inst_fsm_state_handler (
        .state(state),
        .enable_display(enable_display),
        .enable_cnt(enable_cnt),
        .enable_pulse_1s(enable_pulse_1s)
    );
endmodule