module cnt_button_press(
    input wire clk,
    input wire rst,
    input wire button,
    output reg signal
);

// Constants
localparam integer DEBOUNCE_LIMIT = 2500000; // 50ms debounce time
localparam integer PRESS_LIMIT = 15000000; // 300ms press time

// Internal signals
reg [23:0] debounce_counter = 0;
reg [23:0] press_counter = 0;
reg button_debounced = 0;
reg button_pressed = 0;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        // Asynchronous reset
        debounce_counter <= 0;
        press_counter <= 0;
        button_debounced <= 0;
        button_pressed <= 0;
        signal <= 0;
    end else begin
        // Button debounce logic
        if (button == button_debounced) begin
            debounce_counter <= 0;
        end else begin
            debounce_counter <= debounce_counter + 1;
            if (debounce_counter >= DEBOUNCE_LIMIT) begin
                button_debounced <= button;
                debounce_counter <= 0;
            end
        end

        // Button press detection logic
        if (button_debounced && !button_pressed) begin
            // Rising edge detected
            signal <= 1;
            button_pressed <= 1;
            press_counter <= 0;
        end else begin
            signal <= 0;
            if (button_pressed) begin
                if (button_debounced) begin
                    // Button is still pressed
                    press_counter <= press_counter + 1;
                    if (press_counter >= PRESS_LIMIT) begin
                        // Button pressed for 300ms
                        signal <= 1;
                        press_counter <= 0;
                    end
                end else begin
                    // Button released
                    button_pressed <= 0;
                    press_counter <= 0;
                end
            end
        end
    end
end

endmodule
