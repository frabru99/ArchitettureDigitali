library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity parteOperativa is
    port (

        in_porta_1 : in STD_LOGIC_VECTOR(1 downto 0);
        in_porta_2 : in STD_LOGIC_VECTOR(1 downto 0);

        out_porta_1 : out STD_LOGIC_VECTOR(1 downto 0);
        out_porta_2 : out STD_LOGIC_VECTOR(1 downto 0);

        --La selezione la decide la control unit 
        s_source : in STD_LOGIC;
        s_des : in STD_LOGIC
    );
end entity parteOperativa;

architecture rtl of parteOperativa is

    component mux_2_1 is 
        port(
            in_2_1_porta_1 : in STD_LOGIC_VECTOR(1 downto 0);
            in_2_1_porta_2 : in STD_LOGIC_VECTOR(1 downto 0);
            out_2_1 : out STD_LOGIC_VECTOR(1 downto 0);
            s_2_1 : in STD_LOGIC
        );
    end component;

    component demux_1_2 is 
        port(
            in_1_2 : in STD_LOGIC_VECTOR(1 downto 0);
            out_1_2_porta_1 : out STD_LOGIC_VECTOR(1 downto 0);
            out_1_2_porta_2 : out STD_LOGIC_VECTOR(1 downto 0);
            s_1_2 : in STD_LOGIC
        );
    end component;

    --Segnale interconnessione tra mux e demux
    signal muxToDemux : STD_LOGIC_VECTOR(1 downto 0);
    
begin

    mux_switch : mux_2_1
        port map(
            in_2_1_porta_1 => in_porta_1,
            in_2_1_porta_2 => in_porta_2,
            out_2_1 => muxToDemux,
            s_2_1 => s_source
            );
    
    demux_switch : demux_1_2
        port map(
            in_1_2 => muxToDemux,
            out_1_2_porta_1 => out_porta_1,
            out_1_2_porta_2 => out_porta_2,
            s_1_2 => s_des
            );
    
end architecture rtl;