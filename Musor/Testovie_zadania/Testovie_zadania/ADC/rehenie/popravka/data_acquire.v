module data_acquire(
	input clk_i,
	input reset_n_i,
	 
//ADC interface
	output	adc_data_req_o, //?????? ??????? ??? ??? adc_data_req_o ????????????? ?? ????? 2 ?????? clk_i.
	input	adc_data_rdy_i, //?????? ?????????? ?????? ? ???
	input [11:0] adc_data_i, //?????? ? ??? 
	
//Module output interface
	input syncro_i, //??????? ??????? ???? ?? ????? 1 ????? clk_i
	output signed [11:0]	data_o,
	output data_rdy_o
);

reg adc_data_req;
reg [1:0]st;
reg [3:0] cnt;
reg [3:0] cnt_st;
reg flag_st;
reg [11:0] adc_data [7:0];
reg data_rdy;
assign adc_data_req_o=adc_data_req;
assign data_rdy_o=data_rdy;

srednee sr(
.rezultat(data_o),
.a(adc_data [0]),
.b(adc_data [1]),
.c(adc_data [2]),
.d(adc_data [3]),
.e(adc_data [4]),
.f(adc_data [5]),
.g(adc_data [6]),
.h(adc_data [7])
);

 initial begin 
     adc_data_req <= 1'b0;
      cnt<=0;
      st<=0;
      cnt_st<=0;
      flag_st<=0;
      adc_data [0]<=0;
      adc_data [1]<=0;
      adc_data [2]<=0;
      adc_data [3]<=0;
      adc_data [4]<=0;
      adc_data [5]<=0;
      adc_data [6]<=0;
      adc_data [7]<=0;
      end 
always @ (posedge clk_i or posedge reset_n_i)
     begin   
       flag_st <= (cnt_st==8);
       cnt<=cnt+1;
    if(~flag_st) begin
     case(st)
      2'b00:  begin 
          cnt<=0;
          
          if(syncro_i) 
                     begin
                       st<=1;
                     end
          end
      2'b01: begin 
          if(cnt==11) begin 
          adc_data_req <= 1'b1;
           st<=2;
           end
           end
      2'b10: begin 
           if(cnt==13) begin 
          adc_data_req <= 1'b0;
           st<=3;
          end
            end 
      2'b11: begin 
           if(adc_data_rdy_i) begin 
          adc_data[cnt_st] <= adc_data_i;
           cnt_st<=cnt_st+1;
           st<=0;
          end
            end 
       endcase
     end
      
      $display("final %b",flag_st);
      
       end
       
         always @ (posedge clk_i or posedge reset_n_i)
        begin
          if(~reset_n_i)data_rdy<=0; else begin if(flag_st)data_rdy<=1; end
        end  
        
endmodule

module srednee(
 output signed [12:0 ]rezultat,
 input signed [11:0] a,
 input signed [11:0] b,
 input signed [11:0] c,
 input signed [11:0] d,
 input signed [11:0] f,
 input signed [11:0] g,
 input signed [11:0] e,
 input signed [11:0] h
);

assign rezultat=(a+b+c+d+f+g+e+h)/8;
endmodule