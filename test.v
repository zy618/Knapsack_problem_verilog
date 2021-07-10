`timescale 1ns / 1ps

module test();
    reg reset;
    reg clk;

    wire [3:0] AN;
    wire [7:1] cathodes;
    
    top top_inst(clk, reset, AN, cathodes);
    
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, top_inst);
        reset = 1;
        clk = 1;
        #100 reset = 0;
    end
    
    always #50 clk = ~clk;
    // fhjkds
endmodule