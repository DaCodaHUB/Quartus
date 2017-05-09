library verilog;
use verilog.vl_types.all;
entity adder is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        CI              : in     vl_logic;
        CO              : out    vl_logic;
        S               : out    vl_logic;
        E               : in     vl_logic
    );
end adder;
