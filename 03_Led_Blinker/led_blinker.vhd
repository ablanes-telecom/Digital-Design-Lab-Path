library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity led_blinker is 
    -- Los Generics permiten configurar el componente desde fuera
    generic (
        -- Valores por defecto para un reloj de 25 MHz (Frecuencias reales)
        g_CNT_100HZ : natural := 125000;
        g_CNT_50HZ  : natural := 250000;
        g_CNT_10HZ  : natural := 1250000;
        g_CNT_1HZ   : natural := 12500000
    );
    port (
        i_clock    : in  std_logic; -- Reloj maestro
        i_enable   : in  std_logic; -- Habilitador global
        i_switch_1 : in  std_logic; -- Switch de selección 1
        i_switch_2 : in  std_logic; -- Switch de selección 2
        o_led      : out std_logic  -- Salida al LED
    );
end led_blinker;

architecture rtl of led_blinker is 
    -- Señales de los contadores (el rango se ajusta según los Generics)
    signal r_CNT_100HZ : natural range 0 to g_CNT_100HZ;
    signal r_CNT_50HZ  : natural range 0 to g_CNT_50HZ;
    signal r_CNT_10HZ  : natural range 0 to g_CNT_10HZ;
    signal r_CNT_1HZ   : natural range 0 to g_CNT_1HZ;

    -- Señales que conmutan (toggles) para generar las frecuencias
    signal r_TOGGLE_100HZ : std_logic := '0';
    signal r_TOGGLE_50HZ  : std_logic := '0';
    signal r_TOGGLE_10HZ  : std_logic := '0';
    signal r_TOGGLE_1HZ   : std_logic := '0';

    -- Cable interno para la selección del multiplexor
    signal w_LED_SELECT : std_logic;
    
begin

    ---------------------------------------------------------
    -- PROCESOS: Divisores de frecuencia en paralelo
    ---------------------------------------------------------

    -- Generador de 100 Hz
    p_100_HZ : process (i_clock) is
    begin
        if rising_edge(i_clock) then
            if r_CNT_100HZ = g_CNT_100HZ-1 then
                r_TOGGLE_100HZ <= not r_TOGGLE_100HZ;
                r_CNT_100HZ    <= 0;
            else
                r_CNT_100HZ <= r_CNT_100HZ + 1;
            end if;
        end if;
    end process;

    -- Generador de 50 Hz
    p_50_HZ : process (i_clock) is
    begin
        if rising_edge(i_clock) then
            if r_CNT_50HZ = g_CNT_50HZ-1 then
                r_TOGGLE_50HZ <= not r_TOGGLE_50HZ;
                r_CNT_50HZ    <= 0;
            else
                r_CNT_50HZ <= r_CNT_50HZ + 1;
            end if;
        end if;
    end process;

    -- Generador de 10 Hz
    p_10_HZ : process (i_clock) is
    begin
        if rising_edge(i_clock) then
            if r_CNT_10HZ = g_CNT_10HZ-1 then
                r_TOGGLE_10HZ <= not r_TOGGLE_10HZ;
                r_CNT_10HZ    <= 0;
            else
                r_CNT_10HZ <= r_CNT_10HZ + 1;
            end if;
        end if;
    end process;

    -- Generador de 1 Hz
    p_1_HZ : process (i_clock) is
    begin
        if rising_edge(i_clock) then
            if r_CNT_1HZ = g_CNT_1HZ-1 then
                r_TOGGLE_1HZ <= not r_TOGGLE_1HZ;
                r_CNT_1HZ    <= 0;
            else
                r_CNT_1HZ <= r_CNT_1HZ + 1;
            end if;
        end if;
    end process;

    ---------------------------------------------------------
    -- LÓGICA COMBINACIONAL: Selección y Salida
    ---------------------------------------------------------

    -- Multiplexor para seleccionar la frecuencia según los switches
    w_LED_SELECT <= r_TOGGLE_100HZ when (i_switch_1 = '0' and i_switch_2 = '0') else
                    r_TOGGLE_50HZ  when (i_switch_1 = '0' and i_switch_2 = '1') else
                    r_TOGGLE_10HZ  when (i_switch_1 = '1' and i_switch_2 = '0') else
                    r_TOGGLE_1HZ;    

    -- Salida final condicionada por el i_enable (Puerta AND)
    o_led <= w_LED_SELECT and i_enable;

end rtl;
