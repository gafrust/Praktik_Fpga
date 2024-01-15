module imp_200(

input clk,
input reset,
input reg [69:0] m_seq_reg2,
output reg out_imp
);
reg [18:0] cntRqFast;
reg RqFast;
reg [5:0]i_count;

always @(posedge clk or negedge  reset ) 
  if(~reset) begin 
      cntRqFast <=19'd0;
       RqFast<=1'd0;
	   i_count<=0;
                  end else begin
out_imp<=RqFast;	
cntRqFast <= cntRqFast + 1'b1;
i_count <=i_count+1;
		case (cntRqFast)
			0: RqFast <= m_seq_reg2[i_count];//1'd1; 
			1: RqFast <= 1'd0; 
			//1530: begin
			
			10:  begin //80000
				cntRqFast <= 19'd0;
				if(i_count==63) begin i_count<=0; end
			       end
		endcase
		 
end
endmodule