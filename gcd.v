`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/09 19:57:02
// Design Name: 
// Module Name: gcd
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

module gcd(
           input [7:0] a, b, 
           input go,
           output [7:0] gcd_out,
           input clk, clr
           );
           
wire xsel, ysel, xmld, ymld, gmld, eqmflg, ltmflg; 
wire [1:0] cld;

datapath U1(.clk(clk), 
            .clr(clr), 
            .xmsel(xsel), 
            .ymsel(ysel), 
            .xld(xmld), 
            .yld(ymld), 
            .gld(gmld), 
            .xin(a), 
            .yin(b), 
            .eqflg(eqmflg), 
            .ltflg(ltmflg),
            .cld(cld),
            .gcd(gcd_out));

control U2(.clk(clk), 
           .clr(clr), 
           .go(go), 
           .eqflg(eqmflg), 
           .ltflg(ltmflg),
           .cld(cld),
           .xld(xmld), 
           .yld(ymld), 
           .xmsel(xsel), 
           .ymsel(ysel), 
           .gld(gmld));
                    
endmodule
