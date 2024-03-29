module clk_1second (
    input clk_50MHz,
    input rst,
    output reg sig_1s
);

localparam divider = 49999999;
reg [31:0] counter;

always @(posedge clk_50MHz or negedge rst) begin
    if (~rst) begin      // reset khi clock o? muc logic 0
        counter <= 0;
        sig_1s <= 1; 
    end else begin
        if(counter == divider)begin
            sig_1s <= 1;
            counter <= 0;
        end else begin
            sig_1s <= 0;
            counter <= counter + 1;
           end
    end
end
endmodule








