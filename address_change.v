/*

LAB 2 TEMPLATE TAKEN FROM AKASH RANDHAWA: 88346861
USED FOR PREVIOUS LAB 3 SUBMISSION

*/

//increments address from start to end then resets or gets a new start address and end
module address_change (clk, direction, running, hold, address, start_address, end_address);

//inputs and outputs
input clk, direction, hold;
input [23:0] start_address, end_address;
output reg [24:0] address;
output reg [7:0] running;

//test values
wire [23:0] test_start, test_end;

//test values
assign test_start = 24'd57216;
assign test_end = 24'd59071;


reg [24:0]  next_address;

reg [1:0] state, next_state;

//define states
parameter state_initial = 2'b00;
parameter state_inc = 2'b01;
parameter state_loop = 2'b11;
parameter state_extra = 2'b10;

//state logic
always @(posedge clk) begin
address <= (next_address);
state <= next_state;
end

always @(*) begin
	//check if paused on the keyboard 
	if(hold) begin next_address = address;
			next_state = state;
			running = 8'h0;
		end
	
	else begin

	case(state)
		//sets initial start address
		state_initial: begin
				next_address = (start_address);
				next_state = state_inc;
				running = 8'h0;
			end
		//increments address until at end address then goes back to initial state
		state_inc: begin if(address < (end_address)) begin
				next_address = address + 1;
				next_state = state_inc;
				running = 8'hFF;
				end else begin 
				next_address = start_address;
				next_state = state_initial;
				running = 8'h0;
				end
			end
		//loops address
		state_loop: begin 
				next_address = start_address;
				next_state = state_inc;
				running = 8'hFF;
			end
		//default sets same values as initial state and goes to inital state
		default: begin
			next_address = start_address;
			next_state = state_initial;
			running = 8'h0;
			end
	endcase

	end
			



 /*
		if(hold)   //if holding address from the output module, keep address same
		next_address = address;
		else if(first_address) 
		else if(address <= end_address) begin
			next_address = address +1;
		end else next_address = start_address;



		/*else if(direction) begin  //if forward direction
		if(address<=last_address)
		next_address = address+1'b1;  //add 1 if its less than max
		else 
		next_address = 23'b0;  //if max, then go to 0
		end

		else if(!direction) begin  //if backwards
		if(address>23'b0)
		next_address = address-1'b1;  //sub 1 if greater than 0
		else 
		next_address = last_address;  //if 0 go to max
		end

		else next_address = 23'b0;  //else default, go to 0
	*/
end
endmodule