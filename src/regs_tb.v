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
        clk <= 0;
        #10 forever clk <= ~clk;
    end
    
    initial
    begin
        $display("t");
        n_reset = 0;
        ADD = 0;
        SHIFT = 0;
        sum = 0;
        multiplier = 0;
        carry = 0;
        
        #10;
        $display("t");
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
        $display("t");
        n_reset = 1;
        
        #10;
        $display("t");
        if (register != {5'b0, 4'd9})
        begin
            $display("Multiplier not loaded to register");
            $display("multiplier = %b, register = %b", multiplier, register);
            $fatal;
        end
        ADD = 1;
        
        #10;
        $display("t");
        if (register != 9'b110001001)
        begin
            $display("Result from adder not loaded to register");
            $fatal;
        end
        ADD = 0;
        SHIFT = 1;
        
        #10;
        $display("t");
        if (register != 9'b011000100)
        begin
            $display("Register not shifted");
            $fatal;
        end
        SHIFT = 0;
        
        #10;
        $display("t");
        if (register != 9'b011000100)
        begin
            $display("Error in hold state. Register not held");
            $fatal;
        end
        
        #10;
        $display("t");
        n_reset = 0;
        
        #10;
        $display("t");
        if (register != {5'b0, 4'd9})
        begin
            $display("Error in clear state. Register not reset");
            $fatal;
        end
        
        #10;
        $display("t");
        $display("Test passed!");
        $finish;
        
    end
    
endmodule
