


module CONV(
 input  reset, // �����, ������� ���� ���������
 input  clk, // ����
 input wire signed [7: 0] CONV_iData0, // ������� ������
 input wire signed [7: 0] CONV_iData1, // ������� ������
 output reg signed [8: 0] CONV_oData // ������ ������
);
 
parameter LengthOfConv = 8;  // ����� �������
parameter InState =   4'b0001,
          ConvState = 4'b0010,
		  OutState =  4'b0100,
		  ClrState =  4'b1000;
 
 // ��� �������� ���� ������
reg [7:0] CONV_iData0reg;//[LengthOfConv - 1:0];
reg [7:0] CONV_iData1reg;//[LengthOfConv - 1:0];
reg [8:0] CONV_oDatareg;//[2*LengthOfConv - 2:0];

reg [7:0] CONV_iD0; //[LengthOfConv - 1:0];
reg [7:0] CONV_iD1; //[LengthOfConv - 1:0];


 
// reg [7: 0] index0;
// reg [7: 0] index1; // ��� ��� ������������� ��� ������������� � �������
 
// reg [7: 0] index_input; // ������� �����
// reg [7: 0] index_conv;
// reg [7: 0] index_conv2; // ������� �������
// reg [7:0]  index_convs; //index_convs<=index_conv2 + index_conv;
// reg [7: 0] index_output; // ������� ������ u
// reg [7: 0] index_clr; // �������� �������
 
reg [3:0] state,nextstate;
 

 always @ (posedge clk) // ����������� ��������� ������, ����� �������� ������� ����� ������� � ������� ����������
begin
	if(reset == 0)
	begin
		CONV_iData0reg <= 8'b0;
		CONV_iData1reg <= 8'b0;
		CONV_oDatareg <= 9'b0;
		// index_convs <= 0;
		// index0 <= 0;
		// index1 <= 0;
		// index_input <= 8'b0;
		// index_conv	<= 8'b0;		
		// index_conv2 <= 8'b0;
		// index_output<= 8'b0;
		// index_clr <= 8'b0;  
		//state <= InState;
		//nextstate <= ConvState;
	    CONV_iD0 <= 8'b0;
        CONV_iD1 <= 8'b0;
		
	end
	else
	begin
		state <= InState;
		nextstate <= ConvState;
		 if (state == InState) // ���� ������
		begin
			
				CONV_iData0reg <= CONV_iData0;
				CONV_iData1reg <= CONV_iData1;
				
				 CONV_oData <= 0; // ����� �������������� �� ��������, �� ������ ����� 0
			
				state <= nextstate;
				nextstate  <= OutState;
			
		end
		 if (state == ConvState) // ������������ �������
		    begin
			  CONV_oData <= 0; // ����� �������������� �� ��������, �� ������ ����� 0
			    CONV_oDatareg<= CONV_iData0reg*(1) + CONV_iData1reg*(-1);
				 CONV_iD0<=CONV_iData0reg*(1);
                 CONV_iD1<=CONV_iData1reg*(-1);
				state <= nextstate;
				nextstate  <= ClrState;
			end
		 
		 if (state == OutState) // ��������� ������
		begin
			CONV_oData <= CONV_oDatareg;//CONV_oData <= CONV_oDatareg[index_output];
			
				state <= nextstate;
				nextstate  <= InState;
					
		end 
		 if (state == ClrState) // �������� ���������
		begin
			 CONV_oData <= 0; // ����� �������������� �� ��������, �� ������ ����� 0
			CONV_oDatareg <= 0;
			
			
				state <= nextstate;
				nextstate  <= ConvState;
						
		end 
	end
end
endmodule

// module top
// (
//     input  [1:0] key_sw,
//     output [1:0] led
// );

//     wire a = ~ key_sw [0];
//     wire b = ~ key_sw [1];
    
//     wire result = a ^ b;

//     assign led [0] = ~ result;
    
//     assign led [1] = ~ (~ key_sw [0] ^ ~ key_sw [1]);

// endmodule

