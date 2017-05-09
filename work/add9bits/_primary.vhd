library verilog;
use verilog.vl_types.all;
entity add9bits is
    port(
        A               : in     vl_logic_vector(9 downto 0);
        B               : in     vl_logic_vector(9 downto 0);
        S               : out    vl_logic_vector(9 downto 0);
        count           : in     vl_logic
    );
end add9bits;
