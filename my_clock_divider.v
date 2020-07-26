/*

LAB 2 TEMPLATE TAKEN FROM AKASH RANDHAWA: 88346861
USED FOR PREVIOUS LAB 3 SUBMISSION

*/
module my_clock_divider (inclk,outclk,clk_count_to);
	input inclk;
	input [31:0] clk_count_to;
	output reg outclk=0;
	reg [31:0] count;
	
//checks for every posedge of inclk
	
always @(posedge inclk) begin
	if(count<(clk_count_to-1))  //if the counter variable is less than what it shoudl count too, count is added by 1
	count = count+1;
	else begin  //else if count is greater or equal to count to
	outclk=!outclk;  //outclk is changed to the opposide, so if 1 it is 0 and if 0 its is 1
	count =0;   //also count is set to 0
	end
end
endmodule
	
