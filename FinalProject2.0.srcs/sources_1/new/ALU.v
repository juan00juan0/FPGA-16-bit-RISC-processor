`timescale 1ns / 1ps

module ALU(
    input s2,
    input s1,
    input s0,
    input [15:0] A,
    input [15:0] B,
    output reg [15:0] C);
    
    reg A_MSB;
    
    always @(*) begin
        case({s2, s1, s0})
            3'b000: C <= A + B;
            3'b001: C <= A - B;
            3'b010: C <= A & B;
            3'b011: C <= A | B;
            3'b100: C <= A ^ B;
            3'b101: C <= ~A;
            3'b110: C <= A << 1;
            3'b111: begin
                A_MSB <= A[15];
                C <= A >> 1;
                C[15] <= A_MSB;
            end
        endcase
    end
endmodule
