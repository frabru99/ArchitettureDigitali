library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity SistemaA is
    port (
        clk_sis: in std_logic;
        start_sis: in std_logic;
        
        okToSend_sis: in std_logic;
        ackfromB_sis: in std_logic;

        reset: in std_logic; 

        reqToSend_sis: out std_logic;
        data_out_sis: out std_logic_vector(8 downto 0);
        load_Operand_sis: out std_logic

        
    );
end entity SistemaA;

architecture rtl of SistemaA is


    component ROM is port(
        output : out std_logic_vector(8 downto 0);

        address : in std_logic_vector(3 downto 0);
        read : in std_logic
    );
    end component;

    component contMod16 is 
        generic(
            n_bits : positive :=4
        );
        port(
        clk : in std_logic; --segnale di conteggio
        reset : in std_logic;

        cont: out std_logic_vector(n_bits-1 downto 0) 
    );
    end component;

    component CUA is port(
        clk: in std_logic;
        start: in std_logic;
        okToSend: in std_logic; --comunicazione
        ackfromB: in std_logic;
        data_in: in std_logic_vector(8 downto 0);
        reset: in std_logic;

        --comunicazione
        reqToSend: out std_logic;
        data_out: out std_logic_vector(8 downto 0); 
        load_OperandtoB: out std_logic;
        
        --conteggio e lettura
        readfromCutoRom: out std_logic;
        countA: out std_logic --segnale di conteggio
    );
    end component;


    signal ROMtoCU: std_logic_vector(8 downto 0);
    signal counttoAddress: std_logic_vector(3 downto 0);

    signal readFromCu: std_logic:='1';
    signal countSignal: std_logic:='1';
    
begin

    ROM_sis: ROM port map(
        output=> ROMtoCU,
        address=> counttoAddress,

        read=> readFromCu
    );

    Cont16: contMod16 port map(
        clk=> countSignal,
        reset=> reset,

        cont=> counttoAddress
    );

    ControlUnit: CUA port map(
        clk=> clk_sis,
        start=> start_sis,
        reset=> reset,

        okToSend=>okToSend_sis,
        ackfromB=>ackfromB_sis,
        load_OperandtoB=> load_Operand_sis,

        data_in=> ROMtoCU,

        reqToSend=> reqToSend_sis,
        data_out=>data_out_sis,

        readFromCutoRom=> readFromCu,
        countA=> countSignal


    );
    
end architecture rtl;