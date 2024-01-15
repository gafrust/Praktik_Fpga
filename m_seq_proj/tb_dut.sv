`timescale 1 ns/ 1 ns
module tb_dut();

  // test vector input registers
  reg clk;
  //reg enable;
  reg arst;
  // wires                                               
  //wire [3:0]  count;
 // wire [7:0]  Data;
  //wire TxD_start;
  //logic s_clk;
  //logic  [3:0] TxD_state;
  //logic usart_clk2;
  //logic [ 7:0 ] Txd_Data;
    
//------ Clock & arst ---------------------------------------
always   #( 5 )  clk =  ! clk;    //создание clk     

initial begin                                                  
  clk = 0;

  arst = 0;                                           
  $display("Running testbench ", "m_seq_reg_output=%b", m_seq_reg_output  );                       
  #100;
  arst = 1;
  #1000;
  $display("Stoping testbench ", "m_seq_reg_output=%b", m_seq_reg_output  );  
  #1000
  $finish();                                           
end                                                    


//------ dut --------------------------------------- 
logic txd_seq_o;
logic [5:0] stat_o;
logic [69:0] m_seq_reg_o;
wire [69:0] m_seq_reg_output;
m_seq63 m_seq (

  .sclk  ( clk ),
  .rst_n       ( arst      ),
  .m_seq       ( txd_seq_o    ),
  .status      ( stat_o ),
  .m_seq_reg     ( m_seq_reg_o ),
  .m_seq_reg2  (m_seq_reg_output)
);

  //------ dut --------------------------------------- 
logic out_imp_o ;

imp_200 imp_200 (

  .clk  ( clk ),
  .reset      ( arst  ),
  .out_imp      ( out_imp_o ),
  .m_seq_reg2  (m_seq_reg_output)//(63'b000001110000100100011011001011010111011110011000101010011111101)//
  
);                                         

endmodule