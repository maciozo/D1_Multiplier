`timescale 1ns/1ps

module multiplier_tb;
    
    logic START;
    logic READY;
    logic n_reset;
    logic[15:0] AQ;
    
    multiplier m(.*);
    
    initial
    begin
        $dumpfile("multiplier_tb.vcd");
        $dumpvars(0, AQ, n_reset, START, READY);
    end
    
    initial
    begin
        n_reset = 1;
        START = 1;
        
        #500ps
        n_reset = 0;
        #100ps
        n_reset = 1;
        
        #2400ps;
        n_reset = 1;
        
        #1;
        START = 0;

        #2;
        START = 1;
        
        #29
        START = 0;

        #6;
        START = 1;
        
        #30;
        n_reset = 0;
        
        #5;
        $finish;
    end
endmodule