library verilog;
use verilog.vl_types.all;
entity LFSR is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        q               : out    vl_logic_vector(8 downto 0)
    );
end LFSR;
