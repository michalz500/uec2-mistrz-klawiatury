`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2019 16:31:47
// Design Name: 
// Module Name: draw_background
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module draw_background(
    input wire pclk,
    input wire vsync_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
    input wire [10:0] vcount_in,
    input wire [10:0] hcount_in,
    input wire [11:0] rgb_in,
    
    output reg hsync_out,
    output reg vsync_out,
    output reg [11:0] rgb_out
    );
    
    reg [10:0] hcount;
    reg [10:0] vcount;
    reg hsync;
    reg vsync;
    reg hblnk;
    reg vblnk;
    reg [11:0] rgb;
    
always @(posedge pclk)
begin
    hsync_out <= hsync;
    vsync_out <= vsync;
    rgb_out <= rgb;
end

always @*
begin
    
    hsync = hsync_in;
    vsync = vsync_in;
    if (vblnk_in || hblnk_in) rgb <= 12'h0_0_0; 
        else
        begin
            if (vcount_in >= 0 && vcount_in <= 8) rgb <= 12'h888;
            else if (hcount_in >= 0 && hcount_in <= 8) rgb <= 12'h888;
            else if (hcount_in >= 791 && hcount_in <= 799) rgb <= 12'h888;
            else if (hcount_in >= 8 && hcount_in <= 791 && vcount_in >= 591 && vcount_in <= 599)  rgb = 12'h0_0_0;
           
            else if (rgb_in != 12'h000)  rgb = rgb_in;
            
            else rgb <= 12'h000; 
        end

end
    
    
    
endmodule
