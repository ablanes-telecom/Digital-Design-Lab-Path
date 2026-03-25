library IEEE;
use IEEE.std_logic_1164.all;

entity led_blinker_tb is
end led_blinker_tb;

architecture behave of led_blinker_tb is
    -- Constante para simular un reloj de 25 MHz (Periodo de 40 ns)
    constant c_CLOCK_PERIOD : time := 40 ns; 

    -- Señales para conectar al diseño bajo prueba (UUT)
    signal r_CLOCK     : std_logic := '0';
    signal r_ENABLE    : std_logic := '0';
    signal r_SWITCH_1  : std_logic := '0';
    signal r_SWITCH_2  : std_logic := '0';
    signal w_LED_DRIVE : std_logic; 

begin

    ---------------------------------------------------------
    -- INSTANCIACIÓN: Conexión del diseño
    ---------------------------------------------------------
    -- Usamos Generic Map para poner límites pequeños (solo para simular)
    UUT : entity work.led_blinker
        generic map (
            g_CNT_100HZ => 10,   -- Cambiamos 125,000 por 10
            g_CNT_50HZ  => 20,   -- Cambiamos 250,000 por 20
            g_CNT_10HZ  => 50,
            g_CNT_1HZ   => 100
        )
        port map (
            i_clock    => r_CLOCK,
            i_enable   => r_ENABLE,
            i_switch_1 => r_SWITCH_1,
            i_switch_2 => r_SWITCH_2,
            o_led      => w_LED_DRIVE
        );

    ---------------------------------------------------------
    -- GENERACIÓN DE RELOJ: Bucle infinito
    ---------------------------------------------------------
    p_CLK_GEN : process is
    begin
        wait for c_CLOCK_PERIOD/2;
        r_CLOCK <= not r_CLOCK;
    end process; 

    ---------------------------------------------------------
    -- ESTÍMULOS: Pruebas principales
    ---------------------------------------------------------
    p_STIMULUS : process
    begin
        -- Habilitamos el sistema
        r_ENABLE <= '1';
        
        -- Probar Selección 00 (Frecuencia más alta)
        r_SWITCH_1 <= '0'; r_SWITCH_2 <= '0';
        wait for 2 us;
        
        -- Probar Selección 01 (Frecuencia media-alta)
        r_SWITCH_1 <= '0'; r_SWITCH_2 <= '1';
        wait for 2 us;

        -- Probar Selección 10 (Frecuencia media-baja)
        r_SWITCH_1 <= '1'; r_SWITCH_2 <= '0';
        wait for 4 us;

        -- Probar Selección 11 (Frecuencia más baja)
        r_SWITCH_1 <= '1'; r_SWITCH_2 <= '1';
        wait for 8 us;

        -- Fin de la simulación (Truco para EDA Playground)
        assert false report "Simulación completada con éxito" severity failure;
        wait;
    end process;

end behave;
