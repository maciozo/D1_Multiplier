`timescale 1ns/1ps

module sequencer(   input logic clk,
                    input logic[16:0] register,
                    input logic n_reset,
                    input logic START,
                    input logic[3:0] count,
                    output logic ADD,
                    output logic SHIFT,
                    output logic RESET,
                    output logic DECREMENT,
                    output logic READY);
                    
    typedef enum logic[2:0] {stIdle, stAdd, stShift, stStop} state;
    
    // counter r(.*);
    
    state stCurrent, stNext;
    
    initial
    begin
        $dumpfile("multiplier_tb.vcd");
        $dumpvars(0, stCurrent, stNext);
    end
    
    always @(posedge clk, negedge n_reset)
    begin
        if (!n_reset)
        begin
            stCurrent <= stIdle;
        end
        else
        begin
            stCurrent <= stNext;
        end
    end
    
    always @(*)
    begin
        #1ps;
        case (stCurrent)
            stIdle: begin
                RESET = 1;
                SHIFT = 0;
                ADD = 0;
                DECREMENT = 0;
                READY = 0;
                if (START) begin
                    stNext = stIdle;
                end
                else begin
                    stNext = stAdd;
                end
            end
            
            stAdd: begin
                RESET = 0;
                SHIFT = 1;
                DECREMENT = 1;
                READY = 0;
				if (register[0]) begin
					ADD = 1;
				end
				else begin
					ADD = 0;
				end
				if (count > 0) begin
					stNext = stAdd;
				end
				else begin
					stNext = stStop;
				end
            end
                
            // stShift: begin
                // RESET = 0;
                // SHIFT = 1;
                // DECREMENT = 0;
                // ADD = 0;
                // READY = 0;
                // if (register[0]) begin
                    // if (count > 0) begin
						// ADD = 1;
						// stNext = stAdd;
					// end
					// else begin
						// ADD = 0;
						// stNext = stStop;
					// end
                // end
                // else begin
					// ADD = 0;
                    // stNext = stAdd;
                // end
            // end
                
            stStop: begin
                RESET = 0;
                SHIFT = 0;
                DECREMENT = 0;
                ADD = 0;
                READY = 1;
                if (!START) begin
                    stNext = stIdle;
                end
                else begin
                    stNext = stStop;
                end
            end
            
            default: begin
                RESET = 0;
                SHIFT = 0;
                ADD = 0;
                DECREMENT = 0;
                READY = 0;
                stNext = stIdle;
            end
        endcase
    end
endmodule