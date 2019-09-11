   module keyboard_reciever(
         input  wire clk,
         input  wire PS2Data,
         input  wire PS2Clk,
         
         output reg [4:0] Code
     );
         reg         CLK50MHZ=0;
         wire [7:0] keycode;

         
         
         always @(posedge(clk))begin
             CLK50MHZ<=~CLK50MHZ;
         end
         
         PS2Receiver uut (
             .clk(CLK50MHZ),
             .kclk(PS2Clk),
             .kdata(PS2Data),
             .keycode(keycode)
         );
                   
always@(*)
begin
 case(keycode[7:0])
     8'h15: Code <= 5'b00001;//Q
     8'h1D: Code <= 5'b00010;//W
     8'h24: Code <= 5'b00011;//E
     8'h2D: Code <= 5'b00100;//R
     8'h2C: Code <= 5'b00101;//T
     8'h35: Code <= 5'b00110;//Y
     8'h3C: Code <= 5'b00111;//U
     8'h43: Code <= 5'b01000;//I
     8'h44: Code <= 5'b01001;//O
     8'h4D: Code <= 5'b01010;//P
     8'h1C: Code <= 5'b01011;//A
     8'h1B: Code <= 5'b01100;//S
     8'h23: Code <= 5'b01101;//D
     8'h2B: Code <= 5'b01110;//F
     8'h34: Code <= 5'b01111;//G
     8'h33: Code <= 5'b10000;//H
     8'h3B: Code <= 5'b10001;//J
     8'h42: Code <= 5'b10010;//K
     8'h4B: Code <= 5'b10011;//L
     8'h1A: Code <= 5'b10100;//Z
     8'h22: Code <= 5'b10101;//X
     8'h21: Code <= 5'b10110;//C
     8'h2A: Code <= 5'b10111;//V
     8'h32: Code <= 5'b11000;//B
     8'h31: Code <= 5'b11001;//N
     8'h3A: Code <= 5'b11010;//M
     8'h5A: Code <= 5'b11011;//Enter
     8'h76: Code <= 5'b11100;//Esc
     default: Code <= 5'b00000;
    endcase
 end
   
 endmodule