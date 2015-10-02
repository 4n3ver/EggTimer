library verilog;
use verilog.vl_types.all;
entity ClockDiviver is
    generic(
        freq            : integer := 1
    );
    port(
        clkOut          : out    vl_logic;
        clkIn           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of freq : constant is 1;
end ClockDiviver;
