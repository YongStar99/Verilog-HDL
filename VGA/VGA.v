
module VGA(
    input wire clk,
	input wire rst,
	
	input wire [15:0] H_Sync,
	input wire [15:0] H_BP,
	input wire [15:0] H_Act,
	input wire [15:0] H_FP,
	
	input wire [15:0] V_Sync,
	input wire [15:0] V_BP,
	input wire [15:0] V_Act,
	input wire [15:0] V_FP,
	
	output reg  DE_out,
	output reg 	H_Sync_out,
	output reg 	V_Sync_out,
	
	//for test variable
	output reg tc,
	output reg [12:0] Hor_cnt,
	output reg [11:0] Ver_cnt
);

	reg H_DE;
	reg V_DE;
	
	/* 
	reg 	 	tc;
	reg [12:0]	Hor_cnt;
	reg [11:0]	Ver_cnt;
	*/
	
	always @(posedge clk) begin
		if(rst == 1'b0) begin
			Hor_cnt 	<= 1'b0;
			H_Sync_out	<= 1'b0;
			H_DE		<= 1'b0;
			tc			<= 1'b0;
		end else begin
			if(Hor_cnt == H_Sync + H_BP + H_Act + H_FP - 1'b1) begin
				Hor_cnt <= 1'b0;
			end else begin
				Hor_cnt <= Hor_cnt + 1'b1;
			end
			
			//H_Sync, H_DE State
			if(Hor_cnt == H_Sync + H_BP + H_Act + H_FP - 1'b1) begin //0~43, 44 pixels, 0.296us
				H_Sync_out	<= 1'b1;
				H_DE 		<= 1'b0;
			end
			else if(Hor_cnt == H_Sync - 1'b1 ) begin	//44~191, 148 pixels, 0.997us
				H_Sync_out 	<= 1'b0;
				H_DE		<= 1'b0;
			end
			else if(Hor_cnt == H_Sync + H_BP - 1'b1) begin //192~2111, 1920 pixels, 12.929us
				H_Sync_out	<= 1'b0;
				H_DE		<= 1'b1;
			end
			else if (Hor_cnt == H_Sync + H_BP + H_Act - 1'b1)begin //2112~2199, 88 pixels, 0.593us
				H_Sync_out	<= 1'b0;
				H_DE 		<= 1'b0;
			end
			
			//for Ver_cnt singal
			if (Hor_cnt == H_Sync + H_BP + H_Act + H_FP - 2'b10) begin
				tc <= 1'b1;
			end else begin
				tc <= 1'b0;
			end
		end
	end
	
	always @(posedge clk) begin
		if(rst == 1'b0) begin
			Ver_cnt		<= 1'b0;
			V_Sync_out 	<= 1'b0;
			V_DE 		<= 1'b0;
			DE_out 		<= 1'b0;
		end else if(tc) begin
			if(Ver_cnt == V_Sync + V_BP + V_Act + V_FP - 1'b1) begin
				Ver_cnt <= 1'b0;
			end else begin
				Ver_cnt <= Ver_cnt + 1'b1;
			end
			
			//V_Sync, V_DE State
			if(Ver_cnt == V_Sync + V_BP + V_Act + V_FP - 1'b1) begin //0~4, 5 lines, 0.074ms
				V_Sync_out	<= 1'b1;
				V_DE 		<= 1'b0;
			end
			else if(Ver_cnt == V_Sync - 1'b1) begin	//5~40, 36 lines, 0.533ms
				V_Sync_out	<= 1'b0;
				V_DE 		<= 1'b0;
			end
			else if(Ver_cnt == V_Sync + V_BP - 1'b1) begin //41~1120, 1080 lines, 16ms
				V_Sync_out	<= 1'b0;
				V_DE		<= 1'b1;
			end
			else if(Ver_cnt  == V_Sync + V_BP + V_Act - 1'b1) begin //1121~1124, 4 lines, 0.059ms
				V_Sync_out	<= 1'b0;
				V_DE		<= 1'b0;
			end
		//Data Enable
		end else begin
			DE_out <= H_DE & V_DE;
		end
	end
	
endmodule
