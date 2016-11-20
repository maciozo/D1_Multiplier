module counter( input logic clk,
                input logic n_reset,
                input logic DECREMENT,
                input logic RESET,
                output logic[2:0] count);
                
    always @(posedge clk, negedge n_reset)
    begin
        if (!n_reset)
        begin
            count <= 0;
        end
        else if (RESET & !DECREMENT)
        begin
            count <= 4;
        end
        else if (DECREMENT & !RESET)
        begin
            count <= count - 1;
        end
    end
endmodule