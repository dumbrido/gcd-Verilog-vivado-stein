`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/10 17:49:37
// Design Name: 
// Module Name: gcdsteintest
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


module gcdsteintest();
reg [7:0] a;
reg [7:0] b;
reg go;
wire [7:0] gcd_out;
reg clk;
reg clr;

gcd uut(.a(a),
        .b(b),
        .go(go),
        .gcd_out(gcd_out),
        .clk(clk),
        .clr(clr));

initial begin
    clk = 0;
    clr = 0;
    a = 0;
    b = 0;
    go = 1;
    end
    
always 
    #10 clk = ~clk;
    
initial begin
    #30;
    a = 9;//（在此处更改输入）
    b = 24;//（在此处更改输入）
    end
    
endmodule
