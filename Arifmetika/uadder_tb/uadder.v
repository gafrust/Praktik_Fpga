module uadder (
input cin,
input [7:0] a,
input [7:0] b,
output [7:0] sum,
output cout
);

assign {cout, sum} = a+b+cin;

endmodulerfrВУЫШЮЮ ч