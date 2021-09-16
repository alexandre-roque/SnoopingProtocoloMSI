library verilog;
use verilog.vl_types.all;
entity MaquinaDeEstadosOuvinte is
    port(
        estado          : in     vl_logic_vector(1 downto 0);
        estadoResultante: out    vl_logic_vector(1 downto 0);
        \bus\           : in     vl_logic_vector(1 downto 0);
        writeback       : out    vl_logic;
        abortaAcessoMemoria: out    vl_logic;
        Run             : in     vl_logic
    );
end MaquinaDeEstadosOuvinte;
