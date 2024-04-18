`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/16 23:47:52
// Design Name: 
// Module Name: controller
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


module controller(
    input wire [5:0] op, funct,
    input wire zero,
    output memtoreg, memwrite,
    output pcsrc, alusrc,
    output wire regdst, regwrite,
    output jump,
    output [2:0] alucontrol
);
    // 连接至相应端口
    wire [1:0] aluop;
    wire branch;

    // 主解码器
    main_decoder md(
        .op(op),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .branch(branch),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .aluop(aluop)
    );

    // ALU 解码器
    alu_decoder ad(
        .funct(funct),
        .aluop(aluop),
        .alucontrol(alucontrol)
    );

    assign pcsrc = branch & zero;

endmodule