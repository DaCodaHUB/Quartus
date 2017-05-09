library verilog;
use verilog.vl_types.all;
entity add3bits is
    port(
        A               : in     vl_logic_vector(2 downto 0);
        B               : in     vl_logic_vector(2 downto 0);
        \out\           : out    vl_logic_vector(2 downto 0);
        stop            : in     vl_logic
    );
end add3bits;
