
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shiftregs is
    generic (
        n_bits : positive :=4
    );
    port (
        data_in : in std_logic_vector(n_bits-1 downto 0);
         --dati in ingresso 
        selection : in std_logic_vector(1 downto 0); --slezione dello shift, imposto 3 bit per permettere di avere 000 come "stato di quiete" del registro
        clk : in std_logic; --segnale per la sincronizzazione 
        reset : in std_logic; --segnale di reset

        external_zero: in std_logic; --segnale con valore 0 per shift
        enable_input: in std_logic; --enable per far scorrere l'input nei registri in maniera parallela
        enable_output: in std_logic; --enable per far scorrere l'ouput in maniera parallela 

        data_out : out std_logic_vector(n_bits downto 0) --dati in uscita
    );
end entity shiftregs;



architecture structural of shiftregs is


    component ffd is
        port(
            D : in std_logic;
            clk: in std_logic;
            reset: in std_logic;
    
            Q : out std_logic
        );
    end component;
    
    component mux_4_1 is
        port(

            input_4_1 : in STD_LOGIC_VECTOR (3 downto 0);

            control_4_1 : in STD_LOGIC_VECTOR (1 downto 0);

            y_4_1 : out STD_LOGIC
        );
    end component;
      
    component multi is
        port(

        a0 : in STD_LOGIC;
        a1 : in STD_LOGIC;
        
        s  : in STD_LOGIC;
        y  : out STD_LOGIC --filo singolo, possiamo anche definire un bus di fili (STD_LOGIC_VECTOR)

        );
    end component;
     

    -- SEGNALI DI INTERCONNESSIONE --
    signal memOuts: std_logic_vector(n_bits downto 0) := (others => '0'); --segnale di uscita dei registri in parallelo, serve anche per shift a destra di 1
    signal muxToMux: std_logic_vector(n_bits-1 downto 0); --collegamento tra multiplexer 4:1 e multiplexer 2:1
    signal muxToMem: std_logic_vector(n_bits-1 downto 0); --collegamento tra multiplexer 2:1 e registro 

    
    
begin

    
    
    gen: for i in 0 to n_bits-1 generate
    
            ff: ffd port map(
                D => muxToMem(i),
                clk => clk,
                reset => reset,
    
                Q => memOuts(i)
            );
            
            
        end generate;
    
    

    
    gen2: for i in 0 to n_bits-1 generate 

        muxs_2_1: multi port map(

            a0 => muxToMux(i),
            a1 => data_in(i),
            s=> enable_input,
            y=> muxToMem(i)

        );

    end generate;
   
           
    mux0: mux_4_1 port map(

    input_4_1(0) => external_zero, --di uno a sinistra
    input_4_1(1) => external_zero, --di due a sinistra 
    input_4_1(2) => memOuts(1), --di uno a destra 
    input_4_1(3) => memOuts(2), --di due a destra 
    
    control_4_1 => selection,

    y_4_1 => muxToMux(0)

    );
            
           

        
    mux1: mux_4_1 port map(
    input_4_1(0) => memOuts(0),
    input_4_1(1) => external_zero,
    input_4_1(2) => memOuts(2),
    input_4_1(3) => memOuts(3),
    
    
    control_4_1 => selection,
    
    y_4_1 => muxToMux(1)
    
    );

           
        

    muxn: mux_4_1 port map(

        input_4_1(0) => memOuts(n_bits-2),
        input_4_1(1) => memOuts(n_bits-3),
        input_4_1(2) => external_zero,
        input_4_1(3) => external_zero,
        
        control_4_1 => selection,

        y_4_1 => muxToMux(n_bits-1)
    );
        
           

    gen3: for i in 2 to n_bits-2 generate
        mux3: mux_4_1 port map(

            input_4_1(0) => memOuts(i-1),
            input_4_1(1) => memOuts(i-2),
            input_4_1(2) => memOuts(i+1),
            input_4_1(3) => memOuts(i+2),

            control_4_1 => selection,

            y_4_1 => muxToMux(i)
        );
    end generate;


    --gestione output
    data_out <= '-' & memOuts(n_bits-1 downto 0) when enable_output = '1' else
                (others => '-') ;



end architecture structural;