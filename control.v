`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 26.08.2019 19:17:08
// Design Name:
// Module Name: control
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
 
 
module control(
    input wire [4:0] keycode,
    input wire pclk,
    input wire clk,
    input wire [10:0] hcount,
    input wire [10:0] vcount,
   
    output reg [11:0] rgb_out
    );
   
    localparam divide = 21;
   
    wire [9:0] address1;
    reg [27:0] obj1 = 0;        
    reg falling1;
    reg [36:0] t1 = 0;
    reg [36:0] t_nxt1 = 0;
    reg [11:0] ypos1_nxt = 0, xpos1_nxt = 0;
   
    wire [9:0] address2;
    reg [27:0] obj2 = 0;        
    reg falling2;
    reg [36:0] t2 = 0;
    reg [36:0] t_nxt2 = 0;
    reg [11:0] ypos2_nxt = 0, xpos2_nxt = 0;
   
    wire [9:0] address3;
    reg [27:0] obj3 = 0;        
    reg falling3;
    reg [36:0] t3 = 0;
    reg [36:0] t_nxt3 = 0;
    reg [11:0] ypos3_nxt = 0, xpos3_nxt = 0;
   
    wire [9:0] address4;
    reg [27:0] obj4 = 0;        
    reg falling4;
    reg [36:0] t4 = 0;
    reg [36:0] t_nxt4 = 0;
    reg [11:0] ypos4_nxt = 0, xpos4_nxt = 0;
   
    wire [9:0] address5;
    reg [27:0] obj5 = 0;       
    reg falling5;
    reg [36:0] t5 = 0;
    reg [36:0] t_nxt5 = 0;
    reg [11:0] ypos5_nxt = 0, xpos5_nxt = 0;
   
    wire [9:0] address6;
    reg [27:0] obj6 = 0;        
    reg falling6;
    reg [36:0] t6 = 0;
    reg [36:0] t_nxt6 = 0;
    reg [11:0] ypos6_nxt = 0, xpos6_nxt = 0;
   
    wire [9:0] address7;
    reg [27:0] obj7 = 0;       
    reg falling7;
    reg [36:0] t7 = 0;
    reg [36:0] t_nxt7 = 0;
    reg [11:0] ypos7_nxt = 0, xpos7_nxt = 0;
   
    wire [9:0] address8;
    reg [27:0] obj8 = 0;        
    reg falling8;
    reg [36:0] t8 = 0;
    reg [36:0] t_nxt8 = 0;
    reg [11:0] ypos8_nxt = 0, xpos8_nxt = 0;
   
    wire [11:0] addressStart;
    reg [27:0] objStart = 28'b1101100101110000000111110100;
   
    wire [11:0] addressGameOver;
    reg [27:0] objGameOver = 28'b1110011111111111111111111110;  
 
   
    reg [11:0] romQ [0:1023];
    reg [11:0] romW [0:1023];
    reg [11:0] romE [0:1023];
    reg [11:0] romR [0:1023];
    reg [11:0] romT [0:1023];
    reg [11:0] romY [0:1023];
    reg [11:0] romU [0:1023];
    reg [11:0] romI [0:1023];
    reg [11:0] romO [0:1023];
    reg [11:0] romP [0:1023];
    reg [11:0] romA [0:1023];
    reg [11:0] romS [0:1023];
    reg [11:0] romD [0:1023];
    reg [11:0] romF [0:1023];
    reg [11:0] romG [0:1023];
    reg [11:0] romH [0:1023];
    reg [11:0] romJ [0:1023];
    reg [11:0] romK [0:1023];
    reg [11:0] romL [0:1023];
    reg [11:0] romZ [0:1023];
    reg [11:0] romX [0:1023];
    reg [11:0] romC [0:1023];
    reg [11:0] romV [0:1023];
    reg [11:0] romB [0:1023];
    reg [11:0] romN [0:1023];
    reg [11:0] romM [0:1023];
   
    reg [11:0] romStart [0:4095];                                             
    reg [11:0] romGameOver [0:4095];
   
    reg [35:0] drop_cnt = 0, drop_cnt_nxt = 0;
    reg [4:0] cnt = 0;
    reg [9:0] xpos_cnt = 0;
    reg [11:0] nxt_pixel = 0;
    reg [10:0] vcountd = 0, hcountd = 0;
     
    assign address1[4:0] = hcountd - obj1[22:12];
    assign address1[9:5] = vcountd - obj1[11:1];
     
    assign address2[4:0] = hcountd - obj2[22:12];
    assign address2[9:5] = vcountd - obj2[11:1];
     
    assign address3[4:0] = hcountd - obj3[22:12];
    assign address3[9:5] = vcountd - obj3[11:1];
     
    assign address4[4:0] = hcountd - obj4[22:12];
    assign address4[9:5] = vcountd - obj4[11:1];  
     
    assign address5[4:0] = hcountd - obj5[22:12];
    assign address5[9:5] = vcountd - obj5[11:1];
           
    assign address6[4:0] = hcountd - obj6[22:12];
    assign address6[9:5] = vcountd - obj6[11:1];
     
    assign address7[4:0] = hcountd - obj7[22:12];
    assign address7[9:5] = vcountd - obj7[11:1];
     
    assign address8[4:0] = hcountd - obj8[22:12];
    assign address8[9:5] = vcountd - obj8[11:1];
         
    assign addressStart[5:0] = hcountd - objStart[22:12]; 
    assign addressStart[11:6] = vcountd - objStart[11:1];      
     
    assign addressGameOver[5:0] = hcountd - objGameOver[22:12];
    assign addressGameOver[11:6] = vcountd - objGameOver[11:1];
           
    initial $readmemh("Q.data", romQ);
    initial $readmemh("W.data", romW);
    initial $readmemh("E.data", romE);
    initial $readmemh("R.data", romR);
    initial $readmemh("T.data", romT);
    initial $readmemh("Y.data", romY);
    initial $readmemh("U.data", romU);
    initial $readmemh("I.data", romI);
    initial $readmemh("O.data", romO);
    initial $readmemh("P.data", romP);
    initial $readmemh("A.data", romA);
    initial $readmemh("S.data", romS);
    initial $readmemh("D.data", romD);
    initial $readmemh("F.data", romF);
    initial $readmemh("G.data", romG);
    initial $readmemh("H.data", romH);
    initial $readmemh("J.data", romJ);
    initial $readmemh("K.data", romK);
    initial $readmemh("L.data", romL);
    initial $readmemh("Z.data", romZ);
    initial $readmemh("X.data", romX);
    initial $readmemh("C.data", romC);
    initial $readmemh("V.data", romV);
    initial $readmemh("B.data", romB);
    initial $readmemh("N.data", romN);
    initial $readmemh("M.data", romM);
    initial $readmemh("start.data", romStart);
    initial $readmemh("game_over.data", romGameOver);
     
      always @(posedge pclk)begin
        rgb_out <= nxt_pixel;    
        vcountd <= vcount;
        hcountd <= hcount;
       
        obj1[0] <= falling1;
        obj1[11:1] <= ypos1_nxt;  
        t1 <= t_nxt1;
       
        obj2[0] <= falling2;
        obj2[11:1] <= ypos2_nxt;  
        t2 <= t_nxt2;
       
        obj3[0] <= falling3;
        obj3[11:1] <= ypos3_nxt;   
        t3 <= t_nxt3;
       
        obj4[0] <= falling4;
        obj4[11:1] <= ypos4_nxt;  
        t4 <= t_nxt4;
               
        obj5[0] <= falling5;
        obj5[11:1] <= ypos5_nxt;  
        t5 <= t_nxt5;        
       
        obj6[0] <= falling6;
        obj6[11:1] <= ypos6_nxt;  
        t6 <= t_nxt6;
       
        obj7[0] <= falling7;
        obj7[11:1] <= ypos7_nxt; 
        t7 <= t_nxt7;
       
        obj8[0] <= falling8;
        obj8[11:1] <= ypos8_nxt; 
        t8 <= t_nxt8;
       
      end
     
      always @(posedge clk)
      begin
        if(keycode == objStart[27:23])
        begin    
        if (drop_cnt == 200_000_000)
            begin
                falling1 <= 1;
                obj1[27:23] <= cnt;          
                obj1[22:12] <= xpos_cnt;
            end
        else if (drop_cnt == 240_000_000)
            begin
                falling2 <= 1;
                obj2[27:23] <= cnt;          
                obj2[22:12] <= xpos_cnt;
            end
        else if (drop_cnt == 280_000_000)
            begin
                falling3 <= 1;
                obj3[27:23] <= cnt;          
                obj3[22:12] <= xpos_cnt;
            end
        else if (drop_cnt == 320_000_000)
            begin
                falling4 <= 1;
                obj4[27:23] <= cnt;          
                obj4[22:12] <= xpos_cnt;
            end
        else if (drop_cnt == 400_000_000)
            begin
                falling5 <= 1;
                obj5[27:23] <= cnt;         
                obj5[22:12] <= xpos_cnt;
            end
        else if (drop_cnt == 480_000_000)
            begin
                falling6 <= 1;
                obj6[27:23] <= cnt;         
                obj6[22:12] <= xpos_cnt;
            end
        else if (drop_cnt == 560_000_000)
            begin
                falling7 <= 1;
                obj7[27:23] <= cnt;         
                obj7[22:12] <= xpos_cnt;
            end
        else if (drop_cnt == 600_000_000)
            begin
                falling8 <= 1;
                obj8[27:23] <= cnt;         
                obj8[22:12] <= xpos_cnt;
             end  
                 
                               
        if (drop_cnt >= 900_000_000)
            drop_cnt <= 0;
        else
            drop_cnt <= drop_cnt + 1;
        end
        
             
        if (cnt == 26)
            cnt <= 1;
        else
             cnt <= cnt + 1;
         
         
         if (xpos_cnt == 750)
            xpos_cnt <= 40;
        else
             xpos_cnt <= xpos_cnt + 1;
            
               
        if(keycode == 27)
        begin
            objStart[22:12] <= 610;
            objStart[11:1] <= 610;
            objStart[27:23] <= 0;
        end            
        else if(keycode == obj1[27:23])
        begin
            falling1 <= 0;
            obj1[27:23] <= 0;
        end  
        else if(keycode == obj2[27:23])
        begin
            falling2 <= 0;
            obj2[27:23] <= 0;
        end
        else if(keycode == obj3[27:23])
        begin
            falling3 <= 0;  
            obj3[27:23] <= 0;  
        end
        else if(keycode == obj4[27:23])
        begin
            falling4 <= 0;
            obj4[27:23] <= 0;
        end     
        else if(keycode == obj5[27:23])
        begin
            falling5 <= 0;  
            obj5[27:23] <= 0;
        end
        else if(keycode == obj6[27:23])
        begin
            falling6 <= 0;
            obj6[27:23] <= 0;
        end         
        else if(keycode == obj7[27:23])
        begin
            falling7 <= 0;  
            obj7[27:23] <= 0;
        end    
        else if (keycode == obj8[27:23])
        begin
            falling8 <= 0;
            obj8[27:23] <= 0;
        end         
      end
    
       
      always @(*)
        begin
            if ((obj1[0] == 1) && (obj1[11:1] < 1))
            begin
                ypos1_nxt = 1;  
            end
            else if ((obj1[0] == 1) && (obj1[11:1] < 600))
            begin
                t_nxt1 = t1 + 1;
                ypos1_nxt = (t1>>divide)*(t1>>divide);
            end
            else if (obj1[11:1] >= 600)
            begin
                objGameOver = 28'b1110000101110000000111110100;
                ypos1_nxt = 610;
                ypos2_nxt = 610;
                ypos3_nxt = 610;
                ypos4_nxt = 610;
                ypos5_nxt = 610;
                ypos6_nxt = 610;
                ypos7_nxt = 610;
                ypos8_nxt = 610;
           end
           else if (obj1[0] == 0)
           begin
                ypos1_nxt = 0;
                t_nxt1 = 0;
           end
            
           if ((obj2[0] == 1) && (obj2[11:1] < 1))
           begin
                ypos2_nxt = 1;  
           end
           else if ((obj2[0] == 1) && (obj2[11:1] < 600))
           begin
                t_nxt2 = t2 + 1;
                ypos2_nxt = (t2>>divide)*(t2>>divide) + 1;
           end
           else if (obj2[11:1] >= 600)
           begin
                objGameOver = 28'b1110000101110000000111110100;
                ypos1_nxt = 610;
                ypos2_nxt = 610;
                ypos3_nxt = 610;
                ypos4_nxt = 610;
                ypos5_nxt = 610;
                ypos6_nxt = 610;
                ypos7_nxt = 610;
                ypos8_nxt = 610;
           end
           else if (obj2[0] == 0)
           begin
                ypos2_nxt = 0;
                t_nxt2 = 0;
           end  
           
           if ((obj3[0] == 1) && (obj3[11:1] < 1))
           begin
                ypos3_nxt = 1;  
           end
           else if ((obj3[0] == 1) && (obj3[11:1] < 600))
           begin
                t_nxt3 = t3 + 1;
                ypos3_nxt = (t3>>divide)*(t3>>divide);
           end
           else if (obj3[11:1] >= 600)
           begin
                objGameOver = 28'b1110000101110000000111110100;
                ypos1_nxt = 610;
                ypos2_nxt = 610;
                ypos3_nxt = 610;
                ypos4_nxt = 610;
                ypos5_nxt = 610;
                ypos6_nxt = 610;
                ypos7_nxt = 610;
                ypos8_nxt = 610;
           end    
           else if (obj3[0] == 0)
           begin
                ypos3_nxt = 0;
                t_nxt3 = 0;
           end
               
           if ((obj4[0] == 1) && (obj4[11:1] < 1))
           begin
                ypos4_nxt = 1;
           end
           else if ((obj4[0] == 1) && (obj4[11:1] < 600))
           begin
                t_nxt4 = t4 + 1;
                ypos4_nxt = (t4>>divide)*(t4>>divide);
           end
           else if (obj4[11:1] >= 600)
           begin
                objGameOver = 28'b1110000101110000000111110100;
                ypos1_nxt = 610;
                ypos2_nxt = 610;
                ypos3_nxt = 610;
                ypos4_nxt = 610;
                ypos5_nxt = 610;
                ypos6_nxt = 610;
                ypos7_nxt = 610;
                ypos8_nxt = 610;
            end
            else if (obj4[0] == 0)
            begin
                ypos4_nxt = 0;
                t_nxt4 = 0;
            end
                                 
            if ((obj5[0] == 1) && (obj5[11:1] < 1))
            begin
                ypos5_nxt = 1;  
            end
            else if ((obj5[0] == 1) && (obj5[11:1] < 600))
            begin
                t_nxt5 = t5 + 1;
                ypos5_nxt = (t5>>divide)*(t5>>divide);
            end
            else if (obj5[11:1] >= 600)
            begin
                objGameOver = 28'b1110000101110000000111110100;
                ypos1_nxt = 610;
                ypos2_nxt = 610;
                ypos3_nxt = 610;
                ypos4_nxt = 610;
                ypos5_nxt = 610;
                ypos6_nxt = 610;
                ypos7_nxt = 610;
                ypos8_nxt = 610;
            end
            else if (obj5[0] == 0)
            begin
                ypos5_nxt = 0;
                t_nxt5 = 0;
            end
               
            if ((obj6[0] == 1) && (obj6[11:1] < 1))
            begin
                ypos6_nxt = 1;   
            end
            else if ((obj6[0] == 1) && (obj6[11:1] < 600))
            begin
                t_nxt6 = t6 + 1;
                ypos6_nxt = (t6>>divide)*(t6>>divide);
            end
            else if (obj6[11:1] >= 600)
            begin
                objGameOver = 28'b1110000101110000000111110100;
                ypos1_nxt = 610;
                ypos2_nxt = 610;
                ypos3_nxt = 610;
                ypos4_nxt = 610;
                ypos5_nxt = 610;
                ypos6_nxt = 610;
                ypos7_nxt = 610;
                ypos8_nxt = 610;
            end
            else if (obj6[0] == 0)
            begin
                ypos6_nxt = 0;
                t_nxt6 = 0;
            end
 
            if ((obj7[0] == 1) && (obj7[11:1] < 1))
            begin
                ypos7_nxt = 1;  
            end
            else if ((obj7[0] == 1) && (obj7[11:1] < 600))
            begin
                t_nxt7 = t7 + 1;
                ypos7_nxt = (t7>>divide)*(t7>>divide);
            end
            else if (obj7[11:1] >= 600)
            begin
                objGameOver = 28'b1110000101110000000111110100;
                ypos1_nxt = 610;
                ypos2_nxt = 610;
                ypos3_nxt = 610;
                ypos4_nxt = 610;
                ypos5_nxt = 610;
                ypos6_nxt = 610;
                ypos7_nxt = 610;
                ypos8_nxt = 610;
            end
            else if (obj7[0] == 0)
            begin
                ypos7_nxt = 0;
                t_nxt7 = 0;
            end
               
            if ((obj8[0] == 1) && (obj8[11:1] < 1))
            begin
                ypos8_nxt = 1;   
            end
            else if ((obj8[0] == 1) && (obj8[11:1] < 600))
            begin
                t_nxt8 = t8 + 1;
                ypos8_nxt = (t8>>divide)*(t8>>divide);
            end
            else if (obj8[11:1] >= 600)
            begin
                objGameOver = 28'b1110000101110000000111110100;
                ypos1_nxt = 610;
                ypos2_nxt = 610;
                ypos3_nxt = 610;
                ypos4_nxt = 610;
                ypos5_nxt = 610;
                ypos6_nxt = 610;
                ypos7_nxt = 610;
                ypos8_nxt = 610;
            end
            else if (obj8[0] == 0)
            begin
                ypos8_nxt = 0;
                t_nxt8 = 0;
            end
           
        end
 
         
      always @* begin
        if(
          (objStart[22:12] <= hcountd) &&                      
          (objStart[22:12] + 64 > hcountd) &&
          (objStart[11:1] <= vcountd) &&
          (objStart[11:1] + 64 > vcountd))
            nxt_pixel = romStart[addressStart];
        else if(
          (objGameOver[22:12] <= hcountd) &&
          (objGameOver[22:12] + 64 > hcountd) &&
          (objGameOver[11:1] <= vcountd) &&
          (objGameOver[11:1] + 64 > vcountd))
            nxt_pixel = romGameOver[addressGameOver];
        else if(
          (obj1[22:12] <= hcountd) &&
          (obj1[22:12] + 32 > hcountd) &&
          (obj1[11:1] <= vcountd) &&
          (obj1[11:1]+32 > vcountd))
            case(obj1[27:23])
              5'd1: nxt_pixel = romQ[address1];
              5'd2: nxt_pixel = romW[address1];
              5'd3: nxt_pixel = romE[address1];
              5'd4: nxt_pixel = romR[address1];
              5'd5: nxt_pixel = romT[address1];
              5'd6: nxt_pixel = romY[address1];
              5'd7: nxt_pixel = romU[address1];
              5'd8: nxt_pixel = romI[address1];
              5'd9: nxt_pixel = romO[address1];
              5'd10: nxt_pixel = romP[address1];
              5'd11: nxt_pixel = romA[address1];
              5'd12: nxt_pixel = romS[address1];
              5'd13: nxt_pixel = romD[address1];
              5'd14: nxt_pixel = romF[address1];
              5'd15: nxt_pixel = romG[address1];
              5'd16: nxt_pixel = romH[address1];
              5'd17: nxt_pixel = romJ[address1];
              5'd18: nxt_pixel = romK[address1];
              5'd19: nxt_pixel = romL[address1];
              5'd20: nxt_pixel = romZ[address1];
              5'd21: nxt_pixel = romX[address1];
              5'd22: nxt_pixel = romC[address1];
              5'd23: nxt_pixel = romV[address1];
              5'd24: nxt_pixel = romB[address1];
              5'd25: nxt_pixel = romN[address1];
              5'd26: nxt_pixel = romM[address1];
              default: nxt_pixel = 12'h000;
             endcase
         
        else if(
          (obj2[22:12] <= hcountd) &&
          (obj2[22:12] + 32 > hcountd) &&
          (obj2[11:1] <= vcountd) &&
          (obj2[11:1]+32 > vcountd))
             case(obj2[27:23])
              5'd1: nxt_pixel = romQ[address2];
              5'd2: nxt_pixel = romW[address2];
              5'd3: nxt_pixel = romE[address2];
              5'd4: nxt_pixel = romR[address2];
              5'd5: nxt_pixel = romT[address2];
              5'd6: nxt_pixel = romY[address2];
              5'd7: nxt_pixel = romU[address2];
              5'd8: nxt_pixel = romI[address2];
              5'd9: nxt_pixel = romO[address2];
              5'd10: nxt_pixel = romP[address2];
              5'd11: nxt_pixel = romA[address2];
              5'd12: nxt_pixel = romS[address2];
              5'd13: nxt_pixel = romD[address2];
              5'd14: nxt_pixel = romF[address2];
              5'd15: nxt_pixel = romG[address2];
              5'd16: nxt_pixel = romH[address2];
              5'd17: nxt_pixel = romJ[address2];
              5'd18: nxt_pixel = romK[address2];
              5'd19: nxt_pixel = romL[address2];
              5'd20: nxt_pixel = romZ[address2];
              5'd21: nxt_pixel = romX[address2];
              5'd22: nxt_pixel = romC[address2];
              5'd23: nxt_pixel = romV[address2];
              5'd24: nxt_pixel = romB[address2];
              5'd25: nxt_pixel = romN[address2];
              5'd26: nxt_pixel = romM[address2];
              default: nxt_pixel = 12'h000;
             endcase
        else if(
          (obj3[22:12] <= hcountd) &&
          (obj3[22:12] + 32 > hcountd) &&
          (obj3[11:1] <= vcountd) &&
          (obj3[11:1]+32 > vcountd))
             case(obj3[27:23])
                5'd1: nxt_pixel = romQ[address3];
                5'd2: nxt_pixel = romW[address3];
                5'd3: nxt_pixel = romE[address3];
                5'd4: nxt_pixel = romR[address3];
                5'd5: nxt_pixel = romT[address3];
                5'd6: nxt_pixel = romY[address3];
                5'd7: nxt_pixel = romU[address3];
                5'd8: nxt_pixel = romI[address3];
                5'd9: nxt_pixel = romO[address3];
                5'd10: nxt_pixel = romP[address3];
                5'd11: nxt_pixel = romA[address3];
                5'd12: nxt_pixel = romS[address3];
                5'd13: nxt_pixel = romD[address3];
                5'd14: nxt_pixel = romF[address3];
                5'd15: nxt_pixel = romG[address3];
                5'd16: nxt_pixel = romH[address3];
                5'd17: nxt_pixel = romJ[address3];
                5'd18: nxt_pixel = romK[address3];
                5'd19: nxt_pixel = romL[address3];
                5'd20: nxt_pixel = romZ[address3];
                5'd21: nxt_pixel = romX[address3];
                5'd22: nxt_pixel = romC[address3];
                5'd23: nxt_pixel = romV[address3];
                5'd24: nxt_pixel = romB[address3];
                5'd25: nxt_pixel = romN[address3];
                5'd26: nxt_pixel = romM[address3];
                default: nxt_pixel = 12'h000;
            endcase
        else if(
          (obj4[22:12] <= hcountd) &&
          (obj4[22:12] + 32 > hcountd) &&
          (obj4[11:1] <= vcountd) &&
          (obj4[11:1]+32 > vcountd))
            case(obj4[27:23])
                5'd1: nxt_pixel = romQ[address4];
                5'd2: nxt_pixel = romW[address4];
                5'd3: nxt_pixel = romE[address4];
                5'd4: nxt_pixel = romR[address4];
                5'd5: nxt_pixel = romT[address4];
                5'd6: nxt_pixel = romY[address4];
                5'd7: nxt_pixel = romU[address4];
                5'd8: nxt_pixel = romI[address4];
                5'd9: nxt_pixel = romO[address4];
                5'd10: nxt_pixel = romP[address4];
                5'd11: nxt_pixel = romA[address4];
                5'd12: nxt_pixel = romS[address4];
                5'd13: nxt_pixel = romD[address4];
                5'd14: nxt_pixel = romF[address4];
                5'd15: nxt_pixel = romG[address4];
                5'd16: nxt_pixel = romH[address4];
                5'd17: nxt_pixel = romJ[address4];
                5'd18: nxt_pixel = romK[address4];
                5'd19: nxt_pixel = romL[address4];
                5'd20: nxt_pixel = romZ[address4];
                5'd21: nxt_pixel = romX[address4];
                5'd22: nxt_pixel = romC[address4];
                5'd23: nxt_pixel = romV[address4];
                5'd24: nxt_pixel = romB[address4];
                5'd25: nxt_pixel = romN[address4];
                5'd26: nxt_pixel = romM[address4];
                default: nxt_pixel = 12'h000;
            endcase  
        else if(
          (obj5[22:12] <= hcountd) &&
          (obj5[22:12] + 32 > hcountd) &&
          (obj5[11:1] <= vcountd) &&
          (obj5[11:1]+32 > vcountd))
            case(obj5[27:23])
                5'd1: nxt_pixel = romQ[address5];
                5'd2: nxt_pixel = romW[address5];
                5'd3: nxt_pixel = romE[address5];
                5'd4: nxt_pixel = romR[address5];
                5'd5: nxt_pixel = romT[address5];
                5'd6: nxt_pixel = romY[address5];
                5'd7: nxt_pixel = romU[address5];
                5'd8: nxt_pixel = romI[address5];
                5'd9: nxt_pixel = romO[address5];
                5'd10: nxt_pixel = romP[address5];
                5'd11: nxt_pixel = romA[address5];
                5'd12: nxt_pixel = romS[address5];
                5'd13: nxt_pixel = romD[address5];
                5'd14: nxt_pixel = romF[address5];
                5'd15: nxt_pixel = romG[address5];
                5'd16: nxt_pixel = romH[address5];
                5'd17: nxt_pixel = romJ[address5];
                5'd18: nxt_pixel = romK[address5];
                5'd19: nxt_pixel = romL[address5];
                5'd20: nxt_pixel = romZ[address5];
                5'd21: nxt_pixel = romX[address5];
                5'd22: nxt_pixel = romC[address5];
                5'd23: nxt_pixel = romV[address5];
                5'd24: nxt_pixel = romB[address5];
                5'd25: nxt_pixel = romN[address5];
                5'd26: nxt_pixel = romM[address5];
                default: nxt_pixel = 12'h000;
            endcase
        else if(
          (obj6[22:12] <= hcountd) &&
          (obj6[22:12] + 32 > hcountd) &&
          (obj6[11:1] <= vcountd) &&
          (obj6[11:1]+32 > vcountd))
            case(obj6[27:23])
                5'd1: nxt_pixel = romQ[address6];
                5'd2: nxt_pixel = romW[address6];
                5'd3: nxt_pixel = romE[address6];
                5'd4: nxt_pixel = romR[address6];
                5'd5: nxt_pixel = romT[address6];
                5'd6: nxt_pixel = romY[address6];
                5'd7: nxt_pixel = romU[address6];
                5'd8: nxt_pixel = romI[address6];
                5'd9: nxt_pixel = romO[address6];
                5'd10: nxt_pixel = romP[address6];
                5'd11: nxt_pixel = romA[address6];
                5'd12: nxt_pixel = romS[address6];
                5'd13: nxt_pixel = romD[address6];
                5'd14: nxt_pixel = romF[address6];
                5'd15: nxt_pixel = romG[address6];
                5'd16: nxt_pixel = romH[address6];
                5'd17: nxt_pixel = romJ[address6];
                5'd18: nxt_pixel = romK[address6];
                5'd19: nxt_pixel = romL[address6];
                5'd20: nxt_pixel = romZ[address6];
                5'd21: nxt_pixel = romX[address6];
                5'd22: nxt_pixel = romC[address6];
                5'd23: nxt_pixel = romV[address6];
                5'd24: nxt_pixel = romB[address6];
                5'd25: nxt_pixel = romN[address6];
                5'd26: nxt_pixel = romM[address6];
                default: nxt_pixel = 12'h000;
            endcase  
        else if(
          (obj7[22:12] <= hcountd) &&
          (obj7[22:12] + 32 > hcountd) &&
          (obj7[11:1] <= vcountd) &&
          (obj7[11:1]+32 > vcountd))
            case(obj7[27:23])
                5'd1: nxt_pixel = romQ[address7];
                5'd2: nxt_pixel = romW[address7];
                5'd3: nxt_pixel = romE[address7];
                5'd4: nxt_pixel = romR[address7];
                5'd5: nxt_pixel = romT[address7];
                5'd6: nxt_pixel = romY[address7];
                5'd7: nxt_pixel = romU[address7];
                5'd8: nxt_pixel = romI[address7];
                5'd9: nxt_pixel = romO[address7];
                5'd10: nxt_pixel = romP[address7];
                5'd11: nxt_pixel = romA[address7];
                5'd12: nxt_pixel = romS[address7];
                5'd13: nxt_pixel = romD[address7];
                5'd14: nxt_pixel = romF[address7];
                5'd15: nxt_pixel = romG[address7];
                5'd16: nxt_pixel = romH[address7];
                5'd17: nxt_pixel = romJ[address7];
                5'd18: nxt_pixel = romK[address7];
                5'd19: nxt_pixel = romL[address7];
                5'd20: nxt_pixel = romZ[address7];
                5'd21: nxt_pixel = romX[address7];
                5'd22: nxt_pixel = romC[address7];
                5'd23: nxt_pixel = romV[address7];
                5'd24: nxt_pixel = romB[address7];
                5'd25: nxt_pixel = romN[address7];
                5'd26: nxt_pixel = romM[address7];
                default: nxt_pixel = 12'h000;
            endcase
        else if(
          (obj8[22:12] <= hcountd) &&
          (obj8[22:12] + 32 > hcountd) &&
          (obj8[11:1] <= vcountd) &&
          (obj8[11:1]+32 > vcountd))
            case(obj8[27:23])
                5'd1: nxt_pixel = romQ[address8];
                5'd2: nxt_pixel = romW[address8];
                5'd3: nxt_pixel = romE[address8];
                5'd4: nxt_pixel = romR[address8];
                5'd5: nxt_pixel = romT[address8];
                5'd6: nxt_pixel = romY[address8];
                5'd7: nxt_pixel = romU[address8];
                5'd8: nxt_pixel = romI[address8];
                5'd9: nxt_pixel = romO[address8];
                5'd10: nxt_pixel = romP[address8];
                5'd11: nxt_pixel = romA[address8];
                5'd12: nxt_pixel = romS[address8];
                5'd13: nxt_pixel = romD[address8];
                5'd14: nxt_pixel = romF[address8];
                5'd15: nxt_pixel = romG[address8];
                5'd16: nxt_pixel = romH[address8];
                5'd17: nxt_pixel = romJ[address8];
                5'd18: nxt_pixel = romK[address8];
                5'd19: nxt_pixel = romL[address8];
                5'd20: nxt_pixel = romZ[address8];
                5'd21: nxt_pixel = romX[address8];
                5'd22: nxt_pixel = romC[address8];
                5'd23: nxt_pixel = romV[address8];
                5'd24: nxt_pixel = romB[address8];
                5'd25: nxt_pixel = romN[address8];
                5'd26: nxt_pixel = romM[address8];
                default: nxt_pixel = 12'h000;
            endcase  
        else
          nxt_pixel = 12'h000;
        end
 
endmodule