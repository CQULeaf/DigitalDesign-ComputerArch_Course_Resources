`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/12 17:52:48
// Design Name: 
// Module Name: mips
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


module mips(
	input wire clk,rst,
	output wire[31:0] pc,
	input wire[31:0] instr,
	output wire memwriteM,
	output wire[31:0] aluout,writedata,
	input wire[31:0] readdata ,
    output wire stallD, pcsrc
    );
	
	wire memtoreg,alusrc,regdst,regwrite,jump,branch,equal,memwrite;
	wire[2:0] alucontrol;
    wire [5:0] op, funct;

	controller c(.op(instr[31:26]),.funct(instr[5:0]),.zero(equal),.memtoreg(memtoreg),.memwrite(memwrite),
	.pcsrc(pcsrc),.alusrc(alusrc),.regdst(regdst),.regwrite(regwrite),.jump(jump),.alucontrol(alucontrol), .branch(branch));
	
	datapath dp(.clk(clk), .rst(rst), .memtoregD(memtoreg), .branchD(branch), .alusrcD(alusrc),
	.regdstD(regdst), .regwriteD(regwrite), .jumpD(jump),.alucontrolD(alucontrol),.pcF(pc),
	.instrD(instr),.aluoutM(aluout), .writedataM(writedata),.readdataM(readdata), .memwriteD(memwrite), .pcsrcD(pcsrc),
    .stallD(stallD),.equalD(equal),.op(op),.funct(funct), .memwriteM(memwriteM));

endmodule