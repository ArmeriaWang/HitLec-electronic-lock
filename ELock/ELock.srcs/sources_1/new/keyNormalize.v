`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/25 22:40:44
// Design Name: 
// Module Name: keyNorarlize
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


module keyNormalize(clk, keyIn, keyOut);

	input clk;
	input keyIn;
	output keyOut;

	reg [19:0] lowCnt;
	reg [19:0] highCnt;

	reg keyOut;

	initial begin
		lowCnt <= 1;
		highCnt <= 1;
	end

	always @(posedge clk) begin
		if (keyIn == 1'b0) begin
			lowCnt <= lowCnt + 1;
			highCnt <= 1;
		end
		else begin
			highCnt <= highCnt + 1;
			lowCnt <= 1;
		end
	end

	always @(posedge clk) begin
		if (highCnt == 0)
			keyOut <= 1;
		else if (lowCnt == 0)
			keyOut <= 0;
	end

endmodule 
