----------------------------------------------------------------------------------
-- Company:
-- Engineer: Robin Mueller
--
-- Create Date: 01/02/2022 11:56:56 PM
-- Design Name: Hardware blinky based on nandland tutorial
-- Module Name: blinky - Behavioral
-- Project Name:
-- Target Devices: Zedboard
-- Tool Versions: Vivado 2021.2
-- Description: VHDL implementation based on the nandland blinky
--     tutorial which can be found here:
--     https://www.nandland.com/vhdl/tutorials/tutorial-your-first-vhdl-program-part1.html
--
-- Dependencies: 
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity blinky is
generic(
    clk_freq_mhz: positive := 100
);
port(
    i_clock: in std_logic;
    i_enable: in std_logic;
    i_switch_0: in std_logic;
    i_switch_1: in std_logic;
    o_led_drive: out std_logic
);
end blinky;

architecture Behavioral of blinky is
    constant CLK_HALF_PERIOD_INT: positive := (1 * 1_000_000_000 / clk_freq_mhz / 2) * 1000;
    constant CLK_HALF_PERIOD: time := CLK_HALF_PERIOD_INT * 1ps;
    constant CLK_PERIOD: time:= CLK_HALF_PERIOD * 2;

    -- Constants to create the frequencies needed:
    -- Formula is: (25 MHz / 100 Hz * 50% duty cycle)
    constant RESET_COUNT_1_HZ: natural := (clk_freq_mhz * 1_000_000 / (1 * 2));
    constant RESET_COUNT_10_HZ: natural := (clk_freq_mhz * 1_000_000 / (10 * 2));
    constant RESET_COUNT_50_HZ: natural := (clk_freq_mhz * 1_000_000 / (50 * 2));
    constant RESET_COUNT_100_HZ: natural := (clk_freq_mhz * 1_000_000 / (100 * 2));

    signal counter_1_hz: natural range 0 to RESET_COUNT_1_HZ;
    signal counter_10_hz: natural range 0 to RESET_COUNT_10_HZ;
    signal counter_50_hz: natural range 0 to RESET_COUNT_50_HZ;
    signal counter_100_hz: natural range 0 to RESET_COUNT_100_HZ;

    signal toggle_1_hz: std_logic := '0';
    signal toggle_10_hz: std_logic := '0';
    signal toggle_50_hz: std_logic := '0';
    signal toggle_100_hz: std_logic := '0';

    signal w_led_select: std_logic;
begin

    -- All processes toggle a specific signal at a different frequency.
    -- They all run continuously even if the switches are
    -- not selecting their particular output.
    p_counter_1_hz : process(i_clock)
    begin
        if rising_edge(i_clock) then
            if (counter_1_hz = RESET_COUNT_1_HZ) then
                toggle_1_hz <= not toggle_1_hz;
                counter_1_hz <= 0;
            else
                counter_1_hz <= counter_1_hz + 1;
            end if;
        end if;
    end process;

    p_counter_10_hz : process(i_clock)
    begin
        if rising_edge(i_clock) then
            if (counter_10_hz = RESET_COUNT_10_HZ) then
                toggle_10_hz <= not toggle_10_hz;
                counter_10_hz <= 0;
            else
                counter_10_hz <= counter_10_hz + 1;
            end if;
        end if;
    end process;

    p_counter_50_hz : process(i_clock)
    begin
        if rising_edge(i_clock) then
            if (counter_50_hz = RESET_COUNT_50_HZ) then
                toggle_50_hz <= not toggle_50_hz;
                counter_50_hz <= 0;
            else
                counter_50_hz <= counter_50_hz + 1;
            end if;
        end if;
    end process;

    p_counter_100_hz : process(i_clock)
    begin
        if rising_edge(i_clock) then
            if (counter_100_hz = RESET_COUNT_100_HZ) then
                toggle_100_hz <= not toggle_100_hz;
                counter_100_hz <= 0;
            else
                counter_100_hz <= counter_100_hz + 1;
            end if;
        end if;
    end process;

    -- Multiplexer implementation, using conditional signal assignment
    w_led_select <= toggle_1_hz when (i_switch_0 = '0' and i_switch_1 = '0') else
        toggle_10_hz when (i_switch_0 = '0' and i_switch_1 = '1') else
        toggle_50_hz when (i_switch_0 = '1' and i_switch_1 = '0') else
        toggle_100_hz;
    -- Use AND gate here to only route signal if LED is enabled
    o_led_drive <= w_led_select and i_enable;
end Behavioral;
