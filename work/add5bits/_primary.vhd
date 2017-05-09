library verilog;
use verilog.vl_types.all;
entity add5bits is
    port(
        A               : in     vl_logic_vector(4 downto 0);
        B               : in     vl_logic_vector(4 downto 0);
        \out\           : out    vl_logic_vector(4 downto 0);
        stop            : in     vl_logic;
        E               : in     vl_logic
    );
end add5bits;
