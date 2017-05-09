library verilog;
use verilog.vl_types.all;
entity seg7 is
    port(
        bcd             : in     vl_logic_vector(4 downto 0);
        leds1           : out    vl_logic_vector(6 downto 0);
        leds2           : out    vl_logic_vector(6 downto 0)
    );
end seg7;
