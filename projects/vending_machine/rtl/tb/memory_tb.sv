module memory_tb();

// Testbench parameters:
localparam unsigned PERIOD = 'd10;

// DUT parameters:
localparam PRICE_COFFEE = 8'h19;
localparam PRICE_WATER  = 8'h32;
localparam PRICE_JUICE  = 8'h4B;
localparam PRICE_SNACK  = 8'h64;
localparam STOCK_COFFEE = 8'h05;
localparam STOCK_WATER  = 8'h05;
localparam STOCK_JUICE  = 8'h03;
localparam STOCK_SNACK  = 8'h02;

// Testbench registers, wires and variables:
logic       w_clk;
logic       w_rst;
logic       w_mem_read;
logic       w_mem_write;
logic [1:0] w_sel_item;
logic [7:0] w_price;
logic [7:0] w_stock;

// DUT instanciation:
memory #(
  .PRICE_COFFEE(PRICE_COFFEE),
  .PRICE_WATER (PRICE_WATER ),
  .PRICE_JUICE (PRICE_JUICE ),
  .PRICE_SNACK (PRICE_SNACK ),
  .STOCK_COFFEE(STOCK_COFFEE),
  .STOCK_WATER (STOCK_WATER ),
  .STOCK_JUICE (STOCK_JUICE ),
  .STOCK_SNACK (STOCK_SNACK )
) uu_memory (
  .clk      (w_clk      ),
  .rst      (w_rst      ),
  .mem_read (w_mem_read ),
  .mem_write(w_mem_write),
  .sel_item (w_sel_item ),
  .price    (w_price    ),
  .stock    (w_stock    )
);

always #(PERIOD/2) w_clk = ~w_clk;

// Signal dumping for VCD generation:
initial begin
    $dumpfile("waveform.vcd");
    $dumpvars;
end

initial begin
  w_clk = 1'b0;
  w_rst = 1'b0;
  repeat(10) @(posedge w_clk);

  $stop();
  $finish();
end

endmodule
