module fsm_mode(
    input clk,
    input rst,
    input mode_button,
    output reg [3:0] state
);
    
reg [3:0] state_next;

    parameter NORMAL = 000;
    parameter SS = 001;
    parameter MI = 010;
    parameter HH = 011;
    parameter DD = 100;
    parameter MO = 101;
    parameter YY = 110;

always@(posedge clk or negedge rst)
begin 
    if(~rst)
      state <= 0;
    else 
       state <= state_next;
       
    /////
     case(state)
       NORMAL: if(mode_button)
                   state_next <= SS;
                else 
                   state_next <= NORMAL;
       SS: if(mode_button)
             state_next <= MI;
           else 
             state_next <= SS;
       MI: if(mode_button)
              state_next <= HH;
           else 
              state_next <= MI;
       HH: if(mode_button)
             state_next <= DD;
           else 
              state_next <= HH;
       DD: if(mode_button)
              state_next <= MO;
            else
              state_next <= DD;
       MO: if(mode_button)
              state_next <= YY;
           else 
              state_next <= MO;
       YY: if(mode_button)
             state_next <= NORMAL;
           else     
             state_next <= YY;
       default: state_next <= state;
   endcase   
end  
endmodule
