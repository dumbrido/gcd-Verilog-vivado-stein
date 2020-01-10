`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/10 16:36:24
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
    input clk,
	input clr,
	input go,
	input eqflg,
	input ltflg,
	input [1:0] cld,
	output reg xld,
	output reg yld,
	output reg xmsel,
	output reg ymsel,
	output reg gld);

reg [3:0] current_state, next_state;
parameter start = 3'b000,
           input1 = 3'b001, 
           compare = 3'b010, 
           calculator1 = 3'b011, 
           calculator2 = 3'b100, 
           done = 3'b101;

always @(posedge clk) begin
	    if(clr) 
	        current_state <= start;
	    else
	        current_state <= next_state;
	    end
	        
always @(posedge clk) begin 
		case(current_state)
		    start:
		        if(go == 1)
					next_state <= input1;
				else
				    next_state <= start;
			input1:begin
			    if(cld == 3)
				    next_state <= compare;
				else
				    next_state <= input1;
				    end
			compare: 
			    if(eqflg == 1)
					next_state <= done;
		        else if(ltflg == 1)
				    next_state <= calculator1;
				else if(ltflg == 0)
				    next_state <= calculator2;
			calculator1:
				next_state <= input1;
		    calculator2:
				next_state <= input1;
			done: 
				next_state <= done;
			default:
				next_state = start;
		endcase
	end
	
always @(posedge clk) begin 
		case(current_state)
		    start:begin
			$display("star");
			    xmsel <= 1;
			    ymsel <= 1; 
			    xld <= 1;
			    yld <= 1; 
				end
			input1:begin
			$display("in1,%d",cld);
			    xmsel <= 0;
			    ymsel <= 0; 
			    xld <= 0;
			    yld <= 0; 
				end
			compare: begin
			$display("com");
				end
			calculator1: begin
			$display("c1");
			    xmsel <= 0;
			    ymsel <= 0; 
			    xld <= 1;
			    yld <= 0; 
				end
			calculator2: begin
			$display("c2");
			    xmsel <= 0;
			    ymsel <= 0; 
			    xld <= 0;
			    yld <= 1; 
				end
			done: begin
			$display("done");
			    gld <= 1;
				end
			default:
				next_state = start;
		endcase
	end
	
endmodule
