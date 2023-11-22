`include "params.v"

module my_adder(
	       clk,
	       resetn,
	       in,
	       sum
		);

   parameter LENGTH=`SUM_LENGTH;
   
   input clk;
   input resetn;
   input [4:0] in;
   output [LENGTH-1:0] sum;

   reg [LENGTH-1:0] 	 sum;


   always @(posedge clk or negedge resetn) begin
      if (resetn == 1'b0) begin
	 sum <= 10'd0;
      end else begin
	 sum <= sum + in;
      end
   end
endmodule // my_adder

