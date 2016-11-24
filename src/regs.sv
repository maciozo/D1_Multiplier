`timescale 1ns/1ps
module regs(input logic clk, 
            input logic n_reset,
            input logic ADD,
            input logic SHIFT,
            input logic RESET,
            input logic[7:0] sum,
            input logic[7:0] multiplier,
            input logic carry,
            output logic[16:0] register);

    always @(posedge clk, negedge n_reset) begin
        if (!n_reset) begin
            register <= 0;
        end
        
        else if (RESET) begin
            register <= {9'b0, multiplier};
        end
            
        else if (ADD & !SHIFT) begin
            register[16:8] <= {carry, sum};
        end
            
        else if (SHIFT & !ADD) begin
            register <= {1'b0, register[16:1]};
        end
		
        // Implemented for carrying out the SHIFT and ADD in the same clock cycle.
		else if (SHIFT & ADD) begin
            register <= {1'b0, carry, sum, register[7:1]};
        end
        
        else begin
            register <= register;
        end
    end
endmodule
