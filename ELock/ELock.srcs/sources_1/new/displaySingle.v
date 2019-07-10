`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/25 14:07:40
// Design Name: 
// Module Name: displaySingle
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


module displaySingle(clk, enEnter, needTwink, id, pipe);

    parameter digitTwinkCntRange = 26;
    reg [digitTwinkCntRange:0] digitTwinkCnt;

	input clk;
	input enEnter;
	input needTwink;
	input [4:0] id;
	output [7:0] pipe;

	reg [7:0] pipe;
	
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

	initial begin
		pipe <= 8'b00000000;
		digitTwinkCnt <= 0;
	end

	always @(posedge clk) begin
	
        if (needTwink && (digitTwinkCnt & (1 << (digitTwinkCntRange - 1)))) begin
            pipe <= 8'b00000000;
        end
        
        else begin
            if (id == 0 || id == 2 || id == 3 || (id >= 5 && id <= 9) || 
                id == 12 || id == 16 || id == 17)
                pipe[0] <= 1;
            else
                pipe[0] <= 0;
    
            if (id <= 4 || (id >= 7 && id <= 9) || 
                id == 14 || id == 17)
                pipe[1] <= 1;
            else
                pipe[1] <= 0;
    
            if (id <= 1 || (id >= 3 && id <= 9) || 
                id == 14 || id == 17)
                pipe[2] <= 1;
            else
                pipe[2] <= 0;
    
            if (id == 0 || id == 2 || id == 3 || id == 5 || id == 6 || (id >= 8 && id <= 14 && id != 11))
                pipe[3] <= 1;
            else
                pipe[3] <= 0;
    
            if (id == 0 || id == 2 || id == 6 || id == 8 || 
               (id >= 12 && id <= 14) || id == 16 || id == 17)
                pipe[4] <= 1;
            else
                pipe[4] <= 0;
    
            if (id == 0 || (id >= 4 && id <= 6) || id == 8 || id == 9 || 
               (id >= 12 && id <= 14) || id == 16 || id == 17)
                pipe[5] <= 1;
            else
                pipe[5] <= 0;
    
            if ((id >= 2 && id <= 6) || (id >= 8 && id <= 12 && id != 10) ||
                id == 16 || id == 17)
                pipe[6] <= 1;
            else
                pipe[6] <= 0;
    
            pipe[7] <= 0;
        end
        
        digitTwinkCnt <= digitTwinkCnt + 1'b1;
	end

endmodule

