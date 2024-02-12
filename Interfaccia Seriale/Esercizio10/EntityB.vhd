library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity EntityB is
    port (
        clk: in std_logic;
        reset: in std_logic;
        uscita_mem: out std_logic_vector(7 downto 0);
        RXD_UART_B: in std_logic
    );
end entity EntityB;

architecture rtl of EntityB is
    
    component MEM_B is port(
        in_Mem : in STD_LOGIC_VECTOR(7 downto 0);
        write_Mem : in STD_LOGIC;
        adress_Mem : in STD_LOGIC_VECTOR(2 downto 0);
        outMem : out  STD_LOGIC_VECTOR(7 downto 0)
        
    );        
    end component;

    component counter_mod8 is port(
        clock : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        enable : in STD_LOGIC; --enable viene per ricominciare a contare in base ai segnali inviati da B
        counter : out  STD_LOGIC_VECTOR (2 downto 0)
    );
    end component;

    component Rs232RefComp is port(
    	RXD 	: in  std_logic;					
    	CLK 	: in  std_logic;
        DBIN: in std_logic_vector (7 downto 0);		--Master Clock
		DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
		RDA	: inout std_logic;						--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
		RD	: in  std_logic;	
        WR :  in std_logic;				--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
		RST		: in  std_logic	:= '0'              --Master Reset
    );
    end component;			
        
    component CU_B is port(
        clk: in std_logic;
        conteggio_attuale: in std_logic_vector(2 downto 0);
        conteggio: out std_logic;
        read_UART: out std_logic;
        RDA_UART: in std_logic;
        Write_on_Mem: out std_logic;
        reset_Uart: out std_logic
    );
    end component;

    signal UARTtoMEM : std_logic_vector(7 downto 0);
    signal writeCUtoMEM: std_logic;
    signal CounterTOMem : std_logic_vector(2 downto 0);
    signal CUtoCounter: std_logic;
    signal readCUtoUART : std_logic;
    signal RDACUtoUART: std_logic;

    signal reset_UART_sig: std_logic;

    
begin
    
    memoria_B: MEM_B port map(
        in_Mem => UARTtoMEM,
        write_Mem => writeCUtoMEM,
        adress_Mem => CounterTOMem,
        outMem => uscita_mem
        
    );

    contatore_B : counter_mod8 port map(
        clock => clk,
        reset => reset,
        enable => CUtoCounter,--enable viene per ricominciare a contare in base ai segnali inviati da B
        counter => CounterTOMem
    );

    UART_EntityB : Rs232RefComp port map(
        RXD => RXD_UART_B,					
    	CLK => clk,
        DBIN => (others => '0'), 	--Master Clock
		DBOUT => UARTtoMEM,	--Data Bus out
		RDA	=> RDACUtoUART,						--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
		RD	=> readCUtoUART,	
        WR => '0',				--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
		RST=> reset_UART_sig              --Master Reset
    );

    CU_EntityB : CU_B port map(
        clk => clk,
        conteggio_attuale => CounterTOMem,
        conteggio => CUtoCounter,
        read_UART => readCUtoUART,
        RDA_UART => RDACUtoUART,
        Write_on_Mem => writeCUtoMEM,
        reset_Uart => reset_UART_sig
        
    );



end architecture rtl;