`timescale 1ns/1ns
 
 
module CONV_tb();
    
parameter period = 1;
 
parameter Rst0State = 2'b00; // Предполагается, что начальное значение состояния равно 0
parameter Rst1State = 2'b01;
parameter WorkState = 2'b10;
    
reg reset;
reg clk;
reg  [11:0] CONV_iData0;
reg  [11:0] CONV_iData1;
wire [12:0] CONV_oData;
reg  [15:0] index_reset; 
reg  [1:0]  State;

always #( 1 ) clk = ! clk;
initial begin
    clk = 0;
  //  reset = 0;
    $display("Running testbench");
    #100;
   reset = 1;
    #1000;
    $finish();
end

always @(posedge clk)
begin
    case(State)
	 Rst0State: // запускаем сброс
	begin		
		reset <= 0;
		index_reset <= 0;
		State <= Rst1State;
	end

	 Rst1State: // Сохраняем сброс, сброс завершается
		begin
			if(index_reset <= 16'hfe)
			begin
				index_reset <= index_reset + 1;
			end
			else
			begin
				index_reset <= 0;
				State <= WorkState;
				reset <= 1;
			end
		end
	
	 WorkState: // ввод данных
			begin
				reset <= 1;
				State <= WorkState;
				CONV_iData0 = 12'd3;
				CONV_iData1 = 12'd2;
			end
            default: State <= Rst0State;
    endcase
end
  /*
always @(posedge clk)
begin
	 if (State == Rst0State) // запускаем сброс
	begin		
		reset <= 0;
		index_reset <= 0;
		State <= Rst1State;
	end
	else 
	 if (State == Rst1State) // Сохраняем сброс, сброс завершается
		begin
			if(index_reset <= 16'hfe)
			begin
				index_reset <= index_reset + 1;
			end
			else
			begin
				//index_reset <= 0;
				State <= WorkState;
				reset <= 1;
			end
		end
		else
			 if (State == WorkState) // ввод данных
			begin
				reset <= 1;
				State <= WorkState;
				CONV_iData0 = 8'h01;
				CONV_iData1 = 8'h01;
			end
end
 */

// always 
// begin
// 	//# period clk = !clk;	
// 	# 1 clk = !clk;
// end
 
 


CONV CONV0(
	.reset(reset),
	.clk(clk),
	.CONV_iData0(CONV_iData0),
	.CONV_iData1(CONV_iData1),
	.CONV_oData(CONV_oData)
);
endmodule 


// // testbench is a module which only task is to test another module
// // testbench is for simulation only, not for synthesis
// `timescale 1ns/1ps
// module testbench;

//     // input and output test signals
//     reg  [1:0] key_sw;
//     wire [1:0] led;

//     // creating the instance of the module we want to test
//     //  top - module name
//     //  DUT  - instance name ('DUT' means 'device under test')
//     top DUT (key_sw, led);

//     // do at the beginning of the simulation
//     initial 
//         begin
//             key_sw = 2'b00;    // set test signals value
//             #10;               // pause
//             key_sw = 2'b01;    // set test signals value
//             #10;               // pause
//             key_sw = 2'b10;    // set test signals value
//             #10;               // pause
//             key_sw = 2'b11;    // set test signals value
//             #10;               // pause
//         end

//     // do at the beginning of the simulation
//     // print signal values on every change
//     initial 
//     $monitor("key_sw=%b led=%b", key_sw, led);

// endmodule
