`timescale 1ns/1ps
module counter( input logic clk,
                input logic n_reset,
                input logic DECREMENT,
                input logic RESET,
                output logic[3:0] count);
                
    initial
    begin
        $dumpfile("multiplier_tb.vcd");
        $dumpvars(0, count);
    end
                
    always @(posedge clk, negedge n_reset)
    begin
        if (!n_reset)
        begin
            count <= 0;
        end
        else if (RESET & !DECREMENT)
        begin
            count <= 7;
        end
        else if (DECREMENT & !RESET)
        begin
            count <= count - 1;
        end
    end
endmodule