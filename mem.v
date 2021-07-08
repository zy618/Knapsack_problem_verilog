`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/09 16:20:23
// Design Name: 
// Module Name: mem
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


module mem
#(parameter MEM_SIZE = 512)
(
    input clk,
    input [15:0] addr,
    input rd_en,
    input wr_en,
    input reverse,
    output reg [31:0] rdata,
    input [31:0] wdata
    );
    
    reg [31:0] memData [MEM_SIZE:1];
    reg flag;
    reg [5:0] i = 6'b0;
    reg [9:0] j = 10'b1;

    always@(posedge reverse)begin
        flag <= 1'b1;
    end
    always@(posedge clk)begin
        begin
            if(wr_en) memData[addr] <= wdata;
            if(rd_en)  rdata <=  memData[addr];
            else rdata<= 32'd0;
            if(flag) begin
                if(i < 6'd32)begin
                    if(j < MEM_SIZE + 10'd1)begin
                        memData[j][i] <= ~memData[j][i];
                        j <= j + 10'b1;
                    end
                    else begin
                        j <= 10'b1;
                        i <= i + 6'd1;
                    end
                end
                else flag <= 1'b0;
            end 
        end
    end

endmodule
