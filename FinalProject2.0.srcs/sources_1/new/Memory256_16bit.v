`timescale 1ns / 1ps

module Memory256_16bit(
    input [7:0] addr,
    input rd,
    input wr,
    input wire [15:0] W_data,
    output reg [15:0] R_data,
    input clk,
    output [7:0] disp_seg_o,
    output [7:0] disp_an_o);
    
    reg [15:0] Memory [255:0];
    
    initial begin
        Memory[0] <= 16'b1001_0101_1100_1001;
        Memory[1] <= 16'b1001_0110_1100_1010;
        Memory[2] <= 16'b0000_0111_0101_0110;
        Memory[3] <= 16'b1010_0111_1100_1011;
        Memory[4] <= 16'b1000_1000_1111_1010;
        Memory[5] <= 16'b0001_0100_1000_0101;
        Memory[6] <= 16'b1010_0100_1100_1100;
        Memory[7] <= 16'b0110_0010_0111_0000;
        Memory[8] <= 16'b0100_0010_0011_0100;
        Memory[9] <= 16'b1010_0010_1100_1101;
        Memory[201] <= 16'b0000_1000_0000_0001;
        Memory[202] <= 16'b0000_0000_0000_0001;
    end
    
    
    always @(*) begin
        if(rd == 1) begin
            R_data <= Memory[addr];
        end
        else if(wr == 1) begin
            Memory[addr] <= W_data;
        end
    end
    
    reg [7:0] seg, seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7;
    reg [7:0] loc;
    reg [19:0] counter = 0;
    reg [19:0] d;
    
    always @(posedge clk) begin
        counter = counter + 1;
    end
    
    always @(Memory[203]) begin
        begin
            d[3:0] <= Memory[203] % 10;
            d[7:4] <= (Memory[203]/10) % 10;
            d[11:8] <= (Memory[203]/100) % 10;
            d[15:12] <= (Memory[203]/1000) % 10;
            d[19:16] <= (Memory[203]/10000) % 10;
        end
    end
    
    task sw_seg(input [3:0]a, output [7:0]s);
        parameter blank = 8'b1111_1111;
        parameter zero = 8'b1100_0000;
        parameter one = 8'b1111_1001;
        parameter two = 8'b1010_0100;
        parameter three = 8'b1011_0000;
        parameter four = 8'b1001_1001;
        parameter five = 8'b1001_0010;
        parameter six = 8'b1000_0010;
        parameter seven = 8'b1111_1000;
        parameter eight = 8'b1000_0000;
        parameter nine = 8'b1001_0000;
        begin
            case(a[3:0])
                4'b0000: s = zero;
                4'b0001: s = one;
                4'b0010: s = two;
                4'b0011: s = three;
                
                4'b0100: s = four;
                4'b0101: s = five;
                4'b0110: s = six;
                4'b0111: s = seven;
                
                4'b1000: s = eight;
                4'b1001: s = nine;
                4'b1111: s = blank;
            endcase
        end
    endtask
    
    always @(d) begin
        sw_seg(d[3:0], seg0);
        sw_seg(d[7:4], seg1);
        sw_seg(d[11:8], seg2);
        sw_seg(d[15:12], seg3);
        sw_seg(d[19:16], seg4);
        sw_seg(4'b1111, seg5);
        sw_seg(4'b1111, seg6);
        sw_seg(4'b1111, seg7);
    end
    
    
    always @(counter[19:17]) begin
        case(counter[19:17])
            3'b000: begin loc = 8'b1111_1110;
            seg = seg0; end
            3'b010: begin loc = 8'b1111_1101;
            seg = seg1; end
            3'b100: begin loc = 8'b1111_1011;
            seg = seg2; end
            3'b110: begin loc = 8'b1111_0111;
            seg = seg3; end
            3'b001: begin loc = 8'b1110_1111;
            seg = seg4; end
            3'b011: begin loc = 8'b1101_1111;
            seg = seg5; end
            3'b101: begin loc = 8'b1011_1111;
            seg = seg6; end
            3'b111: begin loc = 8'b0111_1111;
            seg = seg7; end
        endcase
    end
    
    
    assign disp_seg_o = seg;
    assign disp_an_o = loc;

endmodule
