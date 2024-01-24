`timescale 1ns / 1ps

module FIFO(
	input wire clk,
	input wire rst,
	
	input wire W_en,
	input wire R_en,
	
	input  wire [7:0]W_data,
	output wire [7:0]R_data,
	
	output reg Empty,
	output reg Full
	/*
	output reg [4:0] W_Ptr,
	output reg [4:0] R_Ptr
 	*/

);
	parameter FIFO_WIDTH = 8;	//8bit
	parameter FIFO_DEPTH = 16;	//16byte

	reg [4:0] W_Ptr;
	reg [4:0] R_Ptr;

	
	always @(posedge clk or negedge rst) begin //Pointer cnt
		if(rst == 1'b0) begin
			W_Ptr <= 5'b0_0000;
			R_Ptr <= 5'b0_0000;
		end else begin
			if (W_en == 1'b1) W_Ptr <= W_Ptr + 1;
			if (R_en == 1'b1) R_Ptr <= R_Ptr + 1;
		end
	end
	
	reg [FIFO_WIDTH - 1:0] mem [0:FIFO_DEPTH - 1];
	
	integer i;
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			for(i = 0; i < FIFO_DEPTH; i = i + 1)
				mem[i] <= 8'b0000_0000;
		end else begin
			if(W_en == 1'b1) mem[W_Ptr[3:0]] <= W_data; //mem write
		end 
	end
	
	assign R_data = mem[R_Ptr[3:0]]; //mem read

	always @(posedge clk or negedge rst) begin	// Full and Empty check
		if(rst == 1'b0) begin
			Empty = 0;
			Full = 0;
		end else begin
			if(W_Ptr == R_Ptr) Empty = 1'b1;
			else 			   Empty = 1'b0;
			
			if((W_Ptr[3:0] == R_Ptr[3:0]) && (W_Ptr[4] != R_Ptr[4]))
				 Full = 1'b1;
			else Full = 1'b0;													
		end
		
	
	
	end

endmodule
