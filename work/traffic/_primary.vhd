library verilog;
use verilog.vl_types.all;
entity traffic is
    generic(
        A               : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi1);
        B               : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi1);
        C               : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi0);
        D               : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        w               : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(2 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of A : constant is 2;
    attribute mti_svvh_generic_type of B : constant is 2;
    attribute mti_svvh_generic_type of C : constant is 2;
    attribute mti_svvh_generic_type of D : constant is 2;
end traffic;
