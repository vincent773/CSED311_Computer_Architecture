`include "opcodes.v"

module ControlUnit (
    part_of_inst, mem_read,
    mem_to_reg, mem_write, alu_src, write_enable, pc_to_reg, alu_op, is_ecall,
    is_jal, is_jalr, branch);

    input wire[6:0] part_of_inst;

    output reg mem_read;//
    output reg mem_to_reg;//
    output reg mem_write;//
    output reg alu_src;//
    output reg write_enable;//
    output reg pc_to_reg;//
    output reg [6:0] alu_op;//
    output reg is_ecall;//
    output reg is_jal;
    output reg is_jalr;
    output reg branch;

    always @(*) begin
        alu_op <= part_of_inst;

        if(part_of_inst==`JAL) begin
            mem_read<=0;
            mem_to_reg<=0;
            mem_write<=0;
            alu_src<=1;
            write_enable<=1;
            pc_to_reg<=1;
            is_ecall<=0;
            is_jal<=1;
            is_jalr<=0;
            branch<=0;
            //$display("JAL used\n");
        end 

        else if(part_of_inst==`JALR) begin
            mem_read<=0;
            mem_to_reg<=0;
            mem_write<=0;
            alu_src<=1;
            write_enable<=1;
            pc_to_reg<=1;
            is_ecall<=0;
            is_jal<=0;
            is_jalr<=1;
            branch<=0;
            //$display("JALR used\n");
        end 

        else if(part_of_inst==`BRANCH) begin
            mem_read<=0;
            mem_to_reg<=0;
            mem_write<=0;
            alu_src<=0;
            write_enable<=0;
            pc_to_reg<=0;
            is_ecall<=0;
            is_jal<=0;
            is_jalr<=0;
            branch<=1;
            //$display("BRANCH used\n");
        end

        else if (part_of_inst==`LOAD) begin  //MemRead
            mem_read<=1;
            mem_to_reg<=1;
            mem_write<=0;
            alu_src<=1;
            write_enable<=1;
            pc_to_reg<=0;
            is_ecall<=0;
            is_jal<=0;
            is_jalr<=0;
            branch<=0;
            //$display("LOAD used\n");
        end

        else if (part_of_inst==`STORE) begin  //MemWrite
            mem_read<=0;
            mem_to_reg<=0;
            mem_write<=1;
            alu_src<=1;
            write_enable<=0;
            pc_to_reg<=0;
            is_ecall<=0;
            is_jal<=0;
            is_jalr<=0;
            branch<=0;
            //$display("STORE used\n");
        end

        else if (part_of_inst==`ARITHMETIC) begin
            mem_read<=0;
            mem_to_reg<=0;
            mem_write<=0;
            alu_src<=0;
            write_enable<=1;
            pc_to_reg<=0;
            is_ecall<=0;
            is_jal<=0;
            is_jalr<=0;
            branch<=0;
            //$display("ARITHMETIC used\n");
        end

        else if (part_of_inst==`ARITHMETIC_IMM) begin
            mem_read<=0;
            mem_to_reg<=0;
            mem_write<=0;
            alu_src<=1;
            write_enable<=1;
            pc_to_reg<=0;
            is_ecall<=0;
            is_jal<=0;
            is_jalr<=0;
            branch<=0;
            //$display("ARITHMETIC_IMM used\n");
        end

	    else if (part_of_inst==`ECALL) begin
            mem_read<=0;
            mem_to_reg<=0;
            mem_write<=0;
            alu_src<=0;
            write_enable<=0;
            pc_to_reg<=0;
            is_ecall<=1;
            is_jal<=0;
            is_jalr<=0;
            branch<=0;
            //$display("ECALL used\n");
        end
    end
endmodule
