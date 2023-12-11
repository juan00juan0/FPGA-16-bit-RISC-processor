`timescale 1ns / 1ps

module ZFlag(
    input [15:0] in,
    output reg out);
    
    always @(*) begin
        case(in)
            16'b0000000000000000:  out <= 1;
            default:               out <= 0;
        endcase
    end
endmodule
