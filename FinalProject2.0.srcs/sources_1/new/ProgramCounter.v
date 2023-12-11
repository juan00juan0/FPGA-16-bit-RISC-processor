`timescale 1ns / 1ps

module ProgramCounter(ld, clr, up, in, out);
    input wire ld, clr, up;
    input [7:0] in;
    output reg [7:0] out;
    
    always @(*) begin
        if(clr == 1'b1) begin
            out <= 8'b00000000;
        end
        else if(up == 1'b1) begin
            out <= out + 1;
        end
        else if(ld == 1'b1) begin
            out <= in;
        end
    end
endmodule
