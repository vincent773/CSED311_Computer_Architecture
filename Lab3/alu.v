//completed-gyubin
`include "opcodes.v"

module ALU #(parameter data_width = 32) ( 
	input [3 : 0] alu_op,
    input [data_width - 1 : 0] alu_in_1, 
	input [data_width - 1 : 0] alu_in_2,
       	output reg [data_width - 1: 0] alu_result,
        output reg alu_bcond);

always @(*) begin
    alu_result = 0;
    alu_bcond = 0;
    
	case(alu_op)
	    `ALU_ADD: begin
            alu_result = alu_in_1 + alu_in_2;
            //$display("ADD check\n");
        end
        `ALU_SUB: alu_result = alu_in_1 - alu_in_2;
        `ALU_OR: alu_result = alu_in_1 | alu_in_2;
        `ALU_AND: alu_result = alu_in_1 & alu_in_2;
        `ALU_SLL: alu_result = alu_in_1 << alu_in_2;
        `ALU_SRL: alu_result = alu_in_1 >> alu_in_2;
        `ALU_XOR: alu_result = alu_in_1 ^ alu_in_2;
        
        `ALU_BEQ: begin
            if(alu_in_1 == alu_in_2) alu_bcond = 1;
        end
        `ALU_BNE: begin
            if(alu_in_1 != alu_in_2) alu_bcond = 1;
        end
        `ALU_BLT: begin
            if(alu_in_1 < alu_in_2) alu_bcond = 1;
        end
        `ALU_BGE: begin
            if(alu_in_1 >= alu_in_2) alu_bcond = 1;
        end

	endcase
end

endmodule

