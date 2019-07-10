`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/24 22:40:44
// Design Name: 
// Module Name: enterPw
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


module enterPw(clk, enEnter, add1, sub1, digCnf, pasBtn, inputScen, lockState,
               pw, num, cntDn, inpFin);
               // extinguishEdge, extinguishEdge_d);
    
    reg	[27:0] extinguishCnt;
	// reg	[2:0] extinguishCnt;
    
    input clk;
	input add1;
	input sub1;
	input digCnf;
	input pasBtn;
	input enEnter;
	input inputScen;
	input lockState;
	
	output [31:0] pw;
	output [7:0] cntDn;
	output [3:0] num;
	output inpFin;
	
	reg [3:0] num;
	reg [3:0] cur;
	reg [2:0] rest;
	reg [31:0] pw;
    reg [7:0] cntDn;
	reg inpFin;
	
	reg enEnter_d;
	reg digCnf_d;
	reg	add1_d;
	reg	sub1_d;
   	reg pasBtn_d;
    
	initial begin
		rest <= 7;
		num <= 1'b1;
		pw <= 0;
		cur <= 4'b0000;
		inpFin <= 1'b0;
		cntDn <= 8'b11111111;
		extinguishCnt <= 1'b1;
		
		enEnter_d <= 0;
		digCnf_d <= 0;
		add1_d <= 0;
		sub1_d = 0;
		pasBtn_d <= 0;
	end

    always @(posedge clk) begin
        enEnter_d <= enEnter;
		digCnf_d <= digCnf;
		add1_d <= add1;
		sub1_d <= sub1;
		pasBtn_d <= pasBtn;
	end
    
	always @(posedge clk) begin // delete posedge?
        
		if (enEnter_d == 0 && enEnter == 1) begin
			rest <= 7;
			num <= 1;
			pw <= 0;
			cur <= 4'b0000;
			inpFin <= 0;
			cntDn <= 8'b11111111;
			extinguishCnt <= 1;
		end
		else begin
			extinguishCnt <= extinguishCnt + 1'b1;
		end
    
		if (enEnter) begin
			if ( (inputScen == 0 && !cntDn && !inpFin) || 
			     (pasBtn_d && !pasBtn && ((num > 4 && inputScen == 1) || inputScen == 0)) || 
			     (num == 8 + 1) ) begin
				// if times' up OR password button is pushed OR password length reaches 8
				num <= num - 1'b1;
				inpFin <= 1;
			end
			else if (!add1_d && add1) begin
				pw <= pw + ((cur == 9 ? -9 : 1) << (4 * (num - 1)));
				cur <= (cur == 9) ? 0 : cur + 1;
			end
			else if (!sub1_d && sub1) begin
				pw <= pw + ((cur == 0 ? 9 : -1) << (4 * (num - 1)));
				cur <= (cur == 0) ? 9 : cur - 1;
			end 
			else if (!digCnf_d && digCnf) begin
				cur <= 4'b0000;
				num <= num + 1'b1;
			end
			
			if (extinguishCnt == 0 && inputScen == 0) begin
				// extinguish a LED light used for count down
				cntDn[rest] <= 0;
				rest <= rest - 1;
			end
			
		end
		
		else begin  // enEnter = 0
		    cntDn <= (lockState == 1) ? 8'b10011001 : 8'b11111111;
		end
    
	end

endmodule
