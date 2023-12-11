`timescale 1ns / 1ps

module tb_RISC();
/*
    reg [15:0] ALU_out, mem_out;
    reg [7:0] reg_write_data;
    reg reg_s1, reg_s0, data_ld;
    wire [15:0] reg_data_in;
    
    RegisterDataSelector RDS0(reg_write_data, mem_out, ALU_out,
        reg_s1, reg_s0, data_ld, reg_data_in);
    
    initial begin
        reg_write_data = 8'b10101010;
        mem_out = 16'b1111000011110000;
        ALU_out = 16'b0000000011111111;
        data_ld = 1;
        {reg_s1, reg_s0} = 2'b00;
        
        #50;
        {reg_s1, reg_s0} = 2'b01;
        #50;
        {reg_s1, reg_s0} = 2'b10;
        #50;
        data_ld = 0;
        {reg_s1, reg_s0} = 2'b00;
        #50;
        {reg_s1, reg_s0} = 2'b01;
        #50;
        {reg_s1, reg_s0} = 2'b10;
        
    end
*/

/*
    reg ld, sel;
    reg [7:0] pc_addr, d_addr;
    wire [7:0] mem_out;
    
    MemoryAddressSelector MAS0(ld, sel, pc_addr, d_addr, mem_out);
    
    initial begin
        ld = 1;
        sel = 0;
        pc_addr = 8'b11001100;
        d_addr = 8'b00110011;
        
        #50;
        sel = 1;
        #50;
        ld = 0;
        sel = 0;
        #50;
        sel = 1;
    end
*/

/*
    reg [7:0] addr;
    reg rd, wr;
    reg [15:0] data_in;
    wire [15:0] data_out;
    
    Memory256_16bit Mem0(addr, rd, wr, data_in, data_out);
    
    initial begin
        rd = 1;
        wr = 0;
        data_in = 16'b0000_1111_0000_1111;
        for(addr = 0; addr < 10; addr = addr + 1) begin
            #50;
        end
        #50;
        addr = 8'b00000101;
        rd = 0;
        wr = 1;
        #50;
        wr = 0;
        rd = 1;
        for(addr = 0; addr < 10; addr = addr + 1) begin
            #50;
        end
    end
*/

/*
    reg s2, s1, s0;
    reg [15:0] a, b;
    wire [15:0] c;
    
    ALU ALU0(s2, s1, s0, a, b, c);
    
    initial begin
        a = 16'b1000_0000_1000_0101;
        b = 16'b0000_0000_0000_0001;
        
        {s2, s1, s0} = 3'b000;
        #50;
        {s2, s1, s0} = 3'b001;
        #50;
        {s2, s1, s0} = 3'b010;
        #50;
        {s2, s1, s0} = 3'b011;
        #50;
        {s2, s1, s0} = 3'b100;
        #50;
        {s2, s1, s0} = 3'b101;
        #50;
        {s2, s1, s0} = 3'b110;
        #50;
        {s2, s1, s0} = 3'b111;
    end
*/

/*
    reg [15:0] in;
    wire out;
    
    ZFlag ZF0(in, out);
    
    initial begin
        in = 16'b0000_1000_0000_0000;
        #50;
        in = 16'b0000_0000_0000_0000;
        #50;
        in = 1;
        #50
        in = 0;
    end
*/

/*
    reg [15:0] in;
    reg ld;
    wire [15:0] out;
    
    InstructionRegister IR0(ld, in, out);
    
    initial begin
        in = 16'b0000_1000_1000_0000;
        ld = 1;
        #50;
        in = 16'b0000_1000_1000_1000;
        #50;
        in = 16'b0000_0000_0000_0000;
        ld = 0;
        #50;
        in = 16'b0000_0000_1111_0000;
        #50;
        in = 16'b1111_0000_0000_0000;
        #50;
        ld = 1;
        in = 16'b1111_1111_1111_1111;
    end
*/
endmodule
