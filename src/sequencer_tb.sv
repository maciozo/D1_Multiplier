`timescale 1ns/1ps

module sequencer_tb;

    logic clk;
    logic[16:0] register;
    logic n_reset;
    logic START;
    logic[3:0] count;
    logic ADD;
    logic SHIFT;
    logic RESET;
    logic DECREMENT;
    logic READY;
    
    sequencer r(.*);
    
    initial
    begin
        $dumpfile("sequencer_tb.vcd");
        $dumpvars(0, clk, register, n_reset, START, count, ADD, SHIFT, RESET, DECREMENT, READY);
    end
    
    initial
    begin
        #5 clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial
    begin
        register = 17'b000000000;
        n_reset = 0;
        START = 1;
        count = 4;
        
        #5;
        n_reset = 1;
        
        #5; // Should be in stIdle state
        if (ADD | SHIFT | !RESET | DECREMENT | READY) begin
            $display("Bad assertions!");
            $error;
        end
        
        #10; // Should still be in stIdle
        if (ADD | SHIFT | !RESET | DECREMENT | READY) begin
            $display("Bad assertions!");
            $error;
        end
        START = 0;
        
        #12; // Should be in stAdd. Not adding, since Q0 is 0.
        if (ADD | !SHIFT | RESET | !DECREMENT | READY) begin
            $display("Bad assertions!");
            $error;
        end
        START = 1;
        
        #10; // Should be in stAdd. Not adding, since Q0 is 0.
        if (ADD | !SHIFT | RESET | !DECREMENT | READY) begin
            $display("Bad assertions!");
            $error;
        end
        START = 0;
        register[0] = 1;
        
        #10; // Should be adding this time, since Q0 was 1.
        if (!ADD | !SHIFT | RESET | !DECREMENT | READY) begin
            $display("Bad assertions!");
            $error;
        end
        register[0] = 0;
        START = 1;
        
        #10; // Not adding, Q0 is 0 again.
        if (ADD | !SHIFT | RESET | !DECREMENT | READY) begin
            $display("Bad assertions!");
            $error;
        end
        count = 0;
        
        #10; // Should be finished here (stStop), since count = 0.
        if (ADD | SHIFT | RESET | DECREMENT | !READY) begin
            $display("Bad assertions!");
            $error;
        end
        START = 0;
        
        #10; // Should be back to stIdle.
        if (ADD | SHIFT | !RESET | DECREMENT | READY) begin
            $display("Bad assertions!");
            $error;
        end
        
        $finish;
    end
endmodule
