// i?eieiaou x8 + x4 + x3 + x2 + 1 a ea?anoaa i?eia?a:
module m_seq63(
    input        sclk,
    input        rst_n,
    output       m_seq,
    output reg [5:0] status,
    output reg [69:0] m_seq_reg,
    output reg [69:0] m_seq_reg2
);
 
parameter  POLY = 6'b101101;//6'b101111;//6'b111101;
reg [5 : 0] shift_reg;

//reg [69:0] m_seq_reg;
//reg [69:0] m_seq_reg2;

reg [8:0] count; 
reg flag;
 
always@(posedge sclk or negedge rst_n)
begin
    if(rst_n == 0)
    begin
        shift_reg <=6'b100000;//6'b100000;// 6'b111111;//
        count <=0;
        flag<=1;
        
    end
 
    else
    begin
         if(flag)
        count<= count+1;
         else count<=count;
         
        shift_reg[5] <= (shift_reg[0] & POLY[5]) ^
                        (shift_reg[1] & POLY[4]) ^
                        (shift_reg[2] & POLY[3]) ^
                        (shift_reg[3] & POLY[2]) ^
                        (shift_reg[4] & POLY[1]) ^
                        (shift_reg[5] & POLY[0]) ;
 
        shift_reg[4 : 0] <= shift_reg[5 : 1];
        status <= shift_reg;
        if(count!=64)
        begin
        
            
             //  m_seq_reg[69]<= shift_reg[0];
              // m_seq_reg[68:0]<=m_seq_reg[69:1];
              m_seq_reg[0]<= shift_reg[0];
              m_seq_reg[69:1]<=m_seq_reg[68:0];
             
        
        end else  begin m_seq_reg2<=m_seq_reg; flag<=0; end
        
    end
end
 
assign m_seq = shift_reg[0];
 
endmodule