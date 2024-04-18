`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/16 23:45:03
// Design Name: 
// Module Name: alu_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_decoder(
    input [5:0] funct,
    input [1:0] aluop,
    output wire [2:0] alucontrol
);
    // 取指译码
    assign alucontrol = (aluop == 2'b00) ? 3'b010 :   // sw
                        (aluop == 2'b01) ? 3'b110 :  // beq
                        (aluop == 2'b10) ? (
                            (funct == 6'b100000) ? 3'b010 :  // add
                            (funct == 6'b100010) ? 3'b110 :  // sub
                            (funct == 6'b100100) ? 3'b000 :  // and
                            (funct == 6'b100101) ? 3'b001 :  // or
                            (funct == 6'b101010) ? 3'b111 :  // slt
                            3'b000
                        ) : 3'b000;

endmodule