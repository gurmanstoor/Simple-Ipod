module intensity_tb();

reg clk;
reg [7:0] data;

wire [7:0] out;

intensity DUT(.clk(clk), .data(data), .out(out));

//set intial values
initial begin

data = 8'b00000000;

//set forever clock
forever begin

clk = 0; #1;
clk = 1; #1;

end

end

//change the data value that gets added to the sum to test if that cycle is working
initial begin

#5;

data = 8'b01110001;

#1;

data = 8'b01010101;

#1;

data = 8'b00001111;

#1;

data = 8'b00110011;

#1;

data = 8'b10010010;

#1;

data = 8'b11111111;

#1;

data = 8'b01110111;

end


endmodule 