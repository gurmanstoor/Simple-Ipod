module intensity(clk, data, out);

//inputs and outputs
input clk;
input [7:0] data;
output reg [7:0] out;

//variables
reg [7:0] average=0;
reg [7:0] count=0;
reg [7:0] count1=0;
reg [15:0] sum=0;
reg [1:0] state;

//state definitions
parameter check_samples = 2'b00;
parameter get_average = 2'b01;
parameter output_led = 2'b11;
parameter shift_led = 2'b10;

always@(posedge clk) begin

	
case(state)
	//checks to see if 256 samples have been counted
	check_samples: begin
		if(count < 8'd255) begin
		sum <= sum + data;
		count <= count +1;
		state <= check_samples;
		end else begin
		count <= 0;
		state <= get_average;
		end

		count1 = 0;
	end
	//gets average value by first getting absolute value of sum [15:8]
	get_average: begin
		if(sum[15] == 1'b1) begin //get absolute if negative
			average <= ((sum[15:8] ^ 8'b11111111) + 1);
	
		//just average
		end else begin 
			average <= sum[15:8]; end
	
		state <= shift_led;
	end
	//shifts the average left until MSB is 1 and counts up count1
	shift_led: begin

		if (average == 8'b00000000) begin
			count1 <= 8;
			state <= output_led;
		end else if(average[7] != 1'b1) begin
			count1 <= count1+1;
			average <= average<<1;
			state <= shift_led;
		end else begin
			//count1 <= 0;
			state <= output_led;	
		end
	end
	//sifts 8'hFF left by count1 number of times
	output_led: begin
		sum <= 0;
		out <= (8'b11111111<<count1);
		state <= check_samples;
	end
	//default goes to check smaples
	default: begin
		count =0;
		sum =0;
		count1 =0;
		state <= check_samples;
	end
		

endcase
		
end


endmodule 