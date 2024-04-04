module top_fsm (
    input wire clk,        // Clock signal
    input wire rst,      // RESET signal input
    input wire mode_button,   // Mode button input
    input wire increase_button,

    output [6:0] unitd_s, tend_s,               // Output 7-bits to seg 
    output [6:0] unitd_m, tend_m,
    output [6:0] unitd_h, tend_h
);

    reg [1:0] state;
	localparam NORMAL = 2'b00;

    fsm fsm_inst (
        .clk(clk),
        .rst(rst),
        .mode_button(mode_button),
        .state(state)
    );

    NormalModule Normal_inst (
        .clk(clk),
        .rst(rst),
        .enable(),
        .unitd_s(unitd_s),
        .tend_s(tend_s),
        .unitd_m(unitd_m),
        .tend_m(tend_m),
        .unitd_h(unitd_h),
        .tend_h(tend_h)
    );

    SetTime SetTime_inst (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .state(state),
        .increase_button(increase_button),
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
   always @(mode_button) begin
           case (mode_button)
               NORMAL: enable =  1;
               default: enable = 0;
           endcase
    end

   // always @(posedge clk or negedge rst) begin
   //     if (~rst) begin
   //         state <= NORMAL;
   //     end else begin
   //         case (state)
   //             NORMAL:  
                 
						
   //             default: 

   //         endcase
   //     end
   // end
endmodule

module fsm (
    input wire clk,        // Clock signal
    input wire rst,      // RESET signal input
    input wire mode_button,   // Mode button input
    output reg [1:0] state
);
    // Define state constants
    localparam NORMAL = 2'b00, SS = 2'b01, MM = 2'b10, HH = 2'b11;

    reg [1:0] nextstate;

    always @(mode_button or state) begin
        display_state = 0;
        nextstate = NORMAL;
        case (state)
            NORMAL:
                if (mode_button) nextstate = SS;
            SS:
                if (mode_button) nextstate = MM;
            MM:
                if (mode_button) nextstate = HH;
            HH:
                if (mode_button) nextstate = NORMAL;
        endcase
    end

    // State register
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            state <= NORMAL;
        end else begin
            state <= nextstate;
        end
    end
endmodule

module NormalModule (
    input clk,
    input rst,
    input enable,
    output [6:0] unitd_s, tend_s,               // Output 7-bits to seg 
    output [6:0] unitd_m, tend_m,
    output [6:0] unitd_h, tend_h
);
	initial begin
		 if(enable) begin
			  module_clock_century inst(
					.clk(clk),
					.rst(rst),
					.unitd_s(unitd_s),
					.tend_s(tend_s),
					.unitd_m(unitd_m),
					.tend_m(tend_m),
					.unitd_h(unitd_h),
					.tend_h(tend_h)
			  );
			end
	 end
endmodule

module SetTime (
    input clk,
    input rst,
    input enable,
	 input [1:0] state,
    input increase_button,
    input [5:0] seconds, minutes, hours,    // Input BCD 6-bits
    output [3:0] unit_s, ten_s,				// Output 4-bits
    output [3:0] unit_m, ten_m,
    output [3:0] unit_h, ten_h
);
    localparam [2:0] display_state;

    case (state)
        NORMAL: display_state = 3'b111;
        SS: display_state = 3'b001;
        MM: display_state = 3'b010;
        HH: display_state = 3'b100;
    endcase
  
   
    test inst_display (
        .display_state(display_state),
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

    always @(posedge clk or negedge rst) begin
        if (~rst) begin 
		  end else begin
            if (increase_button & ~enable) begin
                case(state)
                    SS: begin
                        seconds <= seconds + 1;
                        if (seconds >= 60) seconds <= 0;
                    end
                    MM: begin
                        minute <= minute + 1;
                        if (minute >= 60) minute <= 0;
                    end
                    HH: begin
                        hours <= hours + 1;
                        if (hours >= 24) hours <= 0;
                    end
                endcase
            end
        end
    end
endmodule


module SSModule (
    input clk,
    input rst,
    output [6:0] unitd_s, tend_s,               // Output 7-bits to seg 
    output [6:0] unitd_m, tend_m,
    output [6:0] unitd_h, tend_h
);

endmodule

module MMModule (
    input mode_button,
    input active,
    output hh_led,
    output mm_led,
    output ss_led
);
    assign {hh_led, mm_led, ss_led} = active ? 3'b010 : 3'bZ;
endmodule

module HHModule (
    input mode_button,
    input active,
    output hh_led,
    output mm_led,
    output ss_led
);
    assign {hh_led, mm_led, ss_led} = active ? 3'b100 : 3'bZ;
endmodule