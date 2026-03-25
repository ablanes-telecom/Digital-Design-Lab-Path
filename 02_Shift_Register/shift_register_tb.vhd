-- Code your testbench here

library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture sim of testbench is
    signal clk : std_logic := '0';
begin
    -- Conectamos el diseño
    DUT: entity work.Desplazamiento port map (i_clock => clk);

    -- Generamos el reloj: cambia cada 5ns (ciclo de 10ns)
    clk <= not clk after 5 ns;

    -- Proceso para detener la simulación tras 100ns
    process
    begin
        wait for 100 ns;
        assert false report "Fin de la simulación" severity failure;
    end process;
end sim;
