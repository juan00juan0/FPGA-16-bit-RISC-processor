`timescale 1ns / 1ps

module PCAndOffset(
    input [7:0] pc,
    input [7:0] offset,
    output [7:0] out);
    
    assign out = pc + offset - 1;
endmodule
