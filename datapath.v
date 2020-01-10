`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/10 16:51:00
// Design Name: 
// Module Name: datapath
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


module datapath(
    input clk,
    input clr,
    input xmsel,
    input ymsel,
    input xld,
    input yld,
    input gld,
    input [7:0] xin,
    input [7:0] yin,
    output reg eqflg,
    output reg ltflg,
    output reg [1:0] cld,
    output [7:0] gcd);

wire [7:0] xmy, ymx;
reg [7:0] x, y, x2, y2, z = 8'b00000001, x1, y1, gcd_out, gcd_out1, a, b;

assign xmy = x - y;
assign ymx = y - x;

always @(posedge clk) begin//
    if(x[0] == 0 && y[0] == 0) cld = 2'b00;
    else if(x[0] == 0 && y[0] == 1) cld = 2'b01;
    else if(x[0] == 1 && y[0] == 0) cld = 2'b10;
    else if(x[0] == 1 && y[0] == 1) cld = 2'b11;
end

always @(posedge clk) begin//ltflg
    if(x == 0) begin
        gcd_out1 <= y;
        eqflg <= 1;
        end
    if(y == 0) begin
        gcd_out1 <= x;
        eqflg <= 1;
        end
end

always @(posedge clk) begin//ltflg
    if(x > y)
        ltflg <= 1;
    else if(x < y)
        ltflg <= 0;
end

always @(posedge clk) begin//eqflg
    if(x == y) begin
        eqflg <= 1;
        gcd_out1 <= x;
        end
end

always @(posedge clk) begin
    case(cld)
         2'b00: begin
             if(x != 0 || y != 0)begin
             x <= (x>>1);
             y <= (y>>1);
             z <= (z<<1);
             $display("00,%d,%d,%d",x,y,z);
             end
             end
         2'b01: begin
             x <= (x>>1);
             $display("01,%d,%d,%d",x,y,z);
             end
         2'b10: begin
             y <= (y>>1);
             $display("10,%d,%d,%d",x,y,z);
             end
         2'b11: begin
             x2 <= xmy;
             y2 <= ymx;
             $display("11,%d,%d,%d",x,y,z);
             end 
    endcase
    end

always @(posedge clk) begin //xmux
    if(xmsel == 1) 
        x1 <= xin;
    else x1 <= x2;
    end
    
always @(posedge clk) begin //ymux
    if(ymsel == 1) 
        y1 <= yin;
    else y1 <= y2;
    end
    
always @(posedge clk) begin //xreg
    if(xld == 1)
        x <= x1;
    end
    
always @(posedge clk) begin //yreg
    if(yld == 1) 
        y <= y1;
    end
    
 always @(posedge clk) begin //gcdreg
    if(gld == 1) 
        case(z)
            8'b00000001: gcd_out <= gcd_out1;
            8'b00000010: gcd_out <= (gcd_out1<<1);
            8'b00000100: gcd_out <= (gcd_out1<<2);
            8'b00001000: gcd_out <= (gcd_out1<<3);
            8'b00010000: gcd_out <= (gcd_out1<<4);
            8'b00100000: gcd_out <= (gcd_out1<<5);
            8'b01000000: gcd_out <= (gcd_out1<<6);
            8'b10000000: gcd_out <= (gcd_out1<<7);
        endcase
    end
    
assign gcd = gcd_out;

endmodule