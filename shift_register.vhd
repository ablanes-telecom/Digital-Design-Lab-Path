-- Code your design here
library ieee;
use ieee.std_logic_1164.all;

entity Desplazamiento is
    port (
        i_clock : in std_logic  -- que el clk entre desde fuera 
        );
end Desplazamiento;

architecture rtl of Desplazamiento is
    -- AQUÍ ESCRIBES TUS SEÑALES (Fuera del process)
    signal test1 : std_logic := '1';
    signal test2 : std_logic := '0';
    signal test3 : std_logic := '0';
    signal test4 : std_logic := '0';
begin

    -- AQUÍ ESCRIBES TU PROCESO
process (i_clock)
begin
	if rising_edge(i_clock) then
    	test2 <= test1;
        test3 <= test2;
        test4 <= test3;
	end if;
end process;

end rtl;