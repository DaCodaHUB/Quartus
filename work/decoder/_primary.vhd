library verilog;
use verilog.vl_types.all;
entity decoder is
    port(
        bin_in          : in     vl_logic_vector(2 downto 0);
        dec_out         : out    vl_logic_vector(4 downto 0)
    );
end decoder;
