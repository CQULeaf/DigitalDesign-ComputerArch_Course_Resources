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
    output memtoreg, memwrite,
    output pcsrc, alusrc,
    output regdst, regwrite,
    output jump,
    output [2:0] alucontrol,
    output [6:0] seg,
    output [7:0] ans
    );
    
    wire clk;
    wire zero;
    wire [31:0] pc;
    wire [31:0] inst;
    wire [31:0] pc_next;
    
    clk_div clk_div_inst(
        .clk_in(clk_in),
        .rst(rst),
        .hz(clk)
        );
        
     pc pc_update(
        .clk(clk_in),
        .rst(rst),
        .pc(pc),
        .newPC(pc_next)
     );

    adder adder_inst(
        .pc(pc),
        .pc_next(pc_next)
        );

    blk_mem_gen_0 blk_mem_gen_0_inst(
        .clka(clk_in),
        .addra(pc[6:3]),
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