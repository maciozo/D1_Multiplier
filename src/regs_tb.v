`timescale 1ns/1ps

module regs_tb;

    logic clk;
    logic n_reset;
    logic ADD;
    logic SHIFT;
    logic[3:0] sum;
    logic[3:0] multiplier;
    logic carry;
    logic[8:0] register;
    
    regs r(.*);
    
    initial
    begin
        $dumpfile("regs_tb.vcd");
        $dumpvars(0, clk, n_reset, ADD, SHIFT, sum, multiplier, carry, register);
    end
    
    initial
    begin
        clk <= 0;
        forever #5 clk <= ~clk;
    end
    
    initial
    begin
        n_reset = 0;
        ADD = 0;
        SHIFT = 0;
        sum = 0;
        multiplier = 0;
        carry = 0;
        
        #10;
        if (register != 9'b0)
        begin
            $display("Register isn't empty");
            $fatal;
        end
        sum = 8;
        multiplier = 9;
        carry = 1;
        n_reset = 0;
        
        #10;
        n_reset = 1;
        
        #10;
        if (register != {5'b0, 4'd9})
        begin
            $display("Multiplier not loaded to register");
            $display("multiplier = %b, register = %b", multiplier, register);
            $fatal;
        end
        ADD = 1;
        
        #10;
        if (register != 9'b110001001)
        begin
            $display("Result from adder not loaded to register");
            $fatal;
        end
        ADD = 0;
        SHIFT = 1;
        
        #10;
        if (register != 9'b011000100)
        begin
            $display("Register not shifted");
            $display("register = %b", register);
            $fatal;
        end
        SHIFT = 0;
        
        #10;
        if (register != 9'b011000100)
        begin
            $display("Register not held");
            $display("register = %b", register);
            $fatal;
        end
        
        #10;
        n_reset = 0;
        
        #10;
        if (register != {5'b0, 4'd9})
        begin
            $display("Register not reset");
            $display("register = %b", register);
            $fatal;
        end
        
        #10;
        $display("Test passed!");
        $finish;
        
    end
    
endmodule
