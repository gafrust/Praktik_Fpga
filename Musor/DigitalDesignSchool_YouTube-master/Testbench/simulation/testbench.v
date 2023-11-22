// testbench is a module which only task is to test another module
// testbench is for simulation only, not for synthesis
`timescale 1ns/1ps
module testbench;

    // input and output test signals
    reg  [1:0] key_sw;
    wire [1:0] led;

    // creating the instance of the module we want to test
    //  top - module name
    //  DUT  - instance name ('DUT' means 'device under test')
    top DUT (key_sw, led);

    // do at the beginning of the simulation
    initial 
        begin
            key_sw = 2'b00;    // set test signals value
            #10;               // pause
            key_sw = 2'b01;    // set test signals value
            #10;               // pause
            key_sw = 2'b10;    // set test signals value
            #10;               // pause
            key_sw = 2'b11;    // set test signals value
            #10;               // pause
        end

    // do at the beginning of the simulation
    // print signal values on every change
    initial 
    $monitor("key_sw=%b led=%b", key_sw, led);

endmodule
