`timescale 1ns/1ps
module adder(input logic[3:0] a, input logic[3:0] m, output logic[3:0] sum, output logic carry);

    assign {carry, sum} = {1'b0, a} + {1'b0, m};
    
endmodule