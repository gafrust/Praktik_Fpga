module top
(
    input  [1:0] key_sw,
    output [1:0] led
);

    wire a = ~ key_sw [0];
    wire b = ~ key_sw [1];
    
    wire result = a ^ b;

    assign led [0] = ~ result;
    
    assign led [1] = ~ (~ key_sw [0] ^ ~ key_sw [1]);

endmodule

