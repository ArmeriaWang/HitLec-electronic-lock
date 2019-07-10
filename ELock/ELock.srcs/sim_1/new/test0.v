`timescale 1ns / 1ps
// `include "main.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/25 14:11:46
// Design Name: 
// Module Name: test0
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


module test0();

    reg clk;
	reg rst;
	reg add1;
	reg sub1;
	reg digCnf;
	reg pasBtn;
	reg setLok;
	wire [7:0] cntDn;
	wire [3:0] blue;
	wire [3:0] green;
	wire [3:0] red;
	wire [3:0] an0;
	wire [3:0] an1;
	wire [7:0] pipe0;
	wire [7:0] pipe1;
	
	wire enEnter;
	wire lockState;
	wire inpFin;
	wire [31:0] pw;
	wire [2:0] pw_num;
	// wire scaleTime;
	// wire scaleTime_d;
	wire [3:0] id0;
	wire [3:0] id1;
	
	main u0(
        .clk(clk), 
        .rst(rst), 
        .add1(add1), 
        .sub1(sub1),
        .digCnf(digCnf),
        .pasBtn(pasBtn),
        .setLok(setLok), 
        
        .cntDn(cntDn),
        // .blue(blue),
        // .green(green),
        .red(red), 
        .an0(an0), 
        .an1(an1), 
        .pipe0(pipe0),
        .pipe1(pipe1)
        
        // .enEnter(enEnter),
        // .lockState(lockState),
        // .inpFin(inpFin)
        //.pw(pw),
        //.pw_num(pw_num),
        //.scaleTime(scaleTime),
        //.scaleTime_d(scaleTime_d)
        //.id0(id0),
        //.id1(id1)
	);
	
	reg op;
	
	initial begin
        // $dumpfile("test0.vcd");
        // $dumpvars(0, test0);

        clk = 0;
        rst = 0;
        op = 0;
        pasBtn = 0;
        add1 = 0;
        sub1 = 0;
        digCnf = 0;
        setLok = 0;
	end
	
	always #1   clk = ~clk;
    always #100000000 op = ~op;
    
    always @ (op) begin
        #10 pasBtn <= 1;
        #10 digCnf <= ~digCnf;
        #10 digCnf <= ~digCnf;
        #10 digCnf <= ~digCnf;
        #10 digCnf <= ~digCnf;
        #10 digCnf <= ~digCnf;
        #10 digCnf <= ~digCnf;
        #10 digCnf <= ~digCnf;
        #10 digCnf <= ~digCnf;
        #10 pasBtn <= 0;
        
        #5 digCnf = 0;
        
        #10 pasBtn <= 1;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;
        
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;
        
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;
        
        #5 pasBtn <= 0;
        
        #5 pasBtn <= 1;
        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;
        #5 pasBtn <= 0;

        #40 pasBtn <= 1;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 add1 <= 1; #5 add1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;
        #5 pasBtn <= 0;

        #20 setLok <= 1;

        #20 pasBtn <= 1;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

        #5 sub1 <= 1; #5 sub1 <= 0;
        #5 digCnf <= 1; #5 digCnf <= 0;

    end

endmodule
