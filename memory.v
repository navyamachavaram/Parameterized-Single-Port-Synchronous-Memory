//MODULE : MEMORY
//DESCRIPTION : Parameterized synchronous memory with valid-ready handshake 
//Supports write and read operations


module memory(clk_i,rst_i,valid_i,addr_i,write_read_i,write_data_i,ready_o,read_data_o);

parameter WIDTH = 8;                    //Data width
parameter DEPTH = 16;                   //Number of memory locations
parameter ADDR_WIDTH = $clog2(DEPTH);   //Address width

input clk_i,rst_i,valid_i,write_read_i;
input [ADDR_WIDTH-1:0]addr_i;
input [WIDTH-1:0]write_data_i;

output reg ready_o;
output reg [WIDTH-1:0]read_data_o;

//Memory declaration
reg [WIDTH-1:0] mem [DEPTH-1:0];

//Internal Registers
integer i;

//Sequential Logic
always@(posedge clk_i)begin
	if(rst_i==1)begin       //Reset outputs
		ready_o<=0;
		read_data_o<=0;
		for(i=0;i<DEPTH;i=i+1)begin
			mem[i]<=0;      //Clear memory
		end
	end
	else begin
		if(valid_i==1) begin
			ready_o<=1;

			//Write Operation
			if(write_read_i==1) begin
				mem[addr_i] <= write_data_i;
			end

			//Read Operation
			else begin
				read_data_o <= mem[addr_i];
			end
		end	
		else begin 
			ready_o<=0;
		end	
	end
end
endmodule


