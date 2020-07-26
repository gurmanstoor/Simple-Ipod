/*

LAB 2 TEMPLATE TAKEN FROM AKASH RANDHAWA: 88346861
USED FOR PREVIOUS LAB 3 SUBMISSION

*/

module speed(clk, speed_up_event, speed_down_event, speed_reset_event, clk_count_to);

input clk, speed_up_event, speed_down_event, speed_reset_event;
output reg[31:0] clk_count_to;

always @(posedge clk) begin

	if(speed_up_event)   //if speeding up, subtract 10 from count to
	clk_count_to <= (clk_count_to - 32'd10);
	else if(speed_down_event)
	clk_count_to <= (clk_count_to + 32'd10); //if slowing down, add 10
	else if(speed_reset_event)
	clk_count_to <= 32'd3472;    //if reset, go back to 7200hz
	else clk_count_to <= clk_count_to; end  //else keep what it is

endmodule

