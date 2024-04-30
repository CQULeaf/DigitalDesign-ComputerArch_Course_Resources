`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/30 19:34:13
// Design Name: 
// Module Name: top
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


module top(
    input clk_in, rst,
    output reg inst_ce,
    output [31:0] pc,
    output [31:0] inst,
    output zero,
    output memtoreg, memwrite,
    output pcsrc, alusrc,
    output regdst, regwrite,
    output jump,
    output [2:0] alucontrol
    );
    wire clk;

    clk_div clk_div_inst(
        .clk_in(clk_in),
        .rst(rst),
        .hz(clk)
        );

    adder adder_inst(
        .pc(pc),
        .pc_next(pc),
        .clk(clk),
        .rst(rst),
        .inst_ce(inst_ce)
        );

    blk_mem_gen_0 blk_mem_gen_0_inst(
        .clka(clk),
        .wea(4'b0000),
        .addra(pc[31:2]),
        .dina(32'b0),
        .douta(inst)
        );

    controller controller_inst(
        .op(inst[31:26]),
        .funct(inst[5:0]),
        .zero(zero),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol)
        );

    display display_inst(
        .clk(clk),
        .rst(rst),
        .s(inst),
        .seg(seg),
        .ans(ans)
        );
endmodule
