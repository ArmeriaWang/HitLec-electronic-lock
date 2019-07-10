`timescale 1ns / 1ps
// `include "displaySingle.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/25 14:04:07
// Design Name: 
// Module Name: displayDigits
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


module displayDigits(clk, enEnter, enFail, lockState, pw, num, an0, an1,
                     pipe0, pipe1);
                     // id0, id1);

    reg [17:0] refreshCnt;
	// reg [1:0] refreshCnt;

	input clk;
	input enEnter;
	input enFail;
	input lockState;
	input [31:0] pw;
	input [3:0] num;
	output [3:0] an0;
	output [3:0] an1;
	output [7:0] pipe0;
	output [7:0] pipe1;

	wire [3:0] an0;
	wire [3:0] an1;
	reg [4:0] id0;
	reg [4:0] id1;
	wire [15:0] pw0;
	wire [15:0] pw1;
	wire [3:0] dig0;
	wire [3:0] dig1;

	reg [1:0] cur;

	wire [7:0] pipe0;
	wire [7:0] pipe1;
	
	wire needTwink0;
	wire needTwink1;
	wire [1:0] curRev;
	
	assign curRev = 3 - cur;
    
    assign needTwink0 = (enEnter && num - 1 == curRev + 4) ? 1'b1 : 1'b0;
    assign needTwink1 = (enEnter && num - 1 == curRev) ? 1'b1 : 1'b0;
    
	displaySingle single0(
		.clk(clk),
		.enEnter(enEnter),
		.needTwink(needTwink0),
		.id(id0),
		.pipe(pipe0)
	);

	displaySingle single1(
		.clk(clk),
		.enEnter(enEnter),
		.needTwink(needTwink1),
		.id(id1),
		.pipe(pipe1)
	);

	initial begin
		id0 <= 15;
		id1 <= 15;
		cur <= 2'b00;
		refreshCnt <= 1'b1;
	end

	/*
	0 : 0
	1 : 1
	2 : 2
	3 : 3
	4 : 4
	5 : 5
	6 : 6
	7 : 7
	8 : 8
	9 : 9
	10: _
	11: -
	12: E
	13: L
	14: U
	15: NONE
	16: F
	17: A
	*/

	assign pw0 = pw[15:0];
	assign pw1 = pw[31:16];
	assign an0 = (1 << cur);
	assign an1 = (1 << cur);
	assign dig0 = ((pw1 % (1 << ((curRev + 1) * 4))) >> (curRev * 4));
	assign dig1 = ((pw0 % (1 << ((curRev + 1) * 4))) >> (curRev * 4));

	always @(posedge clk) begin
		
		if (!enEnter) begin
		
		    if (enFail) begin
		        case (an0)
		            4'b0001: id0 <= 11;
		            4'b0010: id0 <= 11;
		            4'b0100: id0 <= 13;
		            4'b1000: id0 <= 1;
		            default: id0 <= 15;
		        endcase
		        
		        case (an1)
		            4'b0001: id1 <= 17;
		            4'b0010: id1 <= 16;
		            4'b0100: id1 <= 11;
		            4'b1000: id1 <= 11;
		            default: id0 <= 15;
		        endcase
		    end 
		    
		    else if (lockState == 1) begin
			    id0 <= (an0 == 4'b1000) ? 13 : 11;
			    id1 <= (an1 == 4'b0001) ? 12 : 11;
			end
			
			else begin
			    id0 <= (an0 == 4'b1000) ? 13 : 11;
			    id1 <= (an1 == 4'b0001) ? 14 : 11;
			end
			
		end
		
		else begin
		
			if (curRev > num - 1) begin
				id0 <= 10;
				id1 <= 10;
			end
            
			else if (curRev <= num - 1 && curRev + 4 > num - 1) begin
				id0 <= 10;
				id1 <= dig1;
			end
            
			else begin
				id0 <= dig0;
				id1 <= dig1;
			end
			
		end
		
		refreshCnt <= refreshCnt + 1;
		if (refreshCnt == 0) begin
		    cur <= cur + 1;
		end
		
	end

endmodule
