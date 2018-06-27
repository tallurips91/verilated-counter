module counter
#(
  // Parameter list
  parameter CYCLES_PER_COUNT = 8
 )
(
  // Port list
  input clock_i,
  input reset_i,
  input enable_i,
  output reg [7:0] count_o
);

  reg [7:0] internal_count;

  always @(posedge clock_i) begin
    if (reset_i) begin
      count_o <= 0;
      internal_count <= 0;
    end else if (enable_i) begin
      if (internal_count == (CYCLES_PER_COUNT - 1)) begin
        count_o <= count_o + 1;
        internal_count <= 0;
      end else
        internal_count <= internal_count + 1;
    end
  end

  function [7:0] read_internal_counter;
    /* verilator public */
    begin
      read_internal_counter = internal_count;
    end
  endfunction

  task write_internal_counter;
    /* verilator public */
    input [7:0] new_internal_count;
    begin
      internal_count = new_internal_count;
    end
  endtask

endmodule
