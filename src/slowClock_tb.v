`timescale 1ns/1ps

module slowClock_tb;

    logic hwClock;
    logic clk;
    
    slowClock r(.*);
    
    initial
    begin
        $dumpfile("slowClock_tb.vcd");
        $dumpvars(0, clk, hwClock);
    end
    
    initial
    begin
        hwClock = 0;
        forever #150 hwClock = ~hwClock;
    end
endmodule
