`timescale 1ns/1ps

module sequencer_tb;

    logic clk;
    logic[8:0] register;
    logic n_reset;
    logic START;
    logic[2:0] count;
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
        register = 9'b000000000;
        n_reset = 0;
        START = 0;
        count = 4;
        
        #20
        n_reset = 1;
        if (!RESET) begin
            $display("Failed to reset!");
        end
        
        #10
        START = 0;
        
        #7
        START = 1;
        
        #3 //40ns
        if (ADD | SHIFT | !RESET | DECREMENT | READY) begin
            $display("bad assertions, 38");
        end
        
        #7
        START = 0;
        
        #3 //50ns
        if (ADD | SHIFT | RESET | !DECREMENT | READY) begin
            $display("bad assertions, 44");
        end
        
        #10 //60ns
        register[0] = 1;
        if (ADD | !SHIFT | RESET | DECREMENT | READY) begin
            $display("bad assertions, 50");
        end
        
        #0.01
        count = 0;
        
        #9.99 //70ns
        START = 0;
        if (!ADD | SHIFT | RESET | !DECREMENT | READY) begin
            $display("bad assertions, 58");
        end
        
        #10
        START = 1;
        if (ADD | !SHIFT | RESET | DECREMENT | READY) begin
            $display("bad assertions, 64");
        end
        
        #10
        START = 0;
        if (ADD | SHIFT | RESET | DECREMENT | !READY) begin
            $display("bad assertions, 70");
        end
        
        #10
        START = 1;
        if (ADD | SHIFT | RESET | DECREMENT | !READY) begin
            $display("bad assertions, 76");
        end
        
        #10
        if (ADD | SHIFT | !RESET | DECREMENT | READY) begin
            $display("bad assertions, 81");
        end
        $finish;
    end
endmodule
