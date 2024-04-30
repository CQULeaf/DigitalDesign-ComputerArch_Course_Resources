`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/30 20:21:37
// Design Name: 
// Module Name: Lab2_sim
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


module Lab2_sim();
    reg clk, rst;
    wire [2:0] alucontrol;
    wire regwrite, regdst, jump, alusrc, pcsrc, memwrite, memtoreg, zero;
    wire [5:0] op, funct;
    wire inst_ce;
    wire [31:0] pc, inst;

    top top_inst(
        .clk_in(clk),
        .rst(rst),
        .inst_ce(inst_ce),
        .pc(pc),
        .inst(inst),
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

    always #5 clk = ~clk;

    initial begin
        clk = 1;
        rst = 1;
        #5 rst = 0;
    end

    always #10 begin
        $display("pc=%h inst=%h zero=%h memtoreg=%h memwrite=%h pcsrc=%h alusrc=%h regdst=%h regwrite=%h jump=%h alucontrol=%h", pc, inst, zero, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
    end

endmodule
