


module CONV(
 input reg reset, // Сброс, очистка всех регистров
 input reg clk, // часы
 input wire signed [7: 0] CONV_iData0, // входные данные
 input wire signed [7: 0] CONV_iData1, // входные данные
 output reg signed [8: 0] CONV_oData // данные вывода
);
 
parameter LengthOfConv = 8;  // Длина свертки
parameter InState =   4'b0001,
          ConvState = 4'b0010,
		  OutState =  4'b0100,
		  ClrState =  4'b1000;
 
 // Три регистра типа памяти
reg [7:0] CONV_iData0reg;//[LengthOfConv - 1:0];
reg [7:0] CONV_iData1reg;//[LengthOfConv - 1:0];
reg [8:0] CONV_oDatareg;//[2*LengthOfConv - 2:0];

reg [7:0] CONV_iD0; //[LengthOfConv - 1:0];
reg [7:0] CONV_iD1; //[LengthOfConv - 1:0];


 
// reg [7: 0] index0;
// reg [7: 0] index1; // Эти два предназначены для инициализации и очистки
 
// reg [7: 0] index_input; // счетчик ввода
// reg [7: 0] index_conv;
// reg [7: 0] index_conv2; // Счетчик свертки
// reg [7:0]  index_convs; //index_convs<=index_conv2 + index_conv;
// reg [7: 0] index_output; // счетчик вывода u
// reg [7: 0] index_clr; // выводить счетчик
 
reg [3:0] state,nextstate;
 

 always @ (posedge clk) // Используйте несколько тактов, чтобы очистить регистр ввода свертки и регистр результата
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
		 if (state == InState) // ввод данных
		begin
			
				CONV_iData0reg <= CONV_iData0;
				CONV_iData1reg <= CONV_iData1;
				
				 CONV_oData <= 0; // Когда преобразование не окончено, на выходе будет 0
			
				state <= nextstate;
				nextstate  <= OutState;
			
		end
		 if (state == ConvState) // Рассчитываем свертку
		    begin
			  CONV_oData <= 0; // Когда преобразование не окончено, на выходе будет 0
			    CONV_oDatareg<= CONV_iData0reg*(1) + CONV_iData1reg*(-1);
				 CONV_iD0<=CONV_iData0reg*(1);
                 CONV_iD1<=CONV_iData1reg*(-1);
				state <= nextstate;
				nextstate  <= ClrState;
			end
		 
		 if (state == OutState) // состояние вывода
		begin
			CONV_oData <= CONV_oDatareg;//CONV_oData <= CONV_oDatareg[index_output];
			
				state <= nextstate;
				nextstate  <= InState;
					
		end 
		 if (state == ClrState) // очистить состояние
		begin
			 CONV_oData <= 0; // Когда преобразование не окончено, на выходе будет 0
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

