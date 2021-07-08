module show(
    input clk, 
    input [7:0] cache, 
    output [7:1] cathodes, 
    output [3:0] AN
);

    wire [3:0] mux_data;
    reg [3:0] mux_1;
    reg [3:0] mux_10;
    reg [1:0] index = 2'b0;

    always @ (posedge clk) begin
        if(index == 2'd3) index <= 2'd0;
        else index <= index + 2'd1;
    end

    assign mux_data  =  (index == 2'd0) ? cache[3:0] : 
                        (index == 2'd1) ? cache[7:4] :
                        (index == 2'd2) ? 4'd0 : 4'd0;

    assign AN     =     (index == 2'd0) ? 4'b1110 : 
                        (index == 2'd1) ? 4'b1101 :
                        (index == 2'd2) ? 4'b1011 : 4'b0111;


    assign cathodes  =  (mux_data == 4'h0) ? 7'b0000001 : 
                        (mux_data == 4'h1) ? 7'b1001111 : 
                        (mux_data == 4'h2) ? 7'b0010010 : 
                        (mux_data == 4'h3) ? 7'b0000110 : 
                        (mux_data == 4'h4) ? 7'b1001100 : 
                        (mux_data == 4'h5) ? 7'b0100100 : 
                        (mux_data == 4'h6) ? 7'b0100000 : 
                        (mux_data == 4'h7) ? 7'b0001111 : 
                        (mux_data == 4'h8) ? 7'b0000000 : 
                        (mux_data == 4'h9) ? 7'b0000100 : 
                        (mux_data == 4'hA) ? 7'b0001000 : 
                        (mux_data == 4'hB) ? 7'b1100000 : 
                        (mux_data == 4'hC) ? 7'b1110010 : 
                        (mux_data == 4'hD) ? 7'b1000010 : 
                        (mux_data == 4'hE) ? 7'b0110000 : 7'b0111000;


endmodule