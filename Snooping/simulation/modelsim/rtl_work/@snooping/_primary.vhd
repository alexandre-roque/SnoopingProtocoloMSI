library verilog;
use verilog.vl_types.all;
entity Snooping is
    port(
        RunFirst        : in     vl_logic;
        clock           : in     vl_logic
    );
end Snooping;
