`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/25 14:02:39
// Design Name: 
// Module Name: stateLight
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


module stateLight(clk, enAlarm, restTry, lockState, alarm, rest);

	reg [24:0] twinkleCnt;
    // reg [1:0] twinkleCnt;

	input clk;
	input enAlarm;
	input [1:0] restTry;
	input lockState;
	output [3:0] alarm;
	output [2:0] rest;

	reg [3:0] alarm;
	reg [2:0] rest;
    
	initial begin
		alarm <= 4'b0000;
		rest <= 3'b000;
		twinkleCnt <= 1'b1;
	end
	
	always @(posedge clk) begin
	    if (lockState == 0) begin
	        rest <= 3'b000;
	    end
	    else begin
	        case (restTry)
                3: rest <= 3'b111;
                2: rest <= 3'b011;
                1: rest <= 3'b001;
                0: rest <= 3'b000;
                default: rest <= 3'b111;
            endcase
        end
	end

	always @(posedge clk) begin
	    if (enAlarm == 1 && twinkleCnt == 0) begin
	        alarm <= 4'b1111 - alarm;
	    end
	    
		if (lockState == 0) begin
			alarm <= 8'b0000;
		end
		else if (enAlarm == 0) begin
			alarm <= 4'b1111;
		end
		
		twinkleCnt <= twinkleCnt + 1'b1;
		
	end

endmodule
