`timescale 1ns / 1ps
// `include "enterPw.v"
// `include "displayDigits.v"
// `include "stateLight.v"
// `include "keyNormalize.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/24 21:55:04
// Design Name: 
// Module Name: main
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


module main(clk, rst, add1_T, sub1_T, digCnf_T, pasBtn_T, setLok, 
            cntDn, alarm, rest, an0, an1, pipe0, pipe1);
	
	input clk;
	input rst;
	input add1_T;
	input sub1_T;
	input digCnf_T;
	input pasBtn_T;
	input setLok;
	output [7:0] cntDn;
	output [3:0] alarm;
	output [2:0] rest;
	output [3:0] an0;
	output [3:0] an1;
	output [7:0] pipe0;
	output [7:0] pipe1;

	wire [31:0] pw;
	wire [3:0] pw_num;
	wire inpFin;
	wire add1;
	wire sub1;
	wire digCnf;
	wire pasBtn;

	reg [31:0] lc;
	reg [3:0] lc_num;

	reg inputScen;
	reg lockState;
	reg [1:0] failCnt;
	wire [1:0] restTry;

	reg enEnter;
	reg enAlarm;
	wire enFail;

	reg inpFin_d;
	reg pasBtn_d;
	reg setLok_d;

	initial begin
		lc <= 4'b0000;
		lc_num <= 4;
		enEnter <= 0;
		enAlarm <= 0;
		inpFin_d <= 0;
		pasBtn_d <= 0;
		setLok_d <= 0;
        
        failCnt <= 0;		
		lockState <= 1;
		inputScen <= 0;	
	end

	enterPw enter(
	    .clk(clk),
		.enEnter(enEnter),
		.add1(add1),
		.sub1(sub1),
		.digCnf(digCnf),
		.pasBtn(pasBtn),
		.inputScen(inputScen),
		.lockState(lockState),
		
		.inpFin(inpFin),
		.pw(pw),
		.num(pw_num),
		.cntDn(cntDn)
	);

	stateLight sLight (
		.clk(clk),
		.enAlarm(enAlarm),
		.restTry(restTry),
		.lockState(lockState),
		.alarm(alarm),
		.rest(rest)
	);

	displayDigits display(
		.clk(clk),
		.enEnter(enEnter),
		.enFail(enFail),
		.lockState(lockState),
		.pw(pw),
		.num(pw_num),
		
		.an0(an0),
		.an1(an1),
		.pipe0(pipe0),
		.pipe1(pipe1)
	);

	keyNormalize add1Nor(
		.clk(clk),
		.keyIn(add1_T),
		.keyOut(add1)
	);

	keyNormalize sub1Nor(
		.clk(clk),
		.keyIn(sub1_T),
		.keyOut(sub1)
	);
	
	keyNormalize digCnfNor(
		.clk(clk),
		.keyIn(digCnf_T),
		.keyOut(digCnf)
	);
	
	keyNormalize pasCnf(
		.clk(clk),
		.keyIn(pasBtn_T),
		.keyOut(pasBtn)	   
	);
	
	
	assign enFail = (failCnt <= 2) ? 0 : 1;
	assign restTry = 3 - failCnt;
	always @(posedge clk or posedge rst) begin
		if (!rst) begin
			lc <= 4'b0000;
            lc_num <= 4;
            enEnter <= 0;
            enAlarm <= 0;
            inpFin_d <= 0;
            pasBtn_d <= 0;
            setLok_d <= 0;
            
            failCnt <= 0;
            lockState <= 1;
            inputScen <= 0;	
		end
		
		else if (!lockState && !enEnter) begin
		    // UNlock state
			if (!pasBtn_d && pasBtn) begin
				// modify password
				enEnter <= 1;
				inputScen <= 1;
			end
			
			else if (!setLok_d && setLok) begin
				// force back to lock state
				lockState <= 1;
			end
		end
		
		else if (lockState && !enEnter) begin
		    // ENlock state
			if (pasBtn_d == 0 && pasBtn == 1 && !enFail) begin
				// input password
				enEnter <= 1;
				enAlarm <= 0;
				inputScen <= 0;
			end
		end

		else if (enEnter && inpFin_d == 0 && inpFin == 1) begin
			// password entering finished
			if (inputScen == 1)  begin
				// update local password
				lc <= pw;
				lc_num <= pw_num;
				lockState <= 1;
				// automatically lock
			end
			else begin // inputScen == 0
				// compare inputed passward and local password
				if (pw_num != lc_num || pw != lc || cntDn == 0) begin
					// not match, enable alarm
					enAlarm <= 1;
					failCnt <= failCnt + 1;
				end
				else begin
					// match, unlock
					lockState <= 0;
					failCnt <= 0;
				end
			end

			enEnter <= 0;
		end

		// record previous states of input buttons
		pasBtn_d <= pasBtn;
		inpFin_d <= inpFin;
		setLok_d <= setLok;
		
	end

endmodule
