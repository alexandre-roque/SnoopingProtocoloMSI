library verilog;
use verilog.vl_types.all;
entity cache is
    port(
        tagProcessador  : in     vl_logic_vector(1 downto 0);
        Run             : in     vl_logic;
        inst            : in     vl_logic_vector(15 downto 0);
        Done            : out    vl_logic;
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        valorRetorno    : out    vl_logic_vector(6 downto 0);
        saidaBus        : out    vl_logic_vector(1 downto 0);
        writeback       : out    vl_logic;
        valorParaMemoria: out    vl_logic_vector(6 downto 0);
        LeituraEscritaMemoria: out    vl_logic;
        tagParaMemoria  : out    vl_logic_vector(4 downto 0);
        buscaCache      : out    vl_logic;
        inputBusca      : in     vl_logic;
        resultadoBusca  : out    vl_logic_vector(6 downto 0);
        resultadoRecebidoBusca: in     vl_logic_vector(6 downto 0);
        valorRecebidoDaMemoria: in     vl_logic_vector(6 downto 0);
        entradaBus      : in     vl_logic_vector(1 downto 0);
        achouBusca      : out    vl_logic;
        achouBuscaInput : in     vl_logic;
        auxWriteBackOuvinte: out    vl_logic
    );
end cache;
