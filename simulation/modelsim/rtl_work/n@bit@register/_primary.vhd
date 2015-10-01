library verilog;
use verilog.vl_types.all;
entity nBitRegister is
    generic(
        n               : integer := 8
    );
    port(
        \out\           : out    vl_logic_vector;
        \in\            : in     vl_logic_vector;
        wr_en           : in     vl_logic;
        clk             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end nBitRegister;
