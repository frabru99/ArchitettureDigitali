library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tbcontMod60 is
end entity tbcontMod60;

architecture tb of tbcontMod60 is
    signal clk : std_logic := '0';
    signal set : std_logic := '0';
    signal input_loaded : std_logic_vector(5 downto 0) := (others => '0');
    signal reset : std_logic := '0';
    signal cont : std_logic_vector(5 downto 0);
    signal fullCount : std_logic;

    component contMod60 is
        port (
            clk : in std_logic;
            set: in std_logic;
            input_loaded: in std_logic_vector(5 downto 0);
            reset : in std_logic;
            cont: out std_logic_vector(5 downto 0);
            fullCount: out std_logic
        );
    end component contMod60;

begin
    dut: contMod60 port map (
        clk => clk,
        set => set,
        input_loaded => input_loaded,
        reset => reset,
        cont => cont,
        fullCount => fullCount
    );

    clk_process :process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    stim_proc: process
    begin
        -- Aggiungi qui la tua sequenza di stimoli
        
       wait for 23 ns;
       input_loaded<="111011"; 
       set<='1';
       wait for 10 ns;
       set<='0';
       wait for 50 ns;
       reset <= '1';
       wait for 5 ns;
       reset <= '0';
        
        wait;
    end process;

end architecture tb;
