`timescale 1ns/1ps

module FIFO_tb();

	reg clk;
	reg rst;
	reg W_en;
	reg R_en;
	reg [7:0]W_data;
		
	wire [7:0]R_data;
	wire Empty;
	wire Full;
	wire [4:0] W_Ptr;
    wire [4:0] R_Ptr;
	FIFO u0(clk, rst, W_en, R_en, W_data, R_data, Empty, Full, W_Ptr, R_Ptr);
	
	initial begin
		clk		<= 0;
		rst		<= 0;
		W_en	<= 0;
		R_en	<= 0;
		forever begin
			#5 clk <= ~clk;
		end
	end
	
		integer i;
	
	initial begin
        
        // 0. initialize
        rst = 1'b1;
        W_en = 1'b0;
        R_en = 1'b0;
        W_data = 8'b0000_0000;
        
        // 1. reset
        @(posedge clk);
        #1
        rst = 1'b0;   // reset on
        
        @(posedge clk);
        #1
        rst = 1'b1;   // reset off
        
        // 2. Write activation

        for (i=0; i < 16; i=i+1) begin
            @(posedge clk);
            #1
            W_en = 1'b1;
            W_data = i;
        end
        
        // 3. Write off
        @(posedge clk);
        #1
        W_en = 1'b0;
        
        // 4. Read activation
        for (i=0; i < 16; i=i+1) begin
            @(posedge clk);
            #1
            R_en = 1'b1;
        end
        
        // 5. Read off
        @(posedge clk);
        #1
        R_en = 1'b0;
		
		///////////////////////////////////
		
		// 2. Write activation

        for (i=0; i < 16; i=i+1) begin
            @(posedge clk);
            #1
            W_en = 1'b1;
            W_data = i;
        end
        
        // 3. Write off
        @(posedge clk);
        #1
        W_en = 1'b0;
        
        // 4. Read activation
        for (i=0; i < 16; i=i+1) begin
            @(posedge clk);
            #1
            R_en = 1'b1;
        end
        
        // 5. Read off
        @(posedge clk);
        #1
        R_en = 1'b0;
		
		/////////////////////////////////////////////
		// 2. Write activation

        for (i=0; i < 16; i=i+1) begin
            @(posedge clk);
            #1
            W_en = 1'b1;
            W_data = i;
        end
        
        // 3. Write off
        @(posedge clk);
        #1
        W_en = 1'b0;
        
        // 4. Read activation
        for (i=0; i < 16; i=i+1) begin
            @(posedge clk);
            #1
            R_en = 1'b1;
        end
        
        // 5. Read off
        @(posedge clk);
        #1
        R_en = 1'b0;

    end
	
	


endmodule
