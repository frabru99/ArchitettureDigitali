library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity riconoscitoristotsparz is
    port (
        y : out std_logic;
        i : in std_logic;
        clk : in std_ulogic;
        reset: in std_logic;
        m: in std_logic
    );
end entity riconoscitoristotsparz;



architecture oneprocesses of riconoscitoristotsparz is



    --stati

    type stati is (q0, q1, q2, q3, q4);

    signal stato_corrente : stati := q0; --signal stato corrente 

    
begin

    combinatory: process(clk)
    begin
        if(rising_edge(clk)) then

            if (reset = '1') then  --reset
                stato_corrente<=q0;
                y<='0';
            end if; 


            if ( m='1' ) then --sovrapposizione parziale
                if ( stato_corrente = q0 AND i ='1') then
                    stato_corrente <= q1;
                    y<='0';
                elsif (stato_corrente = q0 AND i='0') then
                    stato_corrente<= q0;
                    y<='0';
                elsif (stato_corrente = q1 AND i='0') then 
                    stato_corrente<= q2;
                    y<= '0';
                elsif (stato_corrente = q1 AND i = '1') then
                    stato_corrente <= q1;
                    y<='0';
                elsif(stato_corrente = q2 AND i='1') then
                    stato_corrente<= q0;
                    y<='1';
                elsif(stato_corrente=q2 AND i='0') then 
                    stato_corrente <= q0;
                    y<='0';
                end if; 

            else                                             
                    if(stato_corrente = q0 AND i ='1') then
                        stato_corrente <= q2; --corretto
                        y<='0';
                    elsif (stato_corrente = q0 AND i='0') then 
                        stato_corrente <= q1; --sempre sbagliato!
                        y<='0';
                    elsif(stato_corrente = q1 AND (i='0' OR i='1')) then
                        stato_corrente <= q4; --sempre sbagliato
                        y<='0';
                    elsif(stato_corrente=q4 AND (i='0' OR i='1')) then 
                        stato_corrente <= q0;
                        y<='0';
                    elsif( stato_corrente = q2 AND i ='1') then 
                        stato_corrente <= q4;
                        y<='0';
                    elsif(stato_corrente = q2 AND i='0') then 
                        stato_corrente <= q3;
                        y<='0';
                    elsif(stato_corrente=q3 AND i='1') then
                        stato_corrente<= q0;
                        y<='1';
                    elsif(stato_corrente=q3 AND i='0') then 
                        stato_corrente<=q0;
                        y<='0';
                    end if;

            end if;
        
        end if;
    end process combinatory;
 
end architecture oneprocesses;

