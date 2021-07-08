`timescale 1ns / 1ps
module top (
    input clk,reset,
    output [3:0] AN,
    output [7:1] cathodes);

    parameter MAX_CAP=64;
    parameter MAX_ITEM=16;

    reg [7:0] cache [MAX_CAP-1:0];
    reg [7:0] weight [MAX_ITEM-1:0];
    reg [7:0] value [MAX_ITEM-1:0];
    reg [7:0] item_num, cap, cnt;

    integer i;
    // always @(posedge ) begin
    //     for(i=0;i<MAX_CAP;i=i+1) cache[i]<=8'b0;
    //     item_num<=8'd5;
    //     cap<=8'd5;
    //     weight[0]<=8'd2;
    //     weight[1]<=8'd1;
    //     weight[2]<=8'd3;
    //     weight[3]<=8'd2;
    //     weight[4]<=8'd1;
    //     value[0]<=8'd12;
    //     value[1]<=8'd10;
    //     value[2]<=8'd20;
    //     value[3]<=8'd15;
    //     value[4]<=8'd8;
    // end

    always @(posedge CLK_10 & cnt!=item_num+1) begin
        if (reset) begin
            cnt <= 0;
            for(i=0;i<MAX_CAP;i=i+1) cache[i]<=8'b0;
            item_num<=8'd5;
            cap<=8'd5;
            weight[0]<=8'd2;
            weight[1]<=8'd1;
            weight[2]<=8'd3;
            weight[3]<=8'd2;
            weight[4]<=8'd1;
            value[0]<=8'd12;
            value[1]<=8'd10;
            value[2]<=8'd20;
            value[3]<=8'd15;
            value[4]<=8'd8;
        end
        else begin
            // todo parallel 非阻塞赋值？ 根据内容动态调整for?
            for(i=MAX_CAP-1;i>=0;i=i-1) 
                cache[i]<=
                    (cache[i]>(cache[i-weight[cnt]]+value[cnt]) | i < weight[cnt])?
                        cache[i]:(cache[i-weight[cnt]]+value[cnt]);
            $display("cnt=%d, cache=",cnt, cache[0] ,cache[1],cache[2] ,cache[3], cache[4], cache[5]);
            cnt <= cnt+1;
        end
    end

    clk_gen clk_1k(.clk(clk),.reset(reset),.clk_1K(CLK_1K));
    clk_gen1 clk_10(.clk(clk),.reset(reset),.clk_10(CLK_10));
    show SHOW(.clk(CLK_1K),.cache(cache[5]),.AN(AN),.cathodes(cathodes));

    // UART_MEM(.clk(clk),.rst(reset),
    //         .mem2uart(mem2uart),
    //         .reverse(reverse),
    //         .Rx_Serial(Rx_Serial),
    //         .recv_done(recv_done),
    //         .send_done(send_done),
    //         .Tx_Serial(Tx_Serial));

endmodule //top