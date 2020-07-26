/*

LAB 2 TEMPLATE TAKEN FROM AKASH RANDHAWA: 88346861
USED FOR PREVIOUS LAB 3 SUBMISSION

*/
//unused states
`define check 4'b0000
`define reading 4'b0001
`define timing 4'b0010
`define output_lower1 4'b0011 
`define wait_1 4'b0100
`define timing_2 4'b0101
`define output_lower2 4'b0110
`define wait_2 4'b0111
`define timing_3 4'b1000
`define output_upper1 4'b1001
`define wait_3 4'b1010
`define timing_4 4'b1011
`define output_upper2 4'b1100
`define wait_4 4'b1101

module audio_out(clk, clk_2, select, finish, direction, pause, hold, audio_data, audio_out);

//inputs and outputs
input clk, clk_2, finish;
input direction, pause;

input [31:0] audio_data;
input [1:0] select;
output reg [7:0] audio_out;
output reg hold;
//variables
reg [7:0] audio_select;
reg [3:0] state, next;


//state logic
always @(posedge clk_2) begin   //every posedge, update states and audio_output
//state <= next; 
audio_out<=audio_select; end


always @(posedge clk) begin
	//checks if keyboard clikc is pause
	if(pause) begin audio_select <= audio_out; hold =1;
	end else begin 
	//by checking the 2 LSB from the address we output the corresponding audio segments
	case (select)
		2'b00: begin audio_select <= audio_data[7:0]; hold =0; end
		2'b01: begin audio_select <= audio_data[15:8]; hold =0; end
		2'b10: begin audio_select <= audio_data[23:16]; hold =0; end
		2'b11: begin audio_select <= audio_data[31:24]; hold =0; end
		default: begin audio_select <= 0; hold =1; end


	
	/*//check play or pause
	`check: begin audio_select = audio_out; hold=1;    
		if(!pause) next = `reading;
		else next = `check;
		end
	
	//wait until finished reading audio data from flash
	`reading: begin audio_select = audio_out; hold=1;   
		if(finish) next = `timing;
		else next = `reading;
		end
	//wait until speech clock high
	`timing: begin audio_select = audio_out; hold=1;  
		if(clk_2) next = `output_lower1;
		else next = `timing;
		end
	//output lowest byte
	`output_lower1: begin next = `wait_1; hold=1;         
		audio_select = audio_data[7:0];
		end
	//wait 1 cycle then iterate
	`wait_1: begin next = `timing_2; hold=1;    
		audio_select = audio_out; 
		end
	//wait until speech clock high
	`timing_2: begin audio_select = audio_out; hold=1;   
		if(clk_2) next = `output_lower2;
		else next = `timing_2;
		end
	//output 2nd lowest byte
 	`output_lower2: begin next = `wait_2; hold=1;   
		audio_select = audio_data[15:8];	
		end
 	//wait 1 cycle then iterate
	`wait_2: begin next = `timing_3; hold=1;   
		audio_select = audio_out; 
		end
	//wait until speech clock high
	`timing_3: begin audio_select = audio_out; hold=1;   
		if(clk_2) next = `output_upper1;
		else next = `timing_3;
		end
	//output 2nd highest byte
 	`output_upper1: begin next = `wait_3; hold=1;   
		audio_select = audio_data[23:16];	
		end
 	//wait 1 cycle then iterate
	`wait_3: begin next = `timing_4; hold=1;   
		audio_select = audio_out; 
		end
	//wait until speech clock high
	`timing_4: begin audio_select = audio_out; hold=1;   
		if(clk_2) next = `output_upper2;
		else next = `timing_4;
		end
	//output highest byte
 	`output_upper2: begin next = `wait_4; hold=1;   
		audio_select = audio_data[31:24];	
		end
 	//wait 1 cycle then un hold the address
	`wait_4: begin next = `check; hold=0;   
		audio_select = audio_out; 
		end
	//check for play and pause state
	default: begin next = `check;
		audio_select = 8'b0; 
		hold=1;
		end
	*/
	endcase 
end
end




endmodule 