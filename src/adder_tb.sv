`timescale 1ns/1ps
module adder_tb;
    logic[7:0] a;
    logic[7:0] m;
    logic[7:0] sum;
    logic carry;
    logic[16:0] correct_sum;
    logic correct_carry;
    int loopa;
    int loopm;
    
    // Instantiating adder module
    adder r(.*); 
    
    initial
    begin
        a = 0;
        m = 0;
    end
    
    // For generating waveforms
    initial
    begin
        $dumpfile("adder_tb.vcd");
        $dumpvars(0, a, m, sum, carry);
    end
    
    // Loop that tests every single possible set of inputs.
    always begin
        #1;
        for (loopa = 0; loopa <= 255; loopa++) begin
            for (loopm = 0; loopm <= 255; loopm++) begin
                correct_sum = loopa + loopm;
                if (correct_sum > 255)
                    correct_carry = 1;
                else
                    correct_carry = 0;                    
                $display("%d + %d = %d carry %d", a, m, sum, carry);
                // Checking to make sure that the adder module is generating the correct values.
                // 8 bit output, hence the sum is being checked against the lower 8 bits of correct_sum
                if ((sum != correct_sum[7:0]) || (carry != correct_carry))
                    $fatal;
                m++;
                #1; // Delays required by Icarus Verilog for some reason
            end
            a++;
            #1;
        end        
        $display("Test passed!");
        $finish;
    end
endmodule