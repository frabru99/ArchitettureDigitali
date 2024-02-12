library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity EntityA is
    port (
        clk: in std_logic;
        start : in std_logic;
        reset: in std_logic;
        TXD_UART: out std_logic
    );
end entity EntityA;

architecture rtl of EntityA is

    component CU_A is port(
        clk: in std_logic;
        start : in std_logic;
        Write_UART: out std_logic;
        conteggio_attuale: in std_logic_vector(2 downto 0); --mi permette di controllare il valore cui è arrivato il contatore
        conteggio: out std_logic; --conteggio contatore ROM
        TBE_UART: in std_logic
    );
    end component;

    component counter_mod8 is port(
        clock : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        enable : in STD_LOGIC; --enable viene per ricominciare a contare in base ai segnali inviati da B
        counter : out  STD_LOGIC_VECTOR (2 downto 0)
    );
    end component;

    component ROM is port(
        output : out std_logic_vector(7 downto 0);

        address : in std_logic_vector(2 downto 0)
    );
    end component;

    component Rs232RefComp is port(					
    	TXD 	: out std_logic  	:= '1';
    	RXD : in std_logic;
    	CLK 	: in  std_logic;					--Master Clock
		DBIN 	: in  std_logic_vector (7 downto 0);--Data Bus in
		TBE	: inout std_logic 	:= '1';				--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
        RD      : in std_logic;       
		WR		: in  std_logic;					--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
		RST		: in  std_logic	:= '0'              --Master Reset
    );
    end component;

    signal counterToMem: std_logic_vector(2 downto 0); --collega l'uscita del counter con l'ingresso della ROM
    signal MemToUART: std_logic_vector(7 downto 0); --collega l'uscita della ROM con l'ingresso della UART
    signal CUtoCounter: std_logic; --comanda l'abilitazione del contatore per farlo ricominciare a contare
    signal UARTtoExit: std_logic_vector(7 downto 0);
    signal WriteCUtoUART : std_logic;
    signal TBECUtoUART: std_logic;

    
begin
    
    cont_mod8: counter_mod8 port map(
        clock => clk,
        reset => reset,
        enable => CUtoCounter,
        counter => counterToMem
    );

    ROM_A: ROM port map(
        address => counterToMem,
        output => MemToUART
    );

    UART: Rs232RefComp port map(
        TXD 	=> TXD_UART,
    	RXD => '1',
    	CLK 	=> clk,					--Master Clock
		DBIN 	=> MemToUART,--Data Bus in
		TBE	=> TBECUtoUART,			--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
        RD      =>  '1',     
		WR		=> WriteCUtoUART,					--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
		RST		=> reset 
    );

    CU_EntityA: CU_A port map(
        clk => clk,
        start => start,
        Write_UART => WriteCUtoUART,
        conteggio_attuale => counterToMem, --DA CONTROLLARE: NON SAPPIAMO SE SI POSSA CONDIVIDERE O MENO
        conteggio => CUtoCounter,
        TBE_UART => TBECUtoUART
    );

end architecture rtl;