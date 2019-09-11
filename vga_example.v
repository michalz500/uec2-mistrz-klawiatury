// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_example (
  input wire clk,
  
  inout wire ps2_clk,
  inout wire ps2_data,
  
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b,
  output wire pclk_mirror
  );

  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.

  wire clk_in;
  wire locked;
  wire clk_fb;
  wire clk_ss;
  wire clk_out;
  wire pclk;
  wire clk100M;
  wire reset;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg [7:0] safe_start = 0;

/*  IBUF clk_ibuf (.I(clk),.O(clk_in));

  MMCME2_BASE #(
    .CLKIN1_PERIOD(10.000),
    .CLKFBOUT_MULT_F(10.000),
    .CLKOUT0_DIVIDE_F(25.000))
  clk_in_mmcme2 (
    .CLKIN1(clk_in),
    .CLKOUT0(clk_out),
    .CLKOUT0B(),
    .CLKOUT1(),
    .CLKOUT1B(),
    .CLKOUT2(),
    .CLKOUT2B(),
    .CLKOUT3(),
    .CLKOUT3B(),
    .CLKOUT4(),
    .CLKOUT5(),
    .CLKOUT6(),
    .CLKFBOUT(clkfb),
    .CLKFBOUTB(),
    .CLKFBIN(clkfb),
    .LOCKED(locked),
    .PWRDWN(1'b0),
    .RST(1'b0)
  );

  BUFH clk_out_bufh (.I(clk_out),.O(clk_ss));
  always @(posedge clk_ss) safe_start<= {safe_start[6:0],locked};

  BUFGCE clk_out_bufgce (.I(clk_out),.CE(safe_start[7]),.O(pclk));
*/
  // Mirrors pclk on a pin for use by the testbench;
  // not functionally required for this design to work.

  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );
  
  clk_wiz_0 clk_signals (
    .clk40MHz(pclk),
    .clk100MHz(clk100M),
    .locked(locked),
    .clk(clk),
    .reset(reset)
  );

  // Instantiate the vga_timing module, which is
  // the module you are designing for this lab.
  wire [11:0] rgb_out, rgb1;
  wire [10:0] vcount, hcount;
  wire vsync, hsync, vsync_out, hsync_out;
  wire vblnk, hblnk;
  wire [13:0] rect;
  wire [4:0] keycode;
  

  vga_timing my_timing (
    .vcount(vcount),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .pclk(pclk)
  );
    
    
    draw_background vga_draw (
    .hcount_in(hcount),
    .hsync_in(hsync),
    .vcount_in(vcount),
    .vblnk_in(vblnk),
    .hblnk_in(hblnk),
    .vsync_in(vsync),
    .pclk(pclk),
    .rgb_in(rgb1),
    
    .hsync_out(hsync_out),
    .vsync_out(vsync_out),
    .rgb_out(rgb_out)
    );
    
    control my_control(
    .keycode(keycode),
    .pclk(pclk),
    .clk(clk100M),
    .hcount(hcount),
    .vcount(vcount),
        
    .rgb_out(rgb1)
    );
    
    keyboard_reciever my_keyboard(
    .clk(clk100M),
    .PS2Data(ps2_data),
    .PS2Clk(ps2_clk),
         
    .Code(keycode)
    );
  
always @(posedge pclk)
begin
// Just pass these through.
    hs <= hsync_out;
    vs <= vsync_out;
    {r,g,b} <= rgb_out;
end

endmodule
