library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity mPOPC is
    port (
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        selectionM: in std_logic
    );
end entity mPOPC;



architecture rtl of mPOPC is


    component controlUnit is port(
        clk : in std_logic;
        start: in std_logic; --segnale di start 
        reset : in std_logic; --segnale di reset 
        count : in std_logic_vector (3 downto 0); --conteggio del contatore
        
        
        reset_count : out std_logic;
        read : out std_logic; --segnale di read 
        write: out std_logic; --segnale di write
        write_count: out std_logic := '1' --segnale di aumento del conteggio  

    );
    end component;


    component contMod16 is port(
        clk : in std_logic;
        reset : in std_logic;

        cont: out std_logic_vector(3 downto 0) 

    ); 
    end component;

    component ROM is port(
        output : out std_logic_vector(7 downto 0);
        address : in std_logic_vector(3 downto 0);
        read : in std_logic

    );
    end component;

    component MEM is port(
        in_Mem : in STD_LOGIC_VECTOR(3 downto 0);
        write_Mem : in STD_LOGIC;
        adress_Mem : in STD_LOGIC_VECTOR(3 downto 0)

    );
    end component;

    component componentM is port(

        input_M : in std_logic_vector(7 downto 0);
        output_M: out std_logic_vector(3 downto 0);
        selection: in std_logic
        

    );
    end component;


    signal count_sig: std_logic_vector(3 downto 0);
    signal reset_count_sig: std_logic;
    signal read_sig: std_logic;
    signal write_sig: std_logic;
    signal write_count_sig: std_logic; --segnale per far avanzare il contatore

    signal romtoM : std_logic_vector(7 downto 0);
    signal mtoMem : std_logic_vector(3 downto 0);


    
begin

    controlUnit1: controlUnit port map(
        clk => clk,
        start => start,
        reset => reset,
        count => count_sig,

        reset_count => reset_count_sig,
        read => read_sig,
        write => write_sig,
        write_count => write_count_sig
    );

    Count: contMod16 port map(
        clk => write_count_sig,
        reset => reset_count_sig,

        cont=> count_sig
    );

    ROM168: ROM port map(
        output =>romtoM,
        address => count_sig,

        read=> read_sig

    );

    M: componentM port map(
        input_M => romtoM,
        output_M => mtoMem, 

        selection => selectionM
    );

    MEM164: MEM port map(
        in_Mem =>  mtoMem,
        write_Mem => write_sig,
        adress_Mem => count_sig

    );


    
    
    
end architecture rtl;