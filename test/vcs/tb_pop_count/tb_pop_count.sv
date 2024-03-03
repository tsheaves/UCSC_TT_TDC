/*
   Filename: tb_pop_count.sv
    Version: 1.0
   Standard: SystemVerilog 2012
Description: Simple TB for all pop count designs
     Author: Tyler Sheaves (@tsheaves)
*/

module tb_pop_count();
  
    localparam N = 64;
    bit 
        clk, rst, en;
    logic [N-1:0]
        x;
    logic [$clog2(N):0]
        y, y_simple_sv, y_simple_loop;

    always #10 clk = ~clk;
  
    initial begin
        $dumpfile("tb_pop_count.vcd");
        $dumpvars;
        @(posedge clk)
        rst <= 1'b1;
        en <= 1'b0; 
        ////////// Test corner cases ////////// 
        @(posedge clk)
        x <= {N{1'b1}};
        rst <= 1'b0;
        en <= 1'b1;
        @(posedge clk)
        x <= {N{1'b0}};
        ////////// Test random data ////////// 
        repeat(100000) begin
            @(posedge clk);
            x <= {$urandom(), $urandom()};
            rst <= 1'b0;
        end
        $finish();
    end
    
    ////////// DUT //////////

    // Assertions in DUTs
    //  - popcount matches SV $onescount

    pop_count_8_4 #(.N(N)) DUT0
    (
        .clk(clk), 
        .rst(rst),
        .en(en),
        .x(x),
        .y(y)
    );

    pop_count_simple #(.N(N), .METHOD("SV")) DUT1
    (
        .clk(clk), 
        .rst(rst),
        .en(en),
        .x(x),
        .y(y_simple_sv)
    );

    pop_count_simple #(.N(N), .METHOD("LOOP")) DUT2
    (
        .clk(clk), 
        .rst(rst),
        .en(en),
        .x(x),
        .y(y_simple_loop)
    );

    endmodule
