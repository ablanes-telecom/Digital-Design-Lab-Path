-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity led_blinker_tb is
end led_blinker_tb;

architecture behave of led_blinker_tb is

      -- 25 MHz = 40 nanoseconds period
      constant c_CLOCK_PERIOD : time := 40 ns; 


	 -- Aquí estamos creando los "cables" que en teoría conectaríamos al chip
      signal r_CLOCK     : std_logic := '0';
      signal r_ENABLE    : std_logic := '0';
      signal r_SWITCH_1  : std_logic := '0';
      signal r_SWITCH_2  : std_logic := '0';
      signal w_LED_DRIVE : std_logic; 
    -- En el component descr
    component led_blinker is
      port (
        i_clock     : in  std_logic;
        i_enable    : in  std_logic;
        i_switch_1  : in  std_logic;
        i_switch_2  : in  std_logic;
        o_led       : out std_logic);
    end component led_blinker;
    
    begin
    -- Instantiate the Unit Under Test (UUT)
    --El port map es el acto de soldar los cables a los pines del chip.
    UUT : led_blinker
      port map (
        i_clock     => r_CLOCK,
        i_enable    => r_ENABLE,
        i_switch_1  => r_SWITCH_1,
        i_switch_2  => r_SWITCH_2,
        o_led       => w_LED_DRIVE
        );
               
    p_CLK_GEN : process is --es como si fuera un While (true) infinito
    begin
      wait for c_CLOCK_PERIOD/2;--estamos creando la señal cuadrada
      r_CLOCK <= not r_CLOCK;
    end process p_CLK_GEN; 

    process            -- main testing
    begin
      r_ENABLE <= '1';

      r_SWITCH_1 <= '0';
      r_SWITCH_2 <= '0';
      wait for 1 us;

      r_SWITCH_1 <= '0';
      r_SWITCH_2 <= '1';
      wait for 1 us;

      r_SWITCH_1 <= '1';
      r_SWITCH_2 <= '0';
      wait for 1 us;

      r_SWITCH_1 <= '1';
      r_SWITCH_2 <= '1';
      wait for 1 us;
	  assert false report "SIMULACION TERMINADA" severity failure;
    end process;

  end behave;
