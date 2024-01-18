`timescale 1ns / 1ps

module VGA_tb();

	reg clk;
	reg rst;
	
	reg [15:0] H_Sync;
	reg [15:0] H_BP;
	reg [15:0] H_Act;
	reg [15:0] H_FP;
	
	reg [15:0] V_Sync;
	reg [15:0] V_BP;
	reg [15:0] V_Act;
	reg [15:0] V_FP;
	
	wire DE_out;
	wire H_Sync_out;
	wire V_Sync_out;
	
	//for test
	wire tc;
	wire [12:0] Hor_cnt;
	wire [11:0] Ver_cnt;
						
	VGA u0
	(
	.clk		(clk),
	.rst		(rst),
	.H_Sync		(H_Sync),
	.H_BP		(H_BP),
	.H_Act		(H_Act),
	.H_FP		(H_FP),
	.V_Sync		(V_Sync),
	.V_BP		(V_BP),
	.V_Act		(V_Act),
	.V_FP		(V_FP),
	.DE_out		(DE_out),
	.H_Sync_out	(H_Sync_out),
	.V_Sync_out	(V_Sync_out),
	.tc			(tc),
	.Hor_cnt	(Hor_cnt),
	.Ver_cnt	(Ver_cnt)
	);
	
	initial begin
		clk 	<= 0;
		H_Sync	<= 0;
		H_BP 	<= 0;
		H_Act 	<= 0;
		H_FP 	<= 0;
		V_Sync	<= 0;
		V_BP	<= 0;
		V_Act	<= 0;
		V_FP	<= 0;
		forever begin
			#3.35 clk <= ~clk; 
		end
	end
	
	initial begin
        rst <= 1;
        #10
		rst <= 0;
		#10
		rst 	<= 1;
		H_Sync	<= 44;
		H_BP 	<= 148;
		H_Act 	<= 1920;
		H_FP 	<= 88;
		
		V_Sync	<= 5;
		V_BP	<= 36;
		V_Act	<= 1080;
		V_FP	<= 4;
    end
endmodule