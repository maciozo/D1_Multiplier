`timescale 1ns/1ps

module adder_tb;

    logic[3:0] a;
    logic[3:0] m;
    logic[3:0] sum;
    logic carry;
    logic clk;
    
    logic[8:0] correct_sum;
    logic correct_carry;
    
    int loopa;
    int loopm;
    
    adder r(.*);
    
    initial
    begin
        a = 0;
        m = 0;
    end
    
    always //@(posedge clk)
    begin
    
        for (loopa = 0; loopa <= 15; loopa++)
        begin
            for (loopm = 0; loopm <= 15; loopm++)
            begin
            
                correct_sum = loopa + loopm;
                if (correct_sum > 15)
                    correct_carry = 1;
                else
                    correct_carry = 0;
                    
                $display("%d + %d = %d carry %d", a, m, sum, carry);
                if ((sum != correct_sum[3:0]) || (carry != correct_carry))
                    $fatal;
                m++;
                #1;
            end
            a++;
            #1;
        end
        
        $display("Test passed!");
        $finish;
    end
endmodule