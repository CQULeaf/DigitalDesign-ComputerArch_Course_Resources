`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/16 20:03:20
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
	output wire memwrite,
	output wire[31:0] aluout,writedata,
	input wire[31:0] readdata 
    );
	
	wire memtoreg,alusrc,regdst,regwrite,jump,pcsrc,zero;
	wire[2:0] alucontrol;

	controller c(.op(instr[31:26]),.funct(instr[5:0]),.zero(zero),.memtoreg(memtoreg),.memwrite(memwrite),
	.pcsrc(pcsrc),.alusrc(alusrc),.regdst(regdst),.regwrite(regwrite),.jump(jump),.alucontrol(alucontrol));
	
	datapath dp(.clk(clk), .rst(rst), .memtoreg(memtoreg), .memwrite(memwrite), .pcsrc(pcsrc), .alusrc(alusrc),
	.regdst(regdst), .regwrite(regwrite), .jump(jump),.alucontrol(alucontrol),.pc(pc), 
	.instr(instr),.aluout(aluout), .writedata(writedata),.readdata(readdata));

endmodule