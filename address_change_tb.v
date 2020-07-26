/*

LAB 2 TEMPLATE TAKEN FROM AKASH RANDHAWA: 88346861
USED FOR PREVIOUS LAB 3 SUBMISSION

*/

module address_change_tb ();

reg clk_tb;
reg [1:0] direction;
wire start_tb;
wire [24:0] address;
reg [23:0] start, last;
reg hold;
wire [7:0] running;


address_change DUT(.clk(clk_tb), .hold(hold), .running(running), .direction(direction), .start_address(start), .end_address(last), .address(address));


initial begin
clk_tb = 0;
hold =0;

start = 24'd59072;
last = 24'd59100;


forever begin 
clk_tb = 0;
#1;
clk_tb =1;
#1;
end
end

endmodule