//DESCRIPTION : Tests write and read functionality of memory module

`include "memory.v"
module top;
parameter WIDTH = 8;
parameter DEPTH = 16;
parameter ADDR_WIDTH = $clog2(DEPTH);

reg clk_i,rst_i,valid_i,write_read_i;
reg [ADDR_WIDTH-1:0]addr_i;
reg [WIDTH-1:0]write_data_i;

wire ready_o;
wire [WIDTH-1:0]read_data_o;

integer i;

memory #(.DEPTH(DEPTH),.WIDTH(WIDTH))dut (
	.clk_i(clk_i),
	.rst_i(rst_i),
	.valid_i(valid_i),
	.ready_o(ready_o),
	.addr_i(addr_i),
	.write_read_i(write_read_i),
	.write_data_i(write_data_i),
	.read_data_o(read_data_o)
);

//Clock Generation
	initial begin
		clk_i=0;
		forever #5 clk_i=~clk_i;    
	end

//Test Sequence
	initial begin
		reset();
		write();
		read();
		#50;
		$finish();
	end

//Reset Task
	task reset();
		begin
			rst_i=1;
			valid_i=0;
			write_read_i=0;
			addr_i=0;
			write_data_i=0;
			repeat(2)@(posedge clk_i);
			rst_i=0;
		end
	endtask

//Write Task
	task write();
		begin
			$display("--Write Operation Start--");
			for(i=0;i<DEPTH;i=i+1)begin 
				@(posedge clk_i);
				valid_i=1;
				write_read_i=1;       //Write mode
				addr_i=i;
				write_data_i=$random();
				$display("WRITE -> addr=%0d | data=%0d",addr_i,write_data_i);	
			end
				wait (ready_o==1);
				@(posedge clk_i);
				addr_i=0;
				valid_i=0;
				write_data_i=0;
				write_read_i=0;
			end
	endtask

//Read Task
		task read();
			begin
			$display("--Read Operation Start--");
			for(i=0;i<DEPTH;i=i+1)begin
				@(posedge clk_i);
				valid_i=1;
				addr_i=i;
				write_read_i=0;	    //Read mode
				wait(ready_o==1);
				$display("READ -> addr=%0d | data=%0d",addr_i,read_data_o);	
			end	
				@(posedge clk_i);
				valid_i=0;
				addr_i=0;
				write_read_i=0;
			end
		endtask
endmodule



