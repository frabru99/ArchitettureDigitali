library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity SistemaB is
    port (
        clk: in std_logic;

        reqfromA_sis: in std_logic;
        loadOperand_fromA_sis: in std_logic;
        data_in_fromA_sis: in std_logic_vector(8 downto 0);

        reset: in std_logic;

        okToSend_sis: out std_logic;
        acktoA_sis: out std_logic



    );
end entity SistemaB;


architecture rtl of SistemaB is


    component MEM port(
        in_Mem : in STD_LOGIC_VECTOR(8 downto 0); --è da 9 per considerare un bit di overflow 
        write_Mem : in STD_LOGIC;
        read_Mem: in STD_LOGIC;
        adress_Mem : in STD_LOGIC_VECTOR(4 downto 0);
        

        dataread_out: out STD_LOGIc_VECTOR(8 downto 0)
    );
    end component;

    component AdderStrings port(
        X: in std_logic_vector(8 downto 0);
        Y: in std_logic_vector(8 downto 0);

        start_operation: in std_logic;

        data_out: out std_logic_vector(8 downto 0)
    );
    end component;

    component contMod16 
    generic (
        n_bits : positive :=4
    );
    port(
        clk : in std_logic; --segnale di conteggio (acktoA)
        reset : in std_logic;

        cont: out std_logic_vector(n_bits-1 downto 0) 
    );
    end component;

    component CUB port(
        clk: in std_logic;
        reset: in std_logic;

        reqfromA: in std_logic;
        data_in_fromA: in std_logic_vector(8 downto 0);
        data_fromMem: in std_logic_vector(8 downto 0);
        loadOperandfromA: in std_logic;

        --comunicazione
        okToSend: out std_logic;
        acktoA: out std_logic; --lo uso anche come segnale per avanzare il conteggio del contatore interno a B, per le posizioni omologhe

        --sincronizzazione e conteggio
        writeOnMem: out std_logic;
        readfromMem: out std_logic;
        start_adding: out std_logic;
        count_signal: out std_logic;

        X: out std_logic_vector(8 downto 0);
        Y: out std_logic_vector(8 downto 0) --operandi
    ); 
    end component;
    

    signal memToCu: std_logic_vector(8 downto 0);

    signal enableWrite: std_logic;
    signal enableRead: std_logic;
    signal startAdder: std_logic;
    signal dataX: std_logic_vector(8 downto 0);
    signal dataY: std_logic_vector(8 downto 0);

    signal countToAddress: std_logic_vector(4 downto 0):="00000";
    signal count_out: std_logic_vector(3 downto 0);
    signal valueAdder: std_logic_vector(8 downto 0);
    signal enableCUCount: std_logic;


begin

    countToAddress<= "0"&count_out; 

    ControlUnit: CUB port map(
        clk=> clk,
        reset=> reset,

        reqFromA=>reqfromA_sis,
        data_in_fromA=> data_in_fromA_sis,
        loadOperandfromA=> loadOperand_fromA_sis,
        
        data_fromMem=> memToCu,

        okToSend=> okToSend_sis,
        acktoA=> acktoA_sis,

        writeOnMem=> enableWrite,
        readfromMem=> enableRead,
        start_adding=> startAdder,
        count_signal=> enableCUCount,

        X=> dataX,
        Y=> dataY
    );

    Cont16: contMod16 port map(
        clk=> enableCUCount, --lo uso come conteggio
        reset=> reset, 

        cont=> count_out 
    
    );

    Adder: AdderStrings port map(
        X=>dataX,
        Y=> dataY,

        start_operation=>startAdder,

        data_out => valueAdder
    );

    MEMB: MEM port map(
        in_Mem => valueAdder, --è da 9 per considerare un bit di overflow 
        write_Mem => enableWrite,
        read_Mem=> enableRead,
        adress_Mem => countToAddress,
        
        dataread_out => memToCu
    );

    
end architecture rtl;
