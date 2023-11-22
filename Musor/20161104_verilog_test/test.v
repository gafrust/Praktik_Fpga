`timescale 1ns/1ns

module tb();
   reg clk = 1'b0;
   reg resetn;

   initial begin
      resetn = 0;
      #10
      resetn = 1;
      
   end
   
   always #5 clk=!clk;

   reg [4:0] cnt=5'b0;

   always @(posedge clk) begin
      cnt <= cnt+1;
   end

   wire [10:0] out;
   
   my_adder adder
     (
      .clk       (clk),
      .resetn    (resetn),
      .in        (cnt),
      .sum       (out)
      );

   integer     fd_cnt;
   integer     fd_sum;
   initial begin
      fd_cnt = $fopen("cnt.txt", "w");
      fd_sum = $fopen("sum.txt", "w");
   end
   
   always @(posedge clk) begin
      if (resetn!=1'b0) begin
	 $fdisplay(fd_cnt, "%d", cnt);
	 $fdisplay(fd_sum, "%d", adder.sum);
      end
   end	  
		 
   
endmodule // tb
