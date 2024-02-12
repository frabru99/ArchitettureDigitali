library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Sistema is
    port (
        clk: in std_logic;
        start_sis: in std_logic;
        reset_sis : in std_logic;
        dato_uscita: out std_logic_vector(7 downto 0)
    );
end entity Sistema;

architecture rtl of Sistema is
    
    component EntityA is port(
        clk: in std_logic;
        start : in std_logic;
        reset: in std_logic;
        TXD_UART: out std_logic
    );
    end component;

    component EntityB is port(
        clk: in std_logic;
        reset: in std_logic;
        uscita_mem: out std_logic_vector(7 downto 0);
        RXD_UART_B: in std_logic
    );
    end component;

    signal TXDtoRXD : std_logic;

begin
    
    A: EntityA port map(
        clk => clk,
        start => start_sis,
        reset => reset_sis,
        TXD_UART => TXDtoRXD
    );

    B : EntityB port map(
        clk => clk,
        reset => reset_sis,
        uscita_mem => dato_uscita,
        RXD_UART_B => TXDtoRXD
        
    );
    
end architecture rtl;